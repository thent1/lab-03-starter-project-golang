FROM golang:1.22.0-alpine AS build

WORKDIR /fizzbuzz

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY cmd ./cmd
COPY lib ./lib
COPY templates ./templates
COPY main.go .

RUN go build -o ./fizzbuzz

FROM scratch

WORKDIR /fizzbuzz

COPY --from=build /fizzbuzz/templates templates

COPY --from=build /fizzbuzz/fizzbuzz /fizzbuzz

CMD ["./fizzbuzz", "serve"]