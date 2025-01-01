//
//  PostView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2025-01-01.
//

import SwiftUI

struct PostView: View {
    @State var comment: String
    @State var location: String
    @State var date: String
    @State var image: UIImage
    

    var body: some View {
        NavigationView {
            VStack(spacing: 20) { // Add spacing between elements
                // Image with rounded corners and shadow
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()

                // Comment text with styling
                Text(comment)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Location text with icon
                HStack(spacing: 8) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.blue)
                    Text(location)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                // Date text with icon
                HStack(spacing: 8) {
                    Image(systemName: "calendar")
                        .foregroundColor(.green)
                    Text(date)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                Spacer() // Push content to the top
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Post Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
    }
}
