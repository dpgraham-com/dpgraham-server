package main

import (
	"github.com/dpgrahm4401/dpgraham-server/db"
	"github.com/dpgrahm4401/dpgraham-server/routes"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"log"
	"os"
)

// routerSetup returns a fully configured mux(?) with routes attached
func routerSetup() (router *gin.Engine) {
	// Create and config Env used to dependency inject necessary items for handlers
	env := routes.Env{
		Articles: db.ConnectDatabase(),
	}
	// Create and config gin.Engine
	router = gin.Default()
	router.Use(cors.New(cors.Config{
		AllowAllOrigins: true,
		AllowMethods:    []string{"GET"},
	}))
	// Set gin routes AFTER config
	api := router.Group("/api")
	{
		api.GET("/blog", env.GetAllArticles)
		api.GET("/blog/:id", env.GetArticle)
	}
	return
}

// Entry point for the application
func main() {
	log.Printf("Starting server")
	router := routerSetup()
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
		log.Printf("Defaulting to port %s", port)
	}
	log.Printf("Listening on port %s", port)
	err := router.Run(":" + port)
	if err != nil {
		log.Fatal(err)
	}
}
