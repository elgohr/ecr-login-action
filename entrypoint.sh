#!/usr/bin/env bash
set -e

export AWS_ACCESS_KEY_ID=$INPUT_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$INPUT_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$INPUT_REGION

authTokenOutput=$(aws ecr get-authorization-token)
authString=$(echo "$authTokenOutput" | jq -r '.authorizationData[].authorizationToken' | base64 -d)
USERNAME=$(echo "$authString" | cut -d: -f1)
PASSWORD=$(echo "$authString" | cut -d: -f2)
REGISTRY=$(echo "$authTokenOutput" | jq -r '.authorizationData[].proxyEndpoint')
DOCKER_NAME=$(echo "$REGISTRY" | sed 's/https:\/\///g')

if [ -z "$USERNAME" ]; then
  USERNAME="AWS"
fi

echo "username=${USERNAME}" >> "$GITHUB_OUTPUT"
echo "::add-mask::${PASSWORD}"
echo "password=${PASSWORD}" >> "$GITHUB_OUTPUT"
echo "registry=${REGISTRY}" >> "$GITHUB_OUTPUT"
echo "docker_name=${DOCKER_NAME}" >> "$GITHUB_OUTPUT"
