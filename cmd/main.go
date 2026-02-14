package main

import (
	"fmt"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {

	// Cargar las variables de .env
	godotenv.Load()

	fmt.Println(os.Getenv("DB_URL"))

	router := gin.Default()
	router.GET("/ping", getHello)

	router.Run() // escucha en 0.0.0.0:8080 por defecto
}

func getHello(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "pong",
	})
}
