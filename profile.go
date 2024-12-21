package main

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
)

// PetProfile struct
type PetProfile struct {
	PetName        string `json:"pet_name"`
	Breed          string `json:"breed"`
	Age            int    `json:"age"`
	Birthday       string `json:"birthday"`
	Weight         int    `json:"weight"`
	Gender         string `json:"gender"`
}

// UpdateField updates the PetProfile struct.
func UpdateField(profile *PetProfile, field string, value interface{}) {
	switch field {
	case "PetName":
		profile.PetName = value.(string)
	case "Breed":
		profile.Breed = value.(string)
	case "Age":
		profile.Age = value.(int)
	case "Birthday":
		profile.Birthday = value.(string)
	case "Weight":
		profile.Weight = value.(int)
	case "Gender":
		profile.Gender = value.(string)
	default:
		fmt.Println("Invalid field")
	}
}

// SaveProfile saves the pet profile to a local file
func SaveProfile(profile PetProfile) error {
	// Convert the PetProfile struct to JSON
	data, err := json.MarshalIndent(profile, "", "  ")
	if err != nil {
		return fmt.Errorf("could not marshal profile: %v", err)
	}

	// Open the file for writing (create if it doesn't exist)
	file, err := os.Create("profile.json")
	if err != nil {
		return fmt.Errorf("could not create file: %v", err)
	}
	defer file.Close()

	// Write the JSON data to the file
	_, err = file.Write(data)
	if err != nil {
		return fmt.Errorf("could not write profile to file: %v", err)
	}

	fmt.Println("Profile saved successfully!")
	return nil
}

// LoadProfile loads the pet profile from the local file
func LoadProfile() (PetProfile, error) {
	// Open the file for reading
	file, err := os.Open("profile.json")
	if err != nil {
		return PetProfile{}, fmt.Errorf("could not open file: %v", err)
	}
	defer file.Close()

	// Read the data from the file
	data, err := io.ReadAll(file)
	if err != nil {
		return PetProfile{}, fmt.Errorf("could not read file: %v", err)
	}

	// Unmarshal the JSON data into a PetProfile struct
	var profile PetProfile
	err = json.Unmarshal(data, &profile)
	if err != nil {
		return PetProfile{}, fmt.Errorf("could not unmarshal profile: %v", err)
	}

	return profile, nil
}
