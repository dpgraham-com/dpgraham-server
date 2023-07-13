package db

import (
	"database/sql"
	"fmt"
	"github.com/go-playground/assert/v2"
	"github.com/go-testfixtures/testfixtures/v3"
	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	"log"
	"os"
	"testing"
)

var (
	db       *sql.DB
	fixtures *testfixtures.Loader
)

// TestMain is a runs before any tests are run. we use it to set up our test database
func TestMain(m *testing.M) {
	var err error

	// Open connection to the test database.
	db, err = sql.Open("postgres", fmt.Sprintf("host=%s port=%s  dbname=%s user=%s password=%s sslmode=disable",
		getEnv("DB_HOST", "localhost"),
		getEnv("DB_PORT", "5432"),
		getEnv("DB_NAME", "dpgraham_test"),
		getEnv("DB_USER", "dg"),
		getEnv("DB_PASSWORD", "password123"),
	))
	if err != nil {
		log.Println("Could not connect to the test database, ensure it is running and accepting connections")
		log.Println("The Following environment variables are used to connect to the database:")
		log.Println("DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD")
		log.Fatal("error getting driver", err)
	}

	// migrate database schema
	driver, err := postgres.WithInstance(db, &postgres.Config{})
	if err != nil {
		log.Fatal("error getting driver: ", err)
	}

	migration, err := migrate.NewWithDatabaseInstance(
		"file://migrations",
		"postgres", driver)
	if err != nil {
		log.Fatal("error creating migrations: ", err)
	}

	// migrate changes up, throw error if NOT ErrNoChange
	if err = migration.Up(); err != nil {
		if err != migrate.ErrNoChange {
			log.Println("error", err)
			log.Fatal("error migrating database up: ", err)
		}
	}

	// Load fixtures from memory
	fixtures, err = testfixtures.New(
		testfixtures.Database(db),
		testfixtures.Dialect("postgres"),
		testfixtures.Directory("fixtures"),
	)
	if err != nil {
		log.Fatal("Error preparing fixtures from files", err)
	}

	os.Exit(m.Run())
}

// prepareTestDatabase loads the fixtures into the test database
func prepareTestDatabase() {
	if err := fixtures.Load(); err != nil {
		log.Fatal("Error loading fixtures", err)
	}
}

// Test returns a single article from our DB by id
func TestQueryArticleById(t *testing.T) {
	// Arrange
	prepareTestDatabase()
	articleStore := &ArticleStore{DB: db}
	// Act
	article, _ := articleStore.ByID(1)
	// Assert
	assert.Equal(t, article.Id, 1)
}

// Test returns all (and only) published articles
func TestQueryAllReturnsOnlyPublished(t *testing.T) {
	// Arrange
	prepareTestDatabase()
	articleStore := &ArticleStore{DB: db}
	// Act
	allArticles, _ := articleStore.All()
	// Assert
	for _, article := range allArticles {
		assert.Equal(t, article.Published, true)
	}
}
