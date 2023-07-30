package main

import (
	"dpgraham.com/pkg/db"
	"dpgraham.com/pkg/routes"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"os"
)

// getEnv is a local helper function use an environment variable or fallback if not set
func getEnv(key, fallback string) string {
	if value, ok := os.LookupEnv(key); ok {
		return value
	}
	return fallback
}

// routerSetup returns a fully configured mux(?) with routes attached
func routerSetup() (router *gin.Engine) {
	// Create and config Env used to dependency inject necessary items for handlers
	env := routes.Env{
		Articles: db.ConnectDatabase(),
	}
	// set GIN_MODE to release if not set
	ginMode := getEnv(gin.EnvGinMode, gin.ReleaseMode)
	gin.SetMode(ginMode)

	// Create and config gin.Engine
	router = gin.Default()
	router.Use(cors.New(cors.Config{
		AllowAllOrigins: true,
		AllowMethods:    []string{"GET"},
	}))
	// Set gin routes AFTER config
	api := router.Group("/api")
	{
		api.GET("/article", env.GetAllArticles)
		api.GET("/article/:id", env.GetArticle)
		api.GET("/blog", func(c *gin.Context) {
			c.Redirect(http.StatusFound, "/api/article")
		})
		api.GET("/blog/:id", func(c *gin.Context) {
			c.Redirect(http.StatusFound, "/api/article/"+c.Param("id"))
		})
		api.GET("/status", env.HealthCheck)
	}
	return
}

// Entry point for the application
func main() {
	log.Println("Starting server")
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
