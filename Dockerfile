FROM python:3.14.0b2-alpine3.20 as runtime
LABEL "repository"="https://github.com/elgohr/ecr-login-action"
LABEL "maintainer"="Lars Gohr"

RUN pip install awscli 
RUN apk add --no-cache bash jq 

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM runtime as test
RUN apk add --no-cache coreutils bats ncurses
ADD test.bats /test.bats
ADD mock.sh /usr/local/bin/aws
RUN /test.bats
