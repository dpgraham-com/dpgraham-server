package models

// Article captures metadata about a article, tutorial, blog etc.
type Article struct {
	Id          int    `json:"id"`
	Title       string `json:"title"`
	LastUpdate  string `json:"updateDate"`
	CreatedDate string `json:"createDate"`
	Published   bool   `json:"publish"`
	Author      string `json:"author"`
	Content     string `json:"content"`
}
