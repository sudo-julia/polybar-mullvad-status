#!/usr/bin/env bash
set -eo pipefail

# format mullvad status to a better looking printable format
mullvad_status="$( mullvad status | cut -d' ' -f3 )"

# log the most recent mullvad status
if [[ "${POLYBAR_MULLVAD_STATUSFILE}" ]]; then
    status_file="${POLYBAR_MULLVAD_STATUSFILE}"
else
    status_file="/tmp/mullvad_status.last"
fi

# create the status file if it doesn't exist
if [[ ! -s "${status_file}" ]]; then
    echo "${mullvad_status}" > "${status_file}"
fi

last_status="$( cat "${status_file}" )"

# TODO make a way to display the notification if the status hasn't changed (at launch)
send_notification() {
    # if the vpn's status changed, notify the user
    if [[ "${last_status}" != "$1" ]]; then
        echo "$1" | tee "${status_file}" \
        && notify-send "$1"
    fi
}

send_notification "VPN $mullvad_status"
