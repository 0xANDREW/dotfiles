#!/bin/bash

which aptitude &> /dev/null

if [ "$?" == "0" ]; then
  CMD="aptitude search ~U"
else
  CMD="checkupdates"
fi

$CMD | wc -l

