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
		Bio:            "Spike loves chasing squirrels and belly rubs!",
		ProfilePicture: "https://example.com/spike.jpg",
	}

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

	// Print the loaded profile
	fmt.Printf("Loaded Profile: %+v\n", loadedProfile)
}
