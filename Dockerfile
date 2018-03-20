FROM python:3.6.4-alpine3.7
LABEL maintainer="Alexey Diyan <alexey.diyan@gmail.com>"

ENV MYCLI_VERSION=1.16.0 SETPROCTITLE_VERSION=1.1.10
# py-setproctitle workaround: https://github.com/dvarrazzo/py-setproctitle/issues/44
RUN set -x \
  && buildDeps='build-base openssl' \
  && buildDepsEdge='libffi-dev openssl-dev' \
  && apk add --no-cache $buildDeps \
  && apk add --no-cache $buildDepsEdge --repository https://dl-3.alpinelinux.org/alpine/edge/main/ \
  && wget -O /tmp/py-setproctitle.tar.gz https://github.com/dvarrazzo/py-setproctitle/archive/version-$SETPROCTITLE_VERSION.tar.gz \
  && tar -xzvf /tmp/py-setproctitle.tar.gz -C /tmp \
  && cd /tmp/py-setproctitle-version-$SETPROCTITLE_VERSION/ \
  && sed -i 's:#include <linux/prctl.h>://#include <linux/prctl.h>:' ./src/spt_status.c \
  && python setup.py install \
  && pip install mycli==${MYCLI_VERSION} \
  && apk del $buildDeps $buildDepsEdge \
  && rm -rf /tmp/py-setproctitle*

ENTRYPOINT ["/usr/local/bin/mycli"]
CMD ["--help"]
