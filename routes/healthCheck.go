package routes

import (
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
)

func (env *Env) HealthCheck(context *gin.Context) {
	// ToDo: check the env struct and validate app status
	log.Println("Health check called")
	context.JSON(http.StatusOK, gin.H{
		"message": "API status: OK",
	})
}
