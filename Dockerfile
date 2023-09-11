FROM   golang:1.19-alpine3.16 AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main main.go


# Run stage
FROM alpine:3.16
WORKDIR /app
COPY --from=builder /app/main .
EXPOSE 8080
# CMD run whenever app start
CMD [ "/app/main" ]   
