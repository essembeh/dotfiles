#!/bin/sh
# dc runs docker-compose with all docker-compose YML files found in current folder
set -eu

docker-compose $(find . -mindepth 1 -maxdepth 1 \( -name "docker-compose*.yml" -or -name "docker-compose*.yaml" \) -exec echo -n "-f {} " \;) "$@"
