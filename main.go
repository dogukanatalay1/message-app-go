package main

import (
	"log"

	"github.com/dogukanatalay1/message-app-go/db/postgres" // Importing from GitHub
)

func main() {
	// Initialize the database connection
	postgres.ConnectDB()
	defer postgres.CloseDB() // Ensure the database connection is closed when the app stops

	app := fiber.New()

	app.Get("/", func(c *fiber.Ctx) error {
		return c.SendString("Hello, World!")
	})

	log.Fatal(app.Listen(":3000"))
}
