FROM almir/webhook
MAINTAINER Adrian Harabula <adrian.harabula@gmail.com>

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh
