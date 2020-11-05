FROM golang:latest AS BUILDER
COPY app.go .
RUN go get -d -v \
        github.com/lib/pq \
        github.com/julienschmidt/httprouter
RUN go build -o /go/build/app
RUN ls
RUN pwd

#FROM scratch

#COPY --from=BUILDER /go/build/app /go/build/app
EXPOSE 8000
ENTRYPOINT ["/go/build/app"]

