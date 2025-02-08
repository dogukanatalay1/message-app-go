# Stage 1: Build the Go application
FROM golang:1.21 AS builder
WORKDIR /app

# Copy go.mod and go.sum to download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code and build the app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o app ./main.go

# Stage 2: Run the application using a lightweight image
FROM alpine:latest
WORKDIR /root/

# Copy the built binary from the builder stage
COPY --from=builder /app/app .

# Expose the application's port
EXPOSE 8080

# Run the application
CMD ["./app"]
