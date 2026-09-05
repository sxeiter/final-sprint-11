FROM golang:1.22-alpine AS builder

WORKDIR /app


COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o parcel-app .


FROM alpine:latest

WORKDIR /app


COPY --from=builder /app/parcel-app .

COPY --from=builder /app/tracker.db .

CMD ["./parcel-app"]