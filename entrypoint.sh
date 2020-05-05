#!/bin/bash

NONE=none
SUPPRESS=${SOFT_FAIL}
OUTPUT=${OUTPUT}
DIRECTORY=${DIRECTORY}
FILE=${FILE}
API_KEY=${API_KEY_VARIABLE}

CMD_STR="bridgecrew -o $OUTPUT"
if [[ $FILE == $NONE ]] && [[ $DIRECTORY == $NONE ]]; then
  echo "file or directory must be provided"
  exit 1
elif [[ $FILE != $NONE ]] && [[ $DIRECTORY != $NONE ]]; then
  echo "cannot provide file and directory, chose only one"
  exit 1
fi
if [ $SUPPRESS == 'true' ]; then
  CMD_STR="$CMD_STR -s"
fi
if [ $FILE != $NONE ]; then
  CMD_STR="$CMD_STR -f $FILE"
fi
if [ $DIRECTORY != $NONE ]; then
  CMD_STR="$CMD_STR -d $DIRECTORY"
fi
#if [ -n "$API_KEY" ]; then
#  CMD_STR="$CMD_STR --bc-api-key $API_KEY --repo-id ${GITHUB_REF##*/}"
#fi
echo "running bridgecrew with command: $CMD_STR"
echo $CMD_STR | sh