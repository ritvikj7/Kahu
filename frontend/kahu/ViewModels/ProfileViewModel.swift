//
//  ProfileViewModel.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-21.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var petProfile: PetProfile?

    // Fetch the profile from the backend
    func getProfile() async {
        guard let url = URL(string: "http://192.168.1.165:8080/profile") else {
            print("Invalid URL")
            return
        }

        do {
            // Perform the network request on a background thread
            let (data, _) = try await URLSession.shared.data(from: url)

            // Decode the JSON on a background thread
            let decoder = JSONDecoder()
            let profile = try decoder.decode(PetProfile.self, from: data)

            // Update the UI on the main thread
            await MainActor.run {
                self.petProfile = profile
            }
        } catch {
            print("Error fetching or decoding profile: \(error)")
        }
    }
    
    // Save the profile to the backend
    func saveProfile() async {
        // 1. Define the API URL
        guard let url = URL(string: "http://192.168.1.165:8080/profile/update") else {
            print("Invalid URL")
            return
        }
        
        // 2. Create a URLRequest
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // 3. Encode the profile into JSON
            let jsonData = try JSONEncoder().encode(self.petProfile)
            request.httpBody = jsonData
            
            // 4. Make the HTTP request using async/await
            let (_, _) = try await URLSession.shared.data(for: request)
            
        } catch {
            print("Error updating and saving profile: \(error)")
        }
    }
}
