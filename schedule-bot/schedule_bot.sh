#!/bin/bash

. ./.schedule_bot.env
#. ./.schedules.env
export TZ=Hongkong

CSV_URL=https://raw.githubusercontent.com/truedex-labs/ops-reminders/main/schedules.csv
wget -q -O /tmp/sch.csv $CSV_URL

tgbot="https://api.telegram.org/bot${token}/sendMessage"

function doSchedule()
{
  while IFS= read -r line
  do
    IFS=':' read -ra kv <<< "$line"
    stime="${kv[0]}"
    stitle="${kv[1]}"

    msg="Ops Reminder: \n  【 $stitle 】\n    Expired: $stime"

    cond=$(( $(date -d "$stime" +%s)  ))
    now=$(date +%s)
    [[ $now -ge $cond ]] && sendMsg "$msg"

  done < /tmp/sch.csv
}

function sendMsg()
{
  msg=$1
  content="{\"parse_mode\": \"markdown\", \"chat_id\": \"$chatId\", \"text\": \"$msg\", \"disable_web_page_preview\": true}" \
         && curl --silent --output /dev/null -X POST -H 'Content-Type: application/json' -d "$content" $tgbot
}

doSchedule