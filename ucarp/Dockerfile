FROM alpine

RUN apk add --no-cache ucarp bash
RUN mkdir -p /ucarp/

COPY *.sh /ucarp/
WORKDIR /ucarp

ENTRYPOINT ["/ucarp/run.sh"]
