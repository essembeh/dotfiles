#!/usr/bin/env bash
# dorun.sh - Docker run helper script

# Function to display usage information
usage() {
    echo "Usage: $0 [options] <image> [command]"
    echo ""
    echo "Options:"
    echo "  -h, --help    Display this help message"
    echo ""
    echo "Examples:"
    echo "  $0 ubuntu:latest bash"
    exit 1
}

# Check if an image was specified
if [[ $# -lt 1 ]]; then
    echo "Error: No Docker image specified"
    usage
fi

# Base docker run command with common options
DOCKER_CMD="docker run --rm -t -i \
    --volume \"$HOME:/target/home:ro\" \
    --volume /tmp:/target/tmp \
    --volume \"$PWD:/target/pwd\" \
    --workdir /target/pwd"

# Add the image and any additional arguments
DOCKER_CMD="$DOCKER_CMD $@"

# Execute the command
eval $DOCKER_CMD
