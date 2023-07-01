package routes

import (
	"database/sql"
	"github.com/dpgrahm4401/dpgraham-server/db"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
	"strings"
)

type Env struct {
	DB *sql.DB
}

// GetArticle top level handlerFunc that returns an article given an ID
func (env *Env) GetArticle(c *gin.Context) {
	id := c.Param("id")
	idInt, err := strconv.Atoi(id)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	articleById, err := db.QueryArticle(env.DB, idInt)
	if err != nil {
		c.JSON(http.StatusInternalServerError, nil)
		return
	} else {
		c.JSON(http.StatusOK, articleById)
	}
}

// GetAllArticles Top level handlerFunc that returns a list of article metadata
func (env *Env) GetAllArticles(c *gin.Context) {
	allArticles, err := db.QueryAllArticles(env.DB)
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
