FROM golang:1.22 as builder

RUN apk update && apk add git go 
RUN git clone https://github.com/gnAsteroid/gnAsteroid /gnAsteroid
RUN go build -C /gnAsteroid -o /gnAsteroid/gnAsteroid

FROM linuxserver/openssh-server:latest

ENV USER_NAME raoul
ENV PUBLIC_KEY ssh-rsa AAAAA3f3f3f3f3
#                ^-- You should create a special key for Akash, 
#                    avoiding password, and allowing passwordless rsync. 
ENV LOG_STDOUT true
ENV ENV /app/ash.rc

COPY --from=builder /gnAsteroid/gnAsteroid /gnAsteroid
COPY app /app/
RUN chown -R 911:911 /app/
EXPOSE 2222
EXPOSE 8888-8899
VOLUME /app/asteroids

CMD sh /app/run
