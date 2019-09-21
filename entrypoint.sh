#!/usr/bin/env bash
set -e

aws configure <<-EOF
$INPUT_ACCESS_KEY
$INPUT_SECRET_ACCESS_KEY
$INPUT_REGION
text
EOF

connectionString=$(aws ecr get-login)
cleanedConnection=$(echo $connectionString | sed -e "s/docker login -u //g" | sed -e "s/ -p//g" | sed -e "s/ -e none//g")
connectionParts=($cleanedConnection)

if [ -z "${connectionParts[0]}" ]; then
  USERNAME="AWS"
else
  USERNAME="${connectionParts[0]}"
fi

echo ::set-output name=username::"${USERNAME}"
echo ::set-output name=password::"${connectionParts[1]}"
echo ::set-output name=registry::"${connectionParts[2]}"
