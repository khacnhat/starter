FROM  cyberdojo/rack-base
LABEL maintainer=jon@jaggersoft.com

# - - - - - - - - - - - - - - -
# setup server
# - - - - - - - - - - - - - - -

ARG                            STARTER_HOME=/app
COPY .                       ${STARTER_HOME}
RUN  chown -R nobody:nogroup ${STARTER_HOME}
USER nobody

ARG SHA
RUN echo ${SHA} > ${STARTER_HOME}/sha.txt

EXPOSE 4527
CMD [ "./up.sh" ]

