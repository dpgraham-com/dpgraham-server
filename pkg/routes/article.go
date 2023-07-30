package routes

import (
	"dpgraham.com/pkg/db"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
	"strings"
)

type Env struct {
	Articles db.ArticleQuerier
}

// GetArticle top level handlerFunc that returns an article given an ID
func (env *Env) GetArticle(c *gin.Context) {
	id := c.Param("id")
	// Check the parameter is a valid integer
	idInt, err := strconv.Atoi(id)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	// Get the article from the database
	articleById, err := env.Articles.ByID(idInt)
	if err != nil {
		c.JSON(http.StatusInternalServerError, nil)
		return
	} else {
		c.JSON(http.StatusOK, articleById)
	}
}

// GetAllArticles Top level handlerFunc that returns a list of article metadata
func (env *Env) GetAllArticles(c *gin.Context) {
	allArticles, err := env.Articles.All()
	if err != nil {
		c.JSON(http.StatusInternalServerError, nil)
		return
	}
	for i := 0; i < len(allArticles); i++ {
		allArticles[i].Content = strings.ReplaceAll(allArticles[i].Content, "#", "")
		allArticles[i].Content = strings.ReplaceAll(allArticles[i].Content, "~", "")
		// to show a preview, we slice the content down to the first 200 characters.
		// This could be done, more efficiently, with the PSQL
		if len(allArticles[i].Content) >= 200 {
			allArticles[i].Content = allArticles[i].Content[0:200]
		}
	}
	c.JSON(http.StatusOK, allArticles)
}
