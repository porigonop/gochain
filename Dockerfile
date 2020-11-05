FROM golang:latest AS BUILDER
COPY app.go .
RUN go get -d -v \
        github.com/lib/pq \
        github.com/julienschmidt/httprouter
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app

FROM scratch
COPY --from=BUILDER /app /
ENTRYPOINT ["/app"]

