#!/bin/bash

# Google Chat Webhook URL (replace with your actual URL)
WEBHOOK_URL="https://chat.googleapis.com/v1/spaces/....................."

HOSTNAME="$1"
SERVICEDESC="$2"
SERVICESTATE="$3"
SERVICEOUTPUT="$4"

# Get the current time in GMT and IST
DATETIME_GMT=$(TZ="GMT" date)
DATETIME_IST=$(TZ="Asia/Kolkata" date)

# Define emojis for different states
WARNING_EMOJI="⚠️"
CRITICAL_EMOJI="❗"
RECOVERY_EMOJI='☑️'

# Determine the appropriate emoji based on the service state
case "$SERVICESTATE" in
  "WARNING")
    EMOJI=$WARNING_EMOJI
    ;;
  "CRITICAL")
    EMOJI=$CRITICAL_EMOJI
    ;;
  "RECOVERY")
    EMOJI=$RECOVERY_EMOJI
    ;;
  *)
    EMOJI=""
    ;;
esac

# Create the message for Google Chat
MESSAGE="*****  Nagios Alert $EMOJI *****  
GMT Date/Time: $DATETIME_GMT
IST Date/Time: $DATETIME_IST
Host: $HOSTNAME
Service: $SERVICEDESC
State: $SERVICESTATE
Details: $SERVICEOUTPUT"

# Send the message to Google Chat
if ! curl -X POST "$WEBHOOK_URL" -H "Content-Type: application/json" -d "{ \"text\": \"$MESSAGE\" }"; then
  echo "Failed to send message to Google Chat"
  exit 1
fi

