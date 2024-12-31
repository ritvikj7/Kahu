package main

import (
	"encoding/json"
	"net/http"
)

// Handler for getting the pet profile
func getProfileHandler(w http.ResponseWriter, r *http.Request) {
	profile, err := LoadProfile()
	if err != nil {
		http.Error(w, "Could not load profile", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(profile)
}

// Handler for updating the pet profile
func updateProfileHandler(w http.ResponseWriter, r *http.Request) {
	var profile PetProfile
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&profile)
	if err != nil {
		http.Error(w, "Invalid input", http.StatusBadRequest)
		return
	}

	err = SaveProfile(profile)
	if err != nil {
		http.Error(w, "Could not save profile", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Profile updated successfully"))
}

// Handler for getting all posts from the feed  
func getFeedHandler(w http.ResponseWriter, r *http.Request) {
	feed, err := LoadFeed()
	if err != nil {
		http.Error(w, "Could not load feed", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(feed)
}

// Handler for adding an image to the feed
func addPostHandler(w http.ResponseWriter, r *http.Request) {
	var post Post
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&post)
	if err != nil {
		http.Error(w, "Invalid input", http.StatusBadRequest)
		return
	}

	feed, err := LoadFeed()
	if err != nil {
		http.Error(w, "Could not load feed", http.StatusInternalServerError)
		return
	}

	err = AddPost(&feed, post)
	if err != nil {
		http.Error(w, "Could not add image to feed", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Feed updated successfully"))
}

// Handler for deleting a post from feed
func deletePostHandler(w http.ResponseWriter, r *http.Request) {
	var post Post
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&post)
	if err != nil {
		http.Error(w, "Invalid input", http.StatusBadRequest)
		return
	}

	feed, err := LoadFeed()
	if err != nil {
		http.Error(w, "Could not load feed", http.StatusInternalServerError)
		return
	}

	err = DeletePost(&feed, post)
	if err != nil {
		http.Error(w, "Could not add post to feed", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Feed updated successfully"))
}

// Define routes
func routes() {
	http.HandleFunc("/profile", getProfileHandler)           // GET request to retrieve profile
	http.HandleFunc("/feed", getFeedHandler)                 // GET request to retrieve feed
	http.HandleFunc("/profile/update", updateProfileHandler) // POST request to update profile
	http.HandleFunc("/profile/add", addPostHandler)         // POST request to add image
	http.HandleFunc("/profile/delete", deletePostHandler)   // POST request to delete image
}
