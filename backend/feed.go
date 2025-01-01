package main

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
	"slices"
)

// Image struct
type Post struct {
	Caption         string `json:"caption"`
	Location        string `json:"location"`
	Date            string `json:"date"`
	Base64Image     string `json:"base64Image"`
	// over here we should have some sort of key that helps us identify an image. 
	// We will come back to this concept. 
}

// Feed represents a collection of posts
type Feed struct {
	// UserId  int `json:"userId"` 
	Posts []Post `json:"posts"` // A slice of posts structs
}

// AddPost function updates the Feed by adding the new post
func AddPost(feed *Feed, newPost Post) error {
	// Add the new post to the feed
	feed.Posts = append(feed.Posts, newPost)
	err := SaveFeed(*feed)
    if err != nil {
        return fmt.Errorf("could not save feed after adding post: %v", err)
    }

    fmt.Println("Post added successfully!")
    return nil
}

// DeletePost function updates the Feed by deleting the passed post
func DeletePost(feed *Feed, post Post) error {
	index := slices.Index(feed.Posts, post) 
	feed.Posts = append(feed.Posts[:index], feed.Posts[index+1:]...)
	err := SaveFeed(*feed)
    if err != nil {
        return fmt.Errorf("could not save feed after removing post: %v", err)
    }

    fmt.Println("Post removed successfully!")
    return nil
}

// SaveFeeds saves the current posts to a local file
func SaveFeed(feed Feed) error {
	// Convert the Feed struct to JSON
	data, err := json.MarshalIndent(feed, "", "  ")
	if err != nil {
		return fmt.Errorf("could not marshal feed: %v", err)
	}

	// Open the file for writing (create if it doesn't exist)
	file, err := os.Create("feed.json")
	if err != nil {
		return fmt.Errorf("could not create file: %v", err)
	}
	defer file.Close()

	// Write the JSON data to the file
	_, err = file.Write(data)
	if err != nil {
		return fmt.Errorf("could not write feed to file: %v", err)
	}

	fmt.Println("Feed saved successfully!")
	return nil
}

// LoadFeed loads the pet's feed from the local file system
func LoadFeed() (Feed, error) {
	// Open the file for reading
	file, err := os.Open("feed.json")
	if err != nil {
		return Feed{}, fmt.Errorf("could not open file: %v", err)
	}
	defer file.Close()

	// Read the data from the file
	data, err := io.ReadAll(file)
	if err != nil {
		return Feed{}, fmt.Errorf("could not read file: %v", err)
	}

	// Unmarshal the JSON data into a Feed struct
	var feed Feed
	err = json.Unmarshal(data, &feed)
	if err != nil {
		return Feed{}, fmt.Errorf("could not unmarshal feed: %v", err)
	}

	fmt.Println("Feed loaded successfully!")

	return feed, nil
}
