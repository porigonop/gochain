FROM golang:latest AS BUILDER
COPY app.go .
RUN go get -d -v \
        github.com/lib/pq \
        github.com/julienschmidt/httprouter
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /app

# FROM scratch
# COPY --from=BUILDER /app /app
COPY blockchain.html /
ENTRYPOINT ["/app"]

