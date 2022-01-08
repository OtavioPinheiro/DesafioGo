FROM golang:alpine3.10 as builder

WORKDIR /go/scr/app

COPY . .

RUN CGO_ENABLED=0 go build -o /app main.go


FROM scratch

COPY --from=builder /app /app

CMD ["/app"]