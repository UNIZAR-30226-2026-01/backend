package main

import "github.com/gin-gonic/gin"

func main() {
	router := gin.Default()
	router.GET("/ping", getHello)

	router.Run() // escucha en 0.0.0.0:8080 por defecto
}

func getHello(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "pong",
	})
}
