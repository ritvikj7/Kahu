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
		http.Error(w, "Could not delete post from the feed", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Feed updated successfully"))
}

// Handler for getting all schedule items from the schedule  
func getScheduleHandler(w http.ResponseWriter, r *http.Request) {
	feed, err := LoadSchedule()
	if err != nil {
		http.Error(w, "Could not load schedule", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(feed)
}

// Handler for adding a schedule item to the schedule
func addScheduleItemHandler(w http.ResponseWriter, r *http.Request) {
	var scheduleItem ScheduleItem
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&scheduleItem)
	if err != nil {
		http.Error(w, "Invalid input", http.StatusBadRequest)
		return
	}

	schedule, err := LoadSchedule()
	if err != nil {
		http.Error(w, "Could not load schedule", http.StatusInternalServerError)
		return
	}

	err = AddScheduleItem(&schedule, scheduleItem)
	if err != nil {
		http.Error(w, "Could not add schedule item to schedule", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Schedule updated successfully"))
}

// Handler for deleting a schedule item from the schedule
func deleteScheduleItemHandler(w http.ResponseWriter, r *http.Request) {
	var scheduleItem ScheduleItem
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(&scheduleItem)
	if err != nil {
		http.Error(w, "Invalid input", http.StatusBadRequest)
		return
	}

	schedule, err := LoadSchedule()
	if err != nil {
		http.Error(w, "Could not load schedule", http.StatusInternalServerError)
		return
	}

	err = DeleteScheduleItem(&schedule, scheduleItem)
	if err != nil {
		http.Error(w, "Could not delete schechule item from the schedule", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Schedule updated successfully"))
}

// Define routes
func routes() {
	http.HandleFunc("/profile", getProfileHandler)                              // GET request to retrieve profile
	http.HandleFunc("/feed", getFeedHandler)                                    // GET request to retrieve feed
	http.HandleFunc("/schedule", getScheduleHandler)                            // GET request to retrieve feed
	http.HandleFunc("/profile/update", updateProfileHandler)                    // POST request to update profile
	http.HandleFunc("/feed/add/image", addPostHandler)                          // POST request to add image
	http.HandleFunc("/feed/delete/image", deletePostHandler)                    // POST request to delete image
	http.HandleFunc("/feed/add/schedule/item", addScheduleItemHandler)          // POST request to add schedule item
	http.HandleFunc("/feed/delete/schedule/item", deleteScheduleItemHandler)    // POST request to delete image

}
