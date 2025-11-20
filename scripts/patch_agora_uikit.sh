#!/usr/bin/env bash
set -euo pipefail

PACKAGE_VERSION="agora_uikit-1.3.8"
PACKAGE_ROOT="${PUB_CACHE:-$HOME/.pub-cache}/hosted/pub.dev/${PACKAGE_VERSION}"
TARGET_FILE="${PACKAGE_ROOT}/lib/controllers/rtc_event_handlers.dart"

if [[ ! -f "${TARGET_FILE}" ]]; then
  echo "agora_uikit ${PACKAGE_VERSION} not found at expected path: ${TARGET_FILE}" >&2
  exit 0
fi

if grep -q "onExtensionError" "${TARGET_FILE}"; then
  echo "Removing deprecated onExtensionError handler from ${TARGET_FILE}" >&2
  # Remove the onExtensionError named parameter from the RtcEngineEventHandler instantiation
  sed -i "/onExtensionError/d" "${TARGET_FILE}"
  echo "Patch applied successfully." >&2
else
  echo "onExtensionError handler already removed; no changes applied." >&2
fi
