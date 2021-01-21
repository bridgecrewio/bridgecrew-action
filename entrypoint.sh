#!/bin/bash

matcher_path=`pwd`/bridgecrew-problem-matcher.json
warning_matcher_path=`pwd`/bridgecrew-problem-matcher-warning.json
cp /usr/local/lib/bridgecrew-problem-matcher.json "$matcher_path"
cp /usr/local/lib/bridgecrew-problem-matcher-warning.json "$warning_matcher_path"

export BC_SOURCE=githubActions

[[ ! -z "$INPUT_CHECK" ]] && CHECK_FLAG="--check $INPUT_CHECK"
[[ ! -z "$INPUT_SKIP_CHECK" ]] && SKIP_CHECK_FLAG="--skip-check $INPUT_SKIP_CHECK"
[[ ! -z "$INPUT_QUIET" ]] && QUIET_FLAG="--quiet"
[[ ! -z "$INPUT_SOFT_FAIL" ]] && SOFT_FAIL_FLAG="--soft-fail"
[[ ! -z "$EXTERNAL_CHECKS_DIR" ]] && EXTERNAL_CHECKS_DIR_FLAG="--external-checks-dir $EXTERNAL_CHECKS_DIR"
[[ ! -z "$INPUT_OUTPUT_FORMAT" ]] && OUTPUT_FLAG="-o $INPUT_OUTPUT_FORMAT"

NONE=none

API_KEY=${API_KEY_VARIABLE}

CMD_STR="bridgecrew -o $OUTPUT"
GIT_BRANCH=${GITHUB_HEAD_REF:=master}
ls
echo "input_soft_fail:$INPUT_SOFT_FAIL"

#double negative doesnt help
if [ ! -z "$INPUT_SOFT_FAIL" ]; then
    echo "::add-matcher::bridgecrew-problem-matcher.json"
    else
    echo "::add-matcher::bridgecrew-problem-matcher-warning.json"
fi

#see what command was executed inside the logic
if [ -n "$API_KEY_VARIABLE" ]; then
  echo "bridgecrew --bc-api-key $API_KEY_VARIABLE --branch $GIT_BRANCH --repo-id $GITHUB_REPOSITORY -d $INPUT_DIRECTORY $CHECK_FLAG $SKIP_CHECK_FLAG $QUIET_FLAG $SOFT_FAIL_FLAG $EXTERNAL_CHECKS_DIR_FLAG $OUTPUT_FLAG"
  bridgecrew --bc-api-key $API_KEY_VARIABLE --branch $GIT_BRANCH --repo-id $GITHUB_REPOSITORY -d $INPUT_DIRECTORY $CHECK_FLAG $SKIP_CHECK_FLAG $QUIET_FLAG $SOFT_FAIL_FLAG $EXTERNAL_CHECKS_DIR_FLAG $OUTPUT_FLAG
  else
  echo "bridgecrew -d $INPUT_DIRECTORY $CHECK_FLAG $SKIP_CHECK_FLAG $QUIET_FLAG $EXTERNAL_CHECKS_DIR_FLAG $OUTPUT_FLAG $SOFT_FAIL_FLAG"
  bridgecrew -d $INPUT_DIRECTORY $CHECK_FLAG $SKIP_CHECK_FLAG $QUIET_FLAG $EXTERNAL_CHECKS_DIR_FLAG $OUTPUT_FLAG $SOFT_FAIL_FLAG
fi
