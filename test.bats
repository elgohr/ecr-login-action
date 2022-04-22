#!/usr/bin/env bats

@test "it returns the username, password and registry" {
  run /entrypoint.sh

    local expected='>>> elgohr/ecr-login-action@master is deprecated!
>>> Please switch to elgohr/ecr-login-action@v2 for more speed and less dependencies
::set-output name=username::AWS
::add-mask::AUTH_PASSWORD
::set-output name=password::AUTH_PASSWORD
::set-output name=registry::https://ACCOUNTID.dkr.ecr.us-east-1.amazonaws.com
::set-output name=docker_name::ACCOUNTID.dkr.ecr.us-east-1.amazonaws.com'
    echo $output
    [ "$output" = "$expected" ]
}
