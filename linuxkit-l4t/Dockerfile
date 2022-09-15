FROM alpine AS extract

ARG URLS

RUN apk add --no-cache curl dpkg tar && true
WORKDIR /deb
RUN mkdir extract
RUN for url in ${URLS}; do \
        echo "Extracting: $url"; \
        curl -fsSL -o dl.deb $url && \
        dpkg-deb -x dl.deb . ;\
    done

RUN for d in lib/modules/*; do depmod -b . $(basename $d); done

RUN mkdir /out
RUN cp -a boot/Image /out/kernel
RUN tar cf /out/kernel.tar lib

FROM scratch
WORKDIR /
ENTRYPOINT []
CMD []
COPY --from=extract /out/* /
