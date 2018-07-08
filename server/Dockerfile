ARG   ALPINE_VERSION
FROM  alpine:${ALPINE_VERSION}
LABEL maintainer=jon@jaggersoft.com

# - - - - - - - - - - - - - - -
# install ruby+
# tar is needed to tar-pipe test coverage out of tmpfs.
# - - - - - - - - - - - - - - -

RUN apk --update --no-cache add \
    bash \
    ruby-bundler \
    ruby-dev \
    tar

# - - - - - - - - - - - - - - -
# install ruby gems
# - - - - - - - - - - - - - - -

ARG             STARTER_HOME
COPY Gemfile  ${STARTER_HOME}/
WORKDIR       ${STARTER_HOME}

RUN apk --update add --virtual build-dependencies build-base \
  && bundle config --global silence_root_warning 1 \
  && bundle install \
  && gem clean \
  && apk del build-dependencies build-base \
  && rm -vrf /var/cache/apk/*

# - - - - - - - - - - - - - - -
# setup server
# - - - - - - - - - - - - - - -

COPY . ${STARTER_HOME}
RUN  chown -R nobody:nogroup ${STARTER_HOME}
USER nobody

# - - - - - - - - - - - - - - - - -
# git commit sha image is built from
# - - - - - - - - - - - - - - - - -

ARG SHA
RUN echo ${SHA} > ${STARTER_HOME}/sha.txt

ARG PORT
EXPOSE ${PORT}
ENV PORT=${PORT}

CMD [ "./up.sh" ]

