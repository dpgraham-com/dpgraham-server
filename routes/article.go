package routes

import (
	"github.com/dpgrahm4401/dpgraham-server/db"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
	"strings"
)

// GetArticle top level handlerFunc that returns an article given an ID
func GetArticle(c *gin.Context) {
	id := c.Param("id")
	idInt, err := strconv.Atoi(id)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	articleById, err := db.QueryArticle(idInt)
	if err != nil {
		c.JSON(http.StatusInternalServerError, nil)
		return
	} else {
		c.JSON(http.StatusOK, articleById)
	}
}

// GetAllArticles Top level handlerFunc that returns a list of article metadata
func GetAllArticles(c *gin.Context) {
	allArticles, err := db.QueryAllArticles()
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
