FROM golang:latest AS BUILDER
COPY app.go .
RUN go get -d -v \
        github.com/lib/pq \
        github.com/julienschmidt/httprouter
RUN go build -o /app

# FROM scratch
# COPY --from=BUILDER /app /app
COPY blockchain.html /
ENTRYPOINT ["/app"]

