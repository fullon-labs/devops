# Purpose

notify a tgbot group upon every ssh login session to a target Linux host

# Procedures

1. log onto the target linux host 
1. create `/etc/.tgbot.env` file with tgbot settings
1. modify `/etc/profile` by adding following scripts onto the very bottom of this file

```bash
if [ -n "$SSH_CLIENT" ]; then
   source /etc/.tgbot.env
   TEXT="$(date): ssh login to ${USER}@$(hostname -f)"
   TEXT="$TEXT from $(echo $SSH_CLIENT|awk '{print $1}')"
   TEXT="{\"parse_mode\": \"markdown\", \"chat_id\": \"$chat_id\", \"text\": \"${TEXT}\", \"disable_web_page_preview\": true}"
   $CURL -H "$ctType" -d "$TEXT $tgbotSendUrl
fi
```

# voila!

* `.tgbot.env` template content:

```INI
token='XXX' #replace it with actual value
chat_id='-YYY' #replace it with actual value
tgbotSendUrl="https://api.telegram.org/bot${token}/sendMessage"
tgbotUpdateUrl="https://api.telegram.org/bot${token}/getUpdates"
ctType='Content-Type: application/json'
CURL="curl -s -o /dev/null -X POST"
```