FROM golang:latest AS BUILDER
COPY app.go .
RUN go get -d -v \
        github.com/lib/pq \
        github.com/julienschmidt/httprouter
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app

FROM scratch
COPY --from=BUILDER /app /
COPY ./blockchain.html /

ENV IP=0.0.0.0
ENV PORT=8000
ENV POSTGRES_URL=0.0.0.0
ENV POSTGRES_PASSWORD=secret
EXPOSE 8000
HEALTHCHECK --interval=5s --timeout=5s CMD curl -f 0.0.0.0:8000 && exit 0 || exit 1

ENTRYPOINT ["/app"]

