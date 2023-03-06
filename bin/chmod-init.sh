#!/bin/sh
set -eu

TARGET=${1:-.}
echo "Reset chmod in: $TARGET"
find "$TARGET/" -type f -exec chmod 644 {} \;
find "$TARGET/" -type d -exec chmod 755 {} \;
find "$TARGET/" -regex ".*\.\(sh\|bin\|run\|pl\|py\|lua\)" -type f -exec chmod -v +x {} \;

