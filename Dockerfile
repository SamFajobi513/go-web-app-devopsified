FROM golang:1.24 as base

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . .

RUN go build -o main .

#Final Stage; Use distroless image to reduce the image size
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD  ["./main"]