#!/bin/bash

matcher_path=`pwd`/bridgecrew-problem-matcher.json
cp /usr/local/lib/bridgecrew-problem-matcher.json "$matcher_path"
echo "::add-matcher::bridgecrew-problem-matcher.json"

[[ ! -z "$INPUT_CHECK" ]] && CHECK_FLAG="--check $INPUT_CHECK"
[[ ! -z "$INPUT_SKIP_CHECK" ]] && SKIP_CHECK_FLAG="--skip-check $INPUT_SKIP_CHECK"
[[ ! -z "$INPUT_QUIET" ]] && QUIET_FLAG="--quiet"
[[ ! -z "$INPUT_SOFT_FAIL" ]] && SOFT_FAIL_FLAG="--soft-fail"

NONE=none

API_KEY=${API_KEY_VARIABLE}

CMD_STR="bridgecrew -o $OUTPUT"

if [ -n "$API_KEY_VARIABLE" ]; then
  bridgecrew --bc-api-key $API_KEY_VARIABLE --branch ${GITHUB_REF##*/} --repo-id $GITHUB_REPOSITORY -d $INPUT_DIRECTORY $CHECK_FLAG $SKIP_CHECK_FLAG $QUIET_FLAG $SOFT_FAIL_FLAG --source github-action
  else
  bridgecrew -d $INPUT_DIRECTORY $CHECK_FLAG $SKIP_CHECK_FLAG $QUIET_FLAG
fi
