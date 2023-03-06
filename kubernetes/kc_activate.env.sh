##
## This file is meant to be sourced by your current shell
##  $ source kc_activate.sh
##  $ kc_activate --help
##

_kc_usage() {
    echo "
Usage: kc_activate [-k PATH_TO_AGE_KEY] [-c PATH_TO_ENCRYPTED_KUBECONFIG] [-i] [-h]

Options:
    -h      print this help message
    -c      path to the sops encrypted kubeconfig file
            default value is './kubeconfig.yaml'
    -k      path to the age key, can be clear or passphrase protected
            default is '~/.age/key.txt'
    -i      do not use fifo mode for sops
            usefull when KUBECONFIG is read more than once like with k9s or kustomize

Example:
    \$ kc_activate -c ~/.kube/cluster.sops.yaml 
    \$ kc_activate -c ~/.kube/cluster.sops.yaml -k ~/.age/my-key.txt

    if you want to load you age key first, use
    \$ export SOPS_AGE_KEY=\$(age -d ~/.age/key.txt_encrypted)
    \$ export SOPS_AGE_KEY_FILE=~/.age/key.txt

"
}

_kc_exec() {
    if [ ! -r "$KC_ENCRYPTED_KUBECONFIG" ]; then
        echo "💥 Cannot find encrypted kubeconfig: $KC_ENCRYPTED_KUBECONFIG"
        return 1
    fi
    sops exec-file $KC_SOPS_ARGS "$KC_ENCRYPTED_KUBECONFIG" "KUBECONFIG={} $*"
}

kc_deactivate() {
    if [ -z "$KC_ENCRYPTED_KUBECONFIG" ]; then
        echo "💥 No encrypted kubeconfig is use"
        return 1
    fi
    PS1="$KC_OLD_PS1"
    unset KC_OLD_PS1
    unset KC_ENCRYPTED_KUBECONFIG
    unset KC_SOPS_ARGS
    unset SOPS_AGE_KEY
    unalias kubectl
    unalias k9s
}

kc_activate() {
    if [ -n "$KC_ENCRYPTED_KUBECONFIG" ]; then
        echo "💥 An encrypted kubeconfig is already is use: $KC_ENCRYPTED_KUBECONFIG"
        echo "   Use 'kc_deactivate' to deactivate it first"
        return 1
    fi

    local _KC_ENCRYPTED_KUBECONFIG="./kubeconfig.yaml"
    local _KC_AGE_KEY_FILE="$HOME/.age/key.txt"
    local _KC_SOPS_ARGS=""

    while getopts "c:k:ih" OPTION; do
        case $OPTION in 
            c) _KC_ENCRYPTED_KUBECONFIG="$OPTARG";;
            k) _KC_AGE_KEY_FILE="$OPTARG";;
            i) _KC_SOPS_ARGS="--no-fifo";;
            h) _kc_usage; return 0;;
            *) _kc_usage; return 1;;
        esac
    done

    if [ ! -r "$_KC_ENCRYPTED_KUBECONFIG" ]; then
        echo "💥 Cannot find encrypted kubeconfig: $_KC_ENCRYPTED_KUBECONFIG"
        _kc_usage
        return 2
    elif ! grep -q '^sops:' "$_KC_ENCRYPTED_KUBECONFIG"; then
        echo "💥 Kubeconfig file is not sops encrypted: $_KC_ENCRYPTED_KUBECONFIG"
        _kc_usage
        return 2
    fi

    if [ -n "$SOPS_AGE_KEY" ]; then
        echo "🔒 Using existing \$SOPS_AGE_KEY"
    elif [ -r "$SOPS_AGE_KEY_FILE" ]; then
        echo "🔒 Using existing \$SOPS_AGE_KEY_FILE=$SOPS_AGE_KEY_FILE"
    elif [ -r "$_KC_AGE_KEY_FILE" ]; then
        if head -1 "$_KC_AGE_KEY_FILE" | grep -q 'BEGIN AGE ENCRYPTED FILE'; then
            echo "🔐 Using passphrase protected age key file: $_KC_AGE_KEY_FILE"
            SOPS_AGE_KEY=$(age -d "$_KC_AGE_KEY_FILE")
            if [ -z "$SOPS_AGE_KEY" ]; then
                echo "💥 Cound not decrypt Age key: $_KC_AGE_KEY_FILE"
                return 2
            fi
            export SOPS_AGE_KEY
        else
            echo "🔓 Using clear age key file: $_KC_AGE_KEY_FILE"
            export SOPS_AGE_KEY_FILE="$_KC_AGE_KEY_FILE"
        fi
    else
        echo "💥 Cannot find SOPS_AGE_KEY, you need to load your age key first: export SOPS_AGE_KEY=\$(age -d ~/.age/your_key.txt)"
        _kc_usage
        return 3
    fi
    
    KC_OLD_PS1="$PS1"
    PS1="[👻 $(basename "$_KC_ENCRYPTED_KUBECONFIG")] $PS1"

    KC_ENCRYPTED_KUBECONFIG="$_KC_ENCRYPTED_KUBECONFIG"
    KC_SOPS_ARGS="$_KC_SOPS_ARGS"
    alias kubectl="_kc_exec kubectl"
    alias k9s="_kc_exec k9s"
    echo ""
}
