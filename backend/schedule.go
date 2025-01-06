package main

import (
	"encoding/json"
	"fmt"
	"io"
	"os"
	"slices"
)

// A struct to schedule items
type ScheduleItem struct {
	ItemName                string `json:"itemName"`
	ItemTime                string `json:"itemTime"`
	NotificationEnabled     bool `json:"notificationEnabled"`
}

// Schedule represents a collection of schedule items
type Schedule struct {
	Schedule []ScheduleItem `json:"schedule"` 
}

// AddPost function updates the Feed by adding the new post
func AddScheduleItem(schedule *Schedule, scheduleItem ScheduleItem) error {
	// Add the new post to the feed
	schedule.Schedule = append(schedule.Schedule, scheduleItem)
	SortSchedule(schedule)
	err := SaveSchedule(*schedule)
    if err != nil {
        return fmt.Errorf("could not save schedule after adding item: %v", err)
    }

    fmt.Println("Item added successfully!")
    return nil
}

// DeletePost function updates the Feed by deleting the passed post
func DeleteScheduleItem(schedule *Schedule, scheduleItem ScheduleItem) error {
	index := slices.Index(schedule.Schedule, scheduleItem) 
	schedule.Schedule = append(schedule.Schedule[:index], schedule.Schedule[index+1:]...)
	err := SaveSchedule(*schedule)
    if err != nil {
        return fmt.Errorf("could not save feed after removing post: %v", err)
    }

    fmt.Println("Post removed successfully!")
    return nil
}

func SortSchedule(schedule *Schedule) error{
	// for not let's not worry about this. 
    return nil
}

// SaveSchedule saves the current schedule to a local file
func SaveSchedule(schedule Schedule) error {
	// Convert the Feed struct to JSON
	data, err := json.MarshalIndent(schedule, "", "  ")
	if err != nil {
		return fmt.Errorf("could not marshal schedule: %v", err)
	}

	// Open the file for writing (create if it doesn't exist)
	file, err := os.Create("schedule.json")
	if err != nil {
		return fmt.Errorf("could not create file: %v", err)
	}
	defer file.Close()

	// Write the JSON data to the file
	_, err = file.Write(data)
	if err != nil {
		return fmt.Errorf("could not write schedule to file: %v", err)
	}

	fmt.Println("Schedule saved successfully!")
	return nil
}

// LoadSchedule loads the pet's schedule from the local file system
func LoadSchedule() (Schedule, error) {
	// Open the file for reading
	file, err := os.Open("schedule.json")
	if err != nil {
		return Schedule{}, fmt.Errorf("could not open file: %v", err)
	}
	defer file.Close()

	// Read the data from the file
	data, err := io.ReadAll(file)
	if err != nil {
		return Schedule{}, fmt.Errorf("could not read file: %v", err)
	}

	// Unmarshal the JSON data into a Schedule struct
	var schedule Schedule
	err = json.Unmarshal(data, &schedule)
	if err != nil {
		return Schedule{}, fmt.Errorf("could not unmarshal schedule: %v", err)
	}

	fmt.Println("Schedule loaded successfully!")

	return schedule, nil
}
