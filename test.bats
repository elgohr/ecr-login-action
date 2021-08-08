#!/usr/bin/env bats

@test "it returns the username, password and registry" {
  run /entrypoint.sh

    local expected='::set-output name=username::AWS
::add-mask::AUTH_PASSWORD
::set-output name=password::AUTH_PASSWORD
::set-output name=registry::https://ACCOUNTID.dkr.ecr.us-east-1.amazonaws.com
::set-output name=docker_name::ACCOUNTID.dkr.ecr.us-east-1.amazonaws.com'
    echo $output
    [ "$output" = "$expected" ]
}
