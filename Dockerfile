FROM  cyberdojo/rack-base
LABEL maintainer=jon@jaggersoft.com

ARG HOME=/app
COPY . ${HOME}
RUN  chown -R nobody:nogroup ${HOME}
USER nobody

ARG SHA
RUN echo ${SHA} > ${HOME}/sha.txt

EXPOSE 4527
CMD [ "./up.sh" ]
