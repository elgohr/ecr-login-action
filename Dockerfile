FROM alpine as runtime
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
