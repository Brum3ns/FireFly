FROM golang:1.22.3-alpine AS builder
# Install Firefly
RUN go install -v github.com/Brum3ns/firefly/cmd/firefly@latest

# Run binary
FROM alpine:3.19.1
RUN apk upgrade --no-cache \
    && apk add --no-cache git

COPY --from=builder /go/bin/firefly /usr/local/bin/
# Install and move Firefly's database to the systems config folder
RUN git clone https://github.com/Brum3ns/firefly-db /root/.config/firefly/
ENTRYPOINT ["firefly"]
