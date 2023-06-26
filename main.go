package main

import (
	"github.com/dpgrahm4401/dpgraham-server/routes"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"log"
)

// routerSetup returns a fully configured mux(?) with routes attached
func routerSetup() (router *gin.Engine) {
	// Create and config gin.Engine
	router = gin.Default()
	router.Use(cors.New(cors.Config{
		AllowAllOrigins: true,
		AllowMethods:    []string{"GET"},
	}))
	// Set gin routes AFTER config
	api := router.Group("/api")
	{
		api.GET("/blog", routes.GetAllArticles)
		api.GET("/blog/:id", routes.GetArticle)
	}
	return
}

// Entry point for the application
func main() {
	router := routerSetup()
	err := router.Run(":8080")
	if err != nil {
		log.Fatal(err)
	}
}
