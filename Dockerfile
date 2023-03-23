FROM alpine

RUN apk add --no-cache bash
RUN apk --no-cache add curl
RUN curl -o- https://raw.githubusercontent.com/transifex/cli/master/install.sh | bash

FROM python:2-alpine

COPY --from=0 /tx /bin/tx
#RUN set -ex && pip install transifex-client
