#!/bin/bash

# If you dont want to set your info in your ENV
# just set them on the right inside of the quotes
gh_username=${GH_USERNAME-""}
gh_password=${GH_PASSWORD-""}
spark_device_id=${SPARK_DEVICE_ID-""}
spark_access_token=${SPARK_ACCESS_TOKEN-""}
gitter_token=${GITTER_TOKEN-""}
gitter_user_id=${GITTER_USER_ID-""}

notifications ()
{
  github_notifications
  gitter_notifications
  sleep 60
  notifications
}

github_notifications ()
{
  echo "checking github"
  count=$(curl -s "https://${gh_username}:${gh_password}@api.github.com/notifications" | jq '. | length')

  if [ "$count" -gt "0" ]
  then
    curl -s "https://api.spark.io/v1/devices/${spark_device_id}/digitalwrite" -d access_token="${spark_access_token}" -d params=D5,HIGH > /dev/null
  else
    curl -s "https://api.spark.io/v1/devices/${spark_device_id}/digitalwrite" -d access_token="${spark_access_token}" -d params=D5,LOW > /dev/null
  fi
}

gitter_notifications ()
{
  echo "checking gitter"
  unread=$(curl -s -H "Accept: application/json" \
  -H "Authorization: Bearer ${gitter_token}" "https://api.gitter.im/v1/user/${gitter_user_id}/rooms" \
  | jq '.[] | select(.lurk == false) | select(.unreadItems > 0) | .unreadItems')

  if [ -n "$unread"  ]
  then
    curl -s "https://api.spark.io/v1/devices/${spark_device_id}/digitalwrite" -d access_token="${spark_access_token}" -d params=D0,HIGH > /dev/null
  else
    curl -s "https://api.spark.io/v1/devices/${spark_device_id}/digitalwrite" -d access_token="${spark_access_token}" -d params=D0,LOW > /dev/null
  fi
}

notifications
