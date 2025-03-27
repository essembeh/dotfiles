#!/bin/sh
set -eu

TARGET=${1:-.}
echo "Reset chmod in: $TARGET"
find "$TARGET/" -type f -exec chmod -v 644 {} \;
find "$TARGET/" -type d -exec chmod -v 755 {} \;
find "$TARGET/" -regex ".*\.\(sh\|bin\|run\)" -type f -exec chmod -v +x {} \;

