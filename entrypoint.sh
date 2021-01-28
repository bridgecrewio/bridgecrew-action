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
export BC_FROM_BRANCH=${GIT_BRANCH}
export BC_TO_BRANCH=${GITHUB_BASE_REF}
export BC_PR_ID=$(echo $GITHUB_REF | awk 'BEGIN { FS = "/" } ; { print $3 }')
export BC_PR_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/pull/${BC_PR_ID}"
export BC_COMMIT_HASH=${GITHUB_SHA}
export BC_COMMIT_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA}"
export BC_AUTHOR=${GIT_AUTHOR_NAME}
export BC_RUN_ID=${GITHUB_RUN_NUMBER}
export BC_RUN_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_NUMBER}"
export BC_REPOSITORY_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}"

echo "BC_FROM_BRANCH=${GIT_BRANCH}"
echo "BC_TO_BRANCH=${GITHUB_BASE_REF}"
echo "BC_PR_ID=$(echo $GITHUB_REF | awk 'BEGIN { FS = "/" } ; { print $3 }')"
echo "BC_PR_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/pull/${BC_PR_ID}""
echo "BC_COMMIT_HASH=${GITHUB_SHA}"
echo "BC_COMMIT_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/commit/${GITHUB_SHA}""
echo "BC_AUTHOR=${GIT_AUTHOR_NAME}"
echo "BC_RUN_ID=${GITHUB_RUN_NUMBER}"
echo "BC_RUN_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_NUMBER}""
echo "BC_REPOSITORY_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}""

echo "input_soft_fail:$INPUT_SOFT_FAIL"
if [ -z "$INPUT_SOFT_FAIL"]; then
    echo "::add-matcher::bridgecrew-problem-matcher.json"
    else
    echo "::add-matcher::bridgecrew-problem-matcher-warning.json"
fi


cmd="bridgecrew --bc-api-key $API_KEY_VARIABLE --branch $GIT_BRANCH --repo-id $GITHUB_REPOSITORY -d $INPUT_DIRECTORY $CHECK_FLAG $SKIP_CHECK_FLAG $QUIET_FLAG $SOFT_FAIL_FLAG $EXTERNAL_CHECKS_DIR_FLAG $OUTPUT_FLAG"
echo $cmd

if [ -n "$API_KEY_VARIABLE" ]; then
  bridgecrew --bc-api-key $API_KEY_VARIABLE --branch $GIT_BRANCH --repo-id $GITHUB_REPOSITORY -d $INPUT_DIRECTORY $CHECK_FLAG $SKIP_CHECK_FLAG $QUIET_FLAG $SOFT_FAIL_FLAG $EXTERNAL_CHECKS_DIR_FLAG $OUTPUT_FLAG
  else
  bridgecrew -d $INPUT_DIRECTORY $CHECK_FLAG $SKIP_CHECK_FLAG $QUIET_FLAG $EXTERNAL_CHECKS_DIR_FLAG $OUTPUT_FLAG $SOFT_FAIL_FLAG
fi
