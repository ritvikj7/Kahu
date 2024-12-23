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

// Define routes
func routes() {
	http.HandleFunc("/profile", getProfileHandler)        // GET request to retrieve profile
	http.HandleFunc("/profile/update", updateProfileHandler) // POST request to update profile
}
