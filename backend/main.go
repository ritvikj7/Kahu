package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	// Initialize routes
	routes()

	// Start the server
	port := ":8080"
	fmt.Println("Server running on port", port)
	log.Fatal(http.ListenAndServe(port, nil))
}