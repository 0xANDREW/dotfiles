#!/bin/bash

LATLNG="42.353,-71.061"
KEY=$DARKSKY_API_KEY

JSON=`curl https://api.darksky.net/forecast/$KEY/$LATLNG?units=si 2> /dev/null`

TEMP=`echo $JSON | jq '.currently.temperature'`
SUMM=`echo $JSON | jq -r '.currently.summary'`

echo ${TEMP}C/$SUMM

