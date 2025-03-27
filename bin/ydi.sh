#!/bin/sh

# Check if arguments were provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 URL1 [URL2] [URL3] ..."
  echo "Example: $0 https://www.youtube.com/watch?v=dQw4w9WgXcQ"
  exit 1
fi

# Process each URL provided as an argument
for url in "$@"; do
  echo "Processing URL: $url"
  echo "Available formats:"
  
  # Display available formats
  yt-dlp -q -F "$url"
  
  # Ask user to choose format
  echo ""
  echo "Enter desired format (leave empty for best format):"
  read user_input
  
  # Download with selected format or with best format by default
  if [ -z "$user_input" ]; then
    echo "Downloading with best format..."
    yt-dlp "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" "$url"
  else
    echo "Downloading with format: $user_input"
    yt-dlp -f "$user_input" "$url"
  fi
  
  echo "Download completed for $url"
  echo "-----------------------------------"
done

echo "All downloads completed."
