#!/usr/bin/env bats

@test "it returns the username, password and registry" {
  run /entrypoint.sh

    local expected='::set-output name=username::USERNAME
::set-output name=password::PASSWORD
::set-output name=registry::https://amazonaws.com'
    echo $output
    [ "$output" = "$expected" ]
}
