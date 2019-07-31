FROM python:2-alpine

RUN set -ex && pip install transifex-client
