FROM  cyberdojo/rack-base
LABEL maintainer=jon@jaggersoft.com

# - - - - - - - - - - - - - - -
# setup client
# - - - - - - - - - - - - - - -

ARG                            STARTER_HOME=/app
COPY .                       ${STARTER_HOME}
RUN  chown -R nobody:nogroup ${STARTER_HOME}
USER nobody

EXPOSE 4528
CMD [ "./up.sh" ]
