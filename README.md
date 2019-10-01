# ECR-Login-Action

[![Actions Status](https://github.com/elgohr/ecr-login-action/workflows/Test/badge.svg)](https://github.com/elgohr/ecr-login-action/actions)

This Action for Docker logs into [AWS ECR](https://aws.amazon.com/de/ecr/) and gets the timely bound credentials for Docker.

## Usage

## Example pipeline

```
name: Publish Docker
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Login to ECR
      id: ecr
      uses: elgohr/ecr-login-action@master
      with:
        access_key: ${{ secrets.AWS_ACCESS_KEY }}
        secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        region: ${{ secrets.AWS_REGION }}
    - name: Publish to Registry
      uses: elgohr/Publish-Docker-Github-Action@master
      with:
        name: myDocker/repository
        username: ${{ steps.ecr.outputs.username }}
        password: ${{ steps.ecr.outputs.password }}
        registry: ${{ steps.ecr.outputs.registry }}
```

## Mandatory arguments

`access_key` is the AWS access key  
`secret_access_key` is the AWS secret access key  
`region` the region you would like to login to  
