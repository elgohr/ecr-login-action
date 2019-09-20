#!/usr/bin/env bats

@test "it returns the username, password and registry" {
  run /entrypoint.sh

    local expected='::set-output name=username::AWS
::set-output name=password::PASSWORD
::set-output name=registry::https://dkr.ecr.amazonaws.com'
    echo $output
    [ "$output" = "$expected" ]
}
