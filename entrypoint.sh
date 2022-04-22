#!/usr/bin/env bash
set -e

echo ">>> elgohr/ecr-login-action@master is deprecated!"
echo ">>> Please switch to elgohr/ecr-login-action@v2 for more speed and less dependencies"

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

echo "::set-output name=username::${USERNAME}"
echo "::add-mask::${PASSWORD}"
echo "::set-output name=password::${PASSWORD}"
echo "::set-output name=registry::${REGISTRY}"
echo "::set-output name=docker_name::${DOCKER_NAME}"
