package db

import (
	"database/sql"
	"fmt"
	"github.com/dpgrahm4401/dpgraham-server/models"
	_ "github.com/lib/pq"
	"log"
	"os"
)

// getEnv is a local helper function to use a fallback value if an environment variable is not set
func getEnv(key, fallback string) string {
	if value, ok := os.LookupEnv(key); ok {
		return value
	}
	return fallback
}

func ConnectDatabase() *sql.DB {
	var err error
	pgConn := fmt.Sprintf("host=%s port=%s user=%s password=%s "+
		"dbname=%s sslmode=disable",
		os.Getenv("DPG_DB_HOST"),
		os.Getenv("DPG_DB_PORT"),
		os.Getenv("DPG_DB_USER"),
		os.Getenv("DPG_DB_PASSWORD"),
		os.Getenv("DPG_DB_NAME"))
	db, err := sql.Open("postgres", pgConn)
	if err != nil {
		log.Fatal(err)
	}
	return db
}

func QueryAllArticles(db *sql.DB) ([]models.Article, error) {
	allArticleQuery, err := db.Prepare(
		` SELECT
                     id,
                     to_char(created_date, 'mm/dd/yyyy'),
                     to_char(updated_date, 'mm/dd/yyyy'),
                     content,
                     published,
                     title,
                     author
                FROM
                    articles
                WHERE
                    published = true`)
	if err != nil {
		return nil, err
	}
	rows, err := allArticleQuery.Query()
	if err != nil {
		return nil, err
	}
	var articles []models.Article
	for rows.Next() {
		var article models.Article
		if err := rows.Scan(&article.Id, &article.CreatedDate, &article.LastUpdate, &article.Content, &article.Published,
			&article.Title, &article.Author); err != nil {
			return articles, err
		}
		articles = append(articles, article)
	}
	if err != nil {
		return nil, err
	}
	return articles, nil
}

func QueryArticle(db *sql.DB, id int) (models.Article, error) {
	article := models.Article{}
	err := db.QueryRow("SELECT * FROM articles WHERE id = $1", id).Scan(
		&article.Id, &article.CreatedDate, &article.LastUpdate, &article.Content, &article.Published,
		&article.Title, &article.Author)
	if err != nil {
		return article, err
	}
	return article, nil
}
