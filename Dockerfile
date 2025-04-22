FROM nginx:latest

RUN apk add --no-cache curl

RUN curl -LO https://github.com/grafana/loki/releases/latest/download/loki-linux-amd64.zip && \
    unzip loki-linux-amd64.zip && \
    mv loki-linux-amd64 /usr/local/bin/loki && \
    chmod +x /usr/local/bin/loki && \
    rm loki-linux-amd64.zip

COPY nginx.conf /etc/nginx/nginx.conf
COPY loki-config.yaml /etc/loki/config.yaml

RUN mkdir -p /var/log/nginx

CMD ["sh", "-c", "nginx && loki -config.file=/etc/loki/config.yaml"]
