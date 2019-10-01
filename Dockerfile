FROM alpine as runtime
LABEL "com.github.actions.name"="AWS ECR Docker Login"
LABEL "com.github.actions.description"="Logs into ECR and provides Docker credentials"
LABEL "com.github.actions.icon"="log-in"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="https://github.com/elgohr/ecr-login-action"
LABEL "maintainer"="Lars Gohr"

RUN apk update \
  && apk upgrade \
  && apk add --no-cache python py-pip bash jq \
  && pip install awscli  \
  && apk --purge -v del py-pip

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM runtime as test
RUN apk add --no-cache coreutils bats ncurses
ADD test.bats /test.bats
ADD mock.sh /usr/bin/aws
RUN /test.bats

FROM runtime
