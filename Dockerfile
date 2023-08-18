FROM golang:1.20-alpine AS build
RUN mkdir /src
ADD . /src
WORKDIR /src
RUN go build ./cmd/server

FROM alpine:latest AS production
COPY --from=build /src/server .
EXPOSE 8080
CMD ["./server"]
