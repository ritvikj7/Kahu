package main

import (
	"fmt"
	"log"
)

func main() {
	// Create a sample pet profile
	profile := PetProfile{
		PetName:        "Bellwy",
		Breed:          "Golden Retriever",
		Age:            3,
		Birthday:       "2020-05-10",
		Weight:         30,
		Gender:         "Male",
	}

	UpdateField(&profile, "PetName", "Spike")

	// Save the profile
	err := SaveProfile(profile)
	if err != nil {
		log.Println("Error saving profile:", err)
		return
	}

	// Load the profile
	loadedProfile, err := LoadProfile()
	if err != nil {
		log.Println("Error loading profile:", err)
		return
	}

	// Print the loaded profile in console. 
	fmt.Printf("Loaded Profile: %+v\n", loadedProfile)
}
