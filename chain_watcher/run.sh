#!/bin/bash

cd ~/watcher

source .env

#now=$(date)

v_repo="$1_repo"
repo="${!v_repo}"
repo_url="https://github.com/$repo"

v_curr="$1_curr"
curr="${!v_curr}"

on=$2
[ -z "$on" ] && on="off"

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

notify_tg_watcher() {
  curl -X POST \
     -H 'Content-Type: application/json' \
     -d '{"chat_id": "'$tg_chat_id'", "text": "'$1'\n Latest:       '$2' \n Current:    '$3' ", "disable_notification": true}' \
     https://api.telegram.org/bot${tg_bot_token}/sendMessage
}

latest=$(get_latest_release $repo)

if [ "$latest" != "$curr" ] || [ "$on" = "on" ]; then
  notify_tg_watcher "$repo_url/releases" $latest $curr
fi
