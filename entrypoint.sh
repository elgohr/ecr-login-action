#!/usr/bin/env bash
set -e

aws configure <<-EOF
$INPUT_ACCESS_KEY
$INPUT_SECRET_ACCESS_KEY
$INPUT_REGION
text
EOF

authTokenOutput=$(aws ecr get-authorization-token)
authString=$(echo "$authTokenOutput" | jq -r '.authorizationData[].authorizationToken' | base64 -d)
USERNAME=$(echo "$authString" | cut -d: -f1)
PASSWORD=$(echo "$authString" | cut -d: -f2)
REGISTRY=$(echo "$authTokenOutput" | jq -r '.authorizationData[].proxyEndpoint')

if [ -z "$USERNAME" ]; then
  USERNAME="AWS"
fi

echo "::set-output name=username::${USERNAME}"
echo "::add-mask::${PASSWORD}"
echo "::set-output name=password::${PASSWORD}"
echo "::set-output name=registry::${REGISTRY}"
