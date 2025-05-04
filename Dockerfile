FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

COPY httscript.sh /usr/local/bin/httscript.sh

RUN chmod +x /usr/local/bin/httscript.sh

ENTRYPOINT ["/usr/local/bin/httscript.sh"]
