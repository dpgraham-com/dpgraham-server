package routes

import (
	"github.com/dpgrahm4401/dpgraham-server/db"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
	"strings"
)

// GetBlog top level handlerFunc that returns a blog given an ID
func GetBlog(c *gin.Context) {
	id := c.Param("id")
	idInt, err := strconv.Atoi(id)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	blogById, err := db.QueryArticle(idInt)
	if err != nil {
		c.JSON(http.StatusInternalServerError, nil)
		return
	} else {
		c.JSON(http.StatusOK, blogById)
	}
}

// GetAllBlogs Top level handlerFunc that returns a list of Blog metadata
func GetAllBlogs(c *gin.Context) {
	allBlogs, err := db.QueryAllArticles()
	if err != nil {
		c.JSON(http.StatusInternalServerError, nil)
		return
	}
	for i := 0; i < len(allBlogs); i++ {
		allBlogs[i].Content = strings.ReplaceAll(allBlogs[i].Content, "#", "")
		allBlogs[i].Content = strings.ReplaceAll(allBlogs[i].Content, "~", "")
		// to show a preview, we slice the content down to the first 200 characters.
		// This could be done, more efficiently, with the PSQL
		if len(allBlogs[i].Content) >= 200 {
			allBlogs[i].Content = allBlogs[i].Content[0:200]
		}
	}
	c.JSON(http.StatusOK, allBlogs)
}
