### Hardware Notifications

#### For when you need notifications IRL

![](https://cloud.githubusercontent.com/assets/883126/5623631/f2a54bb8-9524-11e4-93fe-063487faa27f.gif)

This project is built using some wires, two LEDs a spark core and jq.

##### Spark core setup

You will need to get your spark device id and access token from

https://www.spark.io/build/new#settings
and your device id from
https://www.spark.io/build/new#cores

##### Gitter setup

Get your gitter token from
https://developer.gitter.im/apps

To get your user id

```bash
curl -H "Accept: application/json" -H "Authorization: Bearer GITTER_TOKEN" "https://api.gitter.im/v1/user" | jq .[].id
```

##### App Setup

Ensure you have jq installed, if not
`$ brew install jq`

Get the following information and either modify app.sh or export the following ENV vars.

```
gh_username= GH_USERNAME || ""
gh_password= GH_PASSWORD || ""
spark_device_id= SPARK_DEVICE_ID || ""
spark_access_token=SPARK_ACCESS_TOKEN || ""
gitter_token=GITTER_TOKEN || ""
gitter_user_id=GITTER_USER_ID || ""
```

##### Running

`$ ./app.sh`

.. Ideas? Improvements? PR or Issues are more than welcome!

