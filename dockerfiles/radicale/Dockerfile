FROM alpine:latest

# Packages
RUN apk update
RUN apk add python3 vim

# Python dependencies
ADD https://bootstrap.pypa.io/get-pip.py /tmp/
RUN python3 /tmp/get-pip.py
RUN pip install radicale

# User
RUN adduser -h /home/radicale -D radicale

# Radicale configuration
COPY users.htpasswd /data/
COPY config /data/
COPY collections /data/collections/
RUN chown -R radicale:radicale /data/

# Container info
USER radicale
WORKDIR	/data/
VOLUME /data/
EXPOSE 5232
CMD ["radicale", "-D", "-C", "/data/config"]
