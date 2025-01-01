//
//  PostView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2025-01-01.
//

import SwiftUI

struct PostView: View {
    @State var image: UIImage
    @State var post: Post
    @StateObject private var postViewModel: PostViewModel = PostViewModel()
    @Environment(\.dismiss) private var dismiss
    

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
                Text(post.caption)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Location text with icon
                HStack(spacing: 8) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.blue)
                    Text(post.location)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

                // Date text with icon
                HStack(spacing: 8) {
                    Image(systemName: "calendar")
                        .foregroundColor(.green)
                    Text(post.date)
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
                    Task{
                        await postViewModel.deleteImage(post: post)
                        dismiss() // Dismiss the current view to return to FeedView
                    }
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
    }
}
