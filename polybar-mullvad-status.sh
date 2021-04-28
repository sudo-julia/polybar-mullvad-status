#!/usr/bin/env bash
set -euo pipefail

# format mullvad status to a better looking printable format
mullvad_status="$( mullvad status | cut -d' ' -f2-3 | sed 's/status:/VPN/' )"

# log the most recent mullvad status
status_file="${XDG_CONFIG_HOME}/polybar/.mullvad_status.last"

# create the status file if it doesn't exist
if [[ ! -s "${status_file}" ]]; then
  echo "${mullvad_status}" > "${status_file}"
fi
last_status="$( cat "${status_file}" )"

send_notification() {
  # if the vpn's status changed, notify the user
  if [[ "${last_status}" != "$1" ]]; then
    echo "$1" | tee "${status_file}" \
    && notify-send "$1"
  fi
}

send_notification "$mullvad_status"
