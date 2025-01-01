//
//  FeedView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-31.
//

import SwiftUI

struct FeedView: View {
    @State var numberOfPosts = 6
    @State var currentState: String = "Regular"
    private var images: [String] {
            let regularImages = ["spike", "haikyu", "image", "image", "spike", "haikyu"]
            let aiImages = ["haikyu", "haikyu", "image", "spike", "spike", "image"]
            return currentState == "Regular" ? regularImages : aiImages
        }
    
    // Calculate grid layout
    let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    HStack(spacing: 55) {
                        CountLabelView(count: String(numberOfPosts), label: "Posts")
                        CountLabelView(count: "15", label: "Comments")
                        CountLabelView(count: "4", label: "Likes")
                    }
                    .padding()
                    
                    HStack() {
                        Spacer()
                        Button(action: {
                            currentState = "Regular"
                        }) {
                            Image(systemName: "squareshape.split.3x3") // Regular photo icon
                                .font(.title)
                                .foregroundColor(currentState == "Regular" ? Color.primary : Color.secondary)
                            }
                        Spacer()
                        Button(action: {
                            currentState = "AI"
                        }) {
                            Image(systemName: "wand.and.stars") // AI transformation icon
                                .font(.title)
                                .foregroundColor(currentState == "AI" ? Color.primary : Color.secondary)
                        }
                        Spacer()

                    }
                    .padding()

                    
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(images.indices, id: \.self) { index in
                            Image(images[index])
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width - 2) / 3, height: (UIScreen.main.bounds.width - 2) / 3)
                                .clipped()
                        }
                    }
                    .padding(.horizontal, 0)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Feed")
        }
    }
}


#Preview {
    FeedView()
}
