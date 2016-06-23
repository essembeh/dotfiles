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
COPY users.htpasswd /data/radicale/
COPY config /data/radicale/
RUN chown -R radicale:radicale /data/radicale

# Container info
USER radicale
WORKDIR	/home/radicale
VOLUME /data/radicale
EXPOSE 5232
CMD ["radicale", "-D", "-C", "/data/radicale/config"]
