package routes

import (
	"github.com/gin-gonic/gin"
	"github.com/go-playground/assert/v2"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestArticleRoutes(t *testing.T) {
	w := httptest.NewRecorder()
	c, _ := gin.CreateTestContext(w)
	GetArticle(c)
	assert.Equal(t, http.StatusBadRequest, w.Code)
}
