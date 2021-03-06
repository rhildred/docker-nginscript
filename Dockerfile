FROM alpine

# LICENSE public domain
MAINTAINER euank

RUN apk update
RUN apk add make openssl-dev pcre-dev zlib-dev wget tar build-base ca-certificates
RUN wget -O njs.tar.gz http://hg.nginx.org/njs/archive/0.1.10.tar.gz && \
    wget -O nginx.tar.gz https://nginx.org/download/nginx-1.13.1.tar.gz && \
    tar xzvf njs.tar.gz && \
    tar xzvf nginx.tar.gz && \
    cd nginx-* && ./configure --add-module=../njs*/nginx && \
    make && make install && \
    rm -f ../*.tar.gz

EXPOSE 80 443
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
