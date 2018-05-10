FROM golang:1.10.2-alpine3.7 AS build-env

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

RUN go get -v -u github.com/micro/micro
RUN go get -v -u github.com/micro/go-grpc
RUN go build -o /micro $GOPATH/src/github.com/micro/go-grpc/cmd/micro/main.go

# final stage
FROM alpine:3.7
WORKDIR /app
COPY --from=build-env /micro /app/
ENTRYPOINT ["./micro"]