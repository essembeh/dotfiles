#!/usr/bin/env bash
# Secure file extraction script
# Safely extracts archives with protection against path traversal and other security issues

# Exit on error, undefined variables, and pipe failures
set -euo pipefail

# Define color codes for better readability
readonly COLOR_RESET="\033[0m"
readonly COLOR_RED="\033[0;31m"
readonly COLOR_GREEN="\033[0;32m"
readonly COLOR_YELLOW="\033[0;33m"
readonly COLOR_BLUE="\033[0;34m"
readonly COLOR_MAGENTA="\033[0;35m"
readonly COLOR_CYAN="\033[0;36m"
readonly COLOR_WHITE="\033[1;37m"

# Print colored messages
print_info() {
    echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $1"
}

print_success() {
    echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} $1"
}

print_warning() {
    echo -e "${COLOR_YELLOW}[WARNING]${COLOR_RESET} $1" >&2
}

print_error() {
    echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} $1" >&2
}

print_header() {
    local text="$1"
    local width=60
    local padding=$(( (width - ${#text} - 2) / 2 ))
    local line=$(printf '%*s' "$width" | tr ' ' '=')
    
    echo -e "\n${COLOR_CYAN}${line}${COLOR_RESET}"
    echo -e "${COLOR_CYAN}=$(printf '%*s' "$padding" '')${COLOR_WHITE} $text ${COLOR_CYAN}$(printf '%*s' "$padding" '')=${COLOR_RESET}"
    echo -e "${COLOR_CYAN}${line}${COLOR_RESET}\n"
}

# Function to safely extract files
extract_safely() {
    local input_file="$1"
    local extract_dir="$2"
    
    # Validate file exists and is readable
    if [[ ! -f "$input_file" || ! -r "$input_file" ]]; then
        print_error "Cannot access file '$input_file'"
        return 1
    fi
    
    # Extract based on file extension
    print_info "Extracting $(basename -- "$input_file")..."
    case "${input_file,,}" in  # lowercase comparison
        *.tar|*.tar.*|*.tgz)
            # Use --no-same-owner to avoid privilege escalation
            # Use --no-absolute-names to prevent path traversal
            tar --no-same-owner --no-absolute-names -C "$extract_dir" -xavf "$input_file"
            ;;
        *)
            # For 7z, we need to handle path traversal after extraction
            7z x -o"$extract_dir" "$input_file"
            ;;
    esac
    
    print_success "Extraction completed"
    return 0
}

# Function to sanitize extracted content
sanitize_extraction() {
    local dir="$1"
    local security_issues=0
    
    print_info "Performing security checks on extracted content..."
    
    # Find and remove any files with absolute paths or path traversal attempts
    find "$dir" -type f -name "*" | while read -r file; do
        # Get the relative path within the extraction directory
        local rel_path="${file#"$dir/"}"
        
        # Check for path traversal attempts (../ or /../)
        if [[ "$rel_path" == *"../"* || "$rel_path" == *"/../"* ]]; then
            print_warning "Removing file with suspicious path: $rel_path"
            rm -f "$file"
            ((security_issues++))
        fi
        
        # Check for absolute paths
        if [[ "$rel_path" == /* ]]; then
            print_warning "Removing file with absolute path: $rel_path"
            rm -f "$file"
            ((security_issues++))
        fi
    done
    
    # Check for and handle symbolic links
    find "$dir" -type l | while read -r link; do
        local target=$(readlink "$link")
        
        # Remove links pointing outside the extraction directory or to absolute paths
        if [[ "$target" == /* || "$target" == *".."* ]]; then
            print_warning "Removing symbolic link with suspicious target: $link -> $target"
            rm -vf "$link"
            ((security_issues++))
        fi
    done
    
    if [[ $security_issues -gt 0 ]]; then
        print_warning "Removed $security_issues potentially malicious items"
    else
        print_success "No security issues found in extracted content"
    fi
}

# Main extraction logic
for FILE in "$@"; do
    print_header "PROCESSING: $(basename -- "$FILE")"
    
    # Skip if not a file
    if [[ ! -f "$FILE" ]]; then
        print_error "'$FILE' is not a file or doesn't exist"
        continue
    fi
    
    # Create a unique target folder for extraction using mktemp for security
    FILENAME=$(basename -- "$FILE")
    WORKDIR=$(mktemp -d "./${FILENAME}.XXXXXXXXXX")
    print_info "Created temporary directory: ${COLOR_MAGENTA}$WORKDIR${COLOR_RESET}"
    
    # Extract the file
    if extract_safely "$FILE" "$WORKDIR"; then
        # Sanitize the extracted content
        sanitize_extraction "$WORKDIR"
        
        # Check if archive only contains one folder/file
        mapfile -t CONTENTS < <(find "$WORKDIR" -mindepth 1 -maxdepth 1)
        
        if [[ ${#CONTENTS[@]} -eq 1 && -e "${CONTENTS[0]}" ]]; then
            SINGLE_ITEM=$(basename -- "${CONTENTS[0]}")
            if [[ ! -e "./$SINGLE_ITEM" ]]; then
                print_info "Moving single item to current directory"
                mv -n "${CONTENTS[0]}" "./$SINGLE_ITEM"
                rmdir -v "$WORKDIR"
                print_success "Extracted: ${COLOR_MAGENTA}./$SINGLE_ITEM${COLOR_RESET}"
            else
                print_warning "Target './$SINGLE_ITEM' already exists, keeping in extraction directory"
                print_success "Extracted to: ${COLOR_MAGENTA}$WORKDIR${COLOR_RESET}"
            fi
        else
            # Try to rename the target folder
            TARGET="./${FILENAME%.*}"
            if [[ $FILENAME == *.tar.* ]]; then
                TARGET="./${FILENAME%.tar.*}"
            fi
            
            if [[ ! -e "$TARGET" ]]; then
                print_info "Renaming extraction directory to $TARGET"
                mv -n "$WORKDIR" "$TARGET"
                print_success "Extracted to: ${COLOR_MAGENTA}$TARGET${COLOR_RESET}"
            else
                print_warning "Target '$TARGET' already exists, keeping temporary directory name"
                print_success "Extracted to: ${COLOR_MAGENTA}$WORKDIR${COLOR_RESET}"
            fi
        fi
    else
        print_error "Extraction failed for $FILE"
        rmdir -v "$WORKDIR" 2>/dev/null || true
    fi
    
    echo -e "${COLOR_CYAN}$(printf '%*s' "60" | tr ' ' '-')${COLOR_RESET}\n"
done
