#!/bin/sh
set -eu

EXT=".tar.gz"

ROOT_DIR="${1:-${PWD}}"

LATEST_VERSION=$(curl -s https://api.github.com/repos/VSCodium/vscodium/releases/latest | jq -r '.tag_name')
test -n "$LATEST_VERSION"
LATEST_URL="https://github.com/VSCodium/vscodium/releases/download/${LATEST_VERSION}/VSCodium-linux-x64-${LATEST_VERSION}${EXT}"
LATEST_ARTIFACT="${ROOT_DIR}/$(basename "${LATEST_URL}")"

if [ ! -f "${LATEST_ARTIFACT}" ]; then
    echo "Download version ${LATEST_VERSION} from ${LATEST_URL}"
    wget -q "${LATEST_URL}" -O "${LATEST_ARTIFACT}"
else
    echo "Version ${LATEST_VERSION} is already downloaded: ${LATEST_ARTIFACT}"
fi

INSTALL_DIR="${LATEST_ARTIFACT%$EXT}"
if [ ! -d "${INSTALL_DIR}" ]; then
    echo "Extract ${LATEST_ARTIFACT} to ${INSTALL_DIR}"
    mkdir "${INSTALL_DIR}"
    tar -C "${INSTALL_DIR}" -xzf "${LATEST_ARTIFACT}"
else
    echo "Version ${LATEST_VERSION} is already installed in ${INSTALL_DIR}"
fi

DESKTOP_FILE="${HOME}/.local/share/applications/VSCodium.desktop"
if [ -d "$(dirname "${DESKTOP_FILE}")" ]; then
    echo "Generate desktop file ${DESKTOP_FILE}"
    echo "[Desktop Entry]
Name=VSCodium
Type=Application
Exec=${INSTALL_DIR}/codium
Icon=${INSTALL_DIR}/resources/app/resources/linux/code.png
Comment=VSCodium ${LATEST_VERSION}
Terminal=false
NoDisplay=false
Categories=Development;IDE" | tee "${DESKTOP_FILE}"
fi

