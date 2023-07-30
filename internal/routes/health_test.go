package routes

import (
	"github.com/gin-gonic/gin"
	"github.com/go-playground/assert/v2"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHealthCheckReturns200(t *testing.T) {
	env := &Env{}
	w := httptest.NewRecorder()
	c, _ := gin.CreateTestContext(w)
	env.HealthCheck(c)
	assert.Equal(t, http.StatusOK, w.Code)
}
