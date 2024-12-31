//
//  PostViewModel.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-31.
//

import Foundation
import UIKit


class PostViewModel: ObservableObject {
    
    private func createPost(caption: String, location: String, date: Date, image: UIImage) -> Post?{
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return nil
        }
        
        let base64Image = imageData.base64EncodedString()
        
        let post = Post(caption: caption,
                        location: location,
                        date: dateToString(date: date),
                        base64Image: base64Image)
        
        return post
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"  // You can customize this format
        return formatter.string(from: date)
    }
    
    // Save the profile to the backend
    func postImage(caption: String, location: String, date: Date, image: UIImage) async {
        // 1. Create a post
        guard let post: Post = createPost(caption: caption, location: location, date: date, image: image) else {
            return
        }
        
        
        // 2. Define the API URL
        guard let url = URL(string: "http://192.168.1.165:8080/feed/add/image") else {
            print("Invalid URL")
            return
        }
        
        // 3. Create a URLRequest
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // 4. Encode the profile into JSON
            let jsonData = try JSONEncoder().encode(post)
            request.httpBody = jsonData
            
            // 4. Make the HTTP request using async/await
            let (_, _) = try await URLSession.shared.data(for: request)
            
        } catch {
            print("Error updating and saving profile: \(error)")
        }
    }
}
