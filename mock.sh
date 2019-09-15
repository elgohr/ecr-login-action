#!/bin/sh

parameters="$@"
if [ "${parameters}" = "configure" ]; then
  read READ_ACCESS_KEY
  if [ "${READ_ACCESS_KEY}" != "${INPUT_ACCESS_KEY}" ]; then
    echo "ACCESS_KEY didn't match input: ${READ_ACCESS_KEY}"
    exit 1
  fi
  read READ_SECRET_ACCESS_KEY
  if [ "${READ_SECRET_ACCESS_KEY}" != "${INPUT_SECRET_ACCESS_KEY}" ]; then
    echo "SECRET_ACCESS_KEY didn't match input: ${READ_SECRET_ACCESS_KEY}"
    exit 1
  fi
  read READ_REGION
  if [ "${READ_REGION}" != "${INPUT_REGION}" ]; then
    echo "REGION didn't match input: ${READ_REGION}"
    exit 1
  fi
  read READ_TYPE
  if [ "${READ_TYPE}" != "text" ]; then
    echo "TYPE didn't match input: ${READ_TYPE}"
    exit 1
  fi
else
  echo "docker login -u USERNAME -p PASSWORD https://amazonaws.com"
fi
exit 0
