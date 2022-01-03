FROM alpine:3.9

RUN apk update

# Install base and dev packages
RUN apk add --no-cache --virtual .build-deps
RUN apk add bash

# Install build packages
RUN apk add make && apk add curl && apk add openssh

# install npm package handler
RUN apk add nodejs-npm

# Install zip
RUN apk add zip

# Install nodejs
RUN apk add nodejs

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Install aws-cli
RUN apk -Uuv add groff less python3 py3-pip py-pip python
#RUN pip install --upgrade pip
RUN pip3 install pytest
RUN pip3 install requests
RUN pip3 install boto3 freezegun
RUN pip3 install awscli
RUN apk --purge -v del py3-pip
RUN rm /var/cache/apk/*

COPY . .

WORKDIR /deployment

ENV AWS_REGION us-east-1
ENV VERSION 3.1.0
ENV SOLUTION_NAME waf-v2


RUN chmod 777 run-unit-tests.sh
RUN ./run-unit-tests.sh
RUN chmod 777 build-s3-dist.sh
RUN chmod 777 init.sh
RUN ./build-s3-dist.sh $TEMPLATE_OUTPUT_BUCKET $DIST_OUTPUT_BUCKET $SOLUTION_NAME $VERSION

ENTRYPOINT ["./init.sh"]
