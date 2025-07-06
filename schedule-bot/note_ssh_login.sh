#!/bin/bash

. /etc/.tgbot.env

msg=$1

tg_msg="{\"parse_mode\": \"markdown\", \"chat_id\": \"$chat_id\", \"text\": \"${msg}\", \"disable_web_page_preview\": true}"

curl -X POST -H 'Content-Type: application/json' -d "$tg_msg" $tgbot