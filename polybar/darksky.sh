#!/bin/bash

LATLNG="42.353,-71.061"
KEY=e38b46c8cc805db9076e3034646c570e

JSON=`curl https://api.darksky.net/forecast/$KEY/$LATLNG?units=si 2> /dev/null`

TEMP=`echo $JSON | jq '.currently.temperature'`
SUMM=`echo $JSON | jq -r '.currently.summary'`

echo ${TEMP}C/$SUMM

