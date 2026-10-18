# The binary is cross-compiled on the build host (CGO off, static) and copied
# in: the deployment target is a small 2 vCPU / 2 GB box, and pulling the Go
# toolchain image there costs more memory than the whole service needs.
FROM alpine:3.21
RUN apk add --no-cache ca-certificates tzdata
WORKDIR /app
COPY notion-manager-linux /app/notion-manager
RUN chmod +x /app/notion-manager
# config.yaml and accounts/ are mounted; they hold secrets and must not
# live in the image.
EXPOSE 8081
ENTRYPOINT ["/app/notion-manager"]
