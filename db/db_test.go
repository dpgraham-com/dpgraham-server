package db

import (
	"database/sql"
	"fmt"
	"github.com/go-playground/assert/v2"
	"github.com/go-testfixtures/testfixtures/v3"
	"os"
	"testing"
)

// TestMain is a special function that runs before any tests are run
var (
	db       *sql.DB
	fixtures *testfixtures.Loader
)

func TestMain(m *testing.M) {
	var err error

	// Open connection to the test database.
	db, err = sql.Open("postgres", "dbname=dpgraham user=dg password=password123 host=localhost port=5432 sslmode=disable")
	//db, err := sql.Open("sqlite3", "file:./db.sqlite3?cache=shared")
	if err != nil {
		fmt.Println(err)
	}

	fixtures, err = testfixtures.New(
		testfixtures.Database(db),
		testfixtures.Dialect("postgres"),   // Available: "postgresql", "timescaledb", "mysql", "mariadb", "sqlite" and "sqlserver"
		testfixtures.Directory("fixtures"), // The directory containing the YAML files
	)
	if err != nil {
		fmt.Println(err)
	}

	os.Exit(m.Run())
}

func prepareTestDatabase() {
	if err := fixtures.Load(); err != nil {
		fmt.Println(err)
	}
}

func TestQueryArticleById(t *testing.T) {
	prepareTestDatabase()
	article, _ := QueryArticle(db, 1)
	fmt.Println(article)
	assert.Equal(t, 1, 1)
}
