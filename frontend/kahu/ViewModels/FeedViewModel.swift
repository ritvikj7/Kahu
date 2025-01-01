//
//  FeedViewModel.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-31.
//

import Foundation

/*
When we mark a property with @Published, it means that any change to that property will trigger an update in the UI.
Because of "ObservableObject" any SwiftUI view that uses this object will be notified when changes occur to its @Published properties.
The guard statement is similar to the if statement with one major difference. The if statement runs when a certain condition is met. However, the guard statement runs when a certain condition is not met.
Marking the method or class with @MainActor ensure that all UI-related code is executed on the main thread, and Swift will automatically handle thread safety for you.
 */

import UIKit

class FeedViewModel: ObservableObject {
    @Published var feed: Feed?
    @Published var image: [UIImage] = []
    
    func getProfile() async {
        guard let url = URL(string: "http://192.168.1.165:8080/feed") else {
            print("Invalid URL")
            return
        }

        do {
            // Perform the network request on a background thread
            let (data, _) = try await URLSession.shared.data(from: url)

            // Decode the JSON on a background thread
            let decoder = JSONDecoder()
            let feed = try decoder.decode(Feed.self, from: data)

            // Update the UI on the main thread
            await MainActor.run {
                self.feed = feed
            }
        } catch {
            print("Error fetching or decoding profile: \(error)")
        }
    }
    
    func base64ToImage(base64Image: String) -> UIImage? {
        // Decode the base64 string to Data
        if let imageData = Data(base64Encoded: base64Image, options: .ignoreUnknownCharacters) {
            // Create and return the UIImage from the Data
            return UIImage(data: imageData)
        } else {
            // Return nil if the base64 string is invalid
            return nil
        }
    }
    
    @MainActor
    func getImage(){
        guard let feed = feed else{
            return
        }
        
        var temp: [UIImage] = []
        
        feed.posts.forEach{ post in
            if let image = base64ToImage(base64Image: post.base64Image){
                temp.append(image)
            }
        }
        self.image = temp
    }
}
