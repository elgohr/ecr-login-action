#!/usr/bin/env bats

setup(){
  export GITHUB_OUTPUT="/tmp/githubOutput"
}

@test "it returns the username, password and registry" {
  run /entrypoint.sh

  expectGitHubOutputContains "username=AWSpassword=AUTH_PASSWORDregistry=https://ACCOUNTID.dkr.ecr.us-east-1.amazonaws.comdocker_name=ACCOUNTID.dkr.ecr.us-east-1.amazonaws.com"
  local expected='::add-mask::AUTH_PASSWORD'
    echo $output
    [ "$output" = "$expected" ]
}

expectGitHubOutputContains() {
  local expected=$(echo "${1}" | tr -d '\n')
  local got=$(cat "${GITHUB_OUTPUT}" | tr -d '\n')
  echo "Expected: |${expected}|
  Got: |${got}|"
  echo "${got}" | grep "${expected}"
}