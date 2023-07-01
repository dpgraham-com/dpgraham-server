package routes

import (
	"github.com/gin-gonic/gin"
	"github.com/go-playground/assert/v2"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestArticleRoutes(t *testing.T) {
	env := &Env{}
	w := httptest.NewRecorder()
	c, _ := gin.CreateTestContext(w)
	env.GetArticle(c)
	assert.Equal(t, http.StatusBadRequest, w.Code)
}
