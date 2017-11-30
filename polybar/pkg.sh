#!/bin/bash

which aptitude &> /dev/null

if [ "$?" == "0" ]; then
  sudo aptitude update &> /dev/null
  CMD="aptitude search ~U"
else
  CMD="checkupdates"
fi

$CMD | wc -l

