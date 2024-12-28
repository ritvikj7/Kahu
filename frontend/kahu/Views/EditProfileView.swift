//
//  EditProfileView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-25.
//

import SwiftUI

struct EditProfileView: View {
    // @ObservedObject, similar to @StateObject is used when you want a view to watch for changes in an external object (like your ViewModel) When something changes in the ViewModel (like petProfile), any view observing it will automatically update
    @ObservedObject var viewModel: ProfileViewModel
    
    // @Environment is a property wrapper that allows us to access values that are shared across the app. These values are provided by the SwiftUI framework. \.dismiss is a key path provided by SwiftUI. It gives us access to a built-in function that can dismiss the current view.
    // By writing private var dismiss, we're creating a local variable named dismiss that refers to the dismissing functionality
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    if let petProfile = viewModel.petProfile {
                        VStack {
                            // Profile Picture
                            Image("spike")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 125, height: 125)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .shadow(radius: 10)
                                .padding(.top, 15)
                                .padding(.leading, 15)
                            
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }){
                                Text("Edit Picture")
                                    .font(.body)
                                    .foregroundColor(.blue)
                            }
                            .padding(.leading, 10)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            EditableRowView(label: "Name: ", text: Binding(
                                get: { petProfile.name },
                                set: { viewModel.petProfile?.name = $0 }
                            ))
                            Divider()
                            EditableRowView(label: "Breed: ", text: Binding(
                                get: { petProfile.breed },
                                set: { viewModel.petProfile?.breed = $0 }
                            ))
                            Divider()
                            EditableRowView(label: "Age: ", text: Binding(
                                get: { String(petProfile.age) },  // Convert Int to String for display
                                set: { if let newValue = Int($0) {  // Try to convert String back to Int
                                    viewModel.petProfile?.age = newValue
                                }}
                            ))
                            Divider()
                            EditableRowView(label: "Birthday: ", text: Binding(
                                get: { petProfile.birthday },
                                set: { viewModel.petProfile?.birthday = $0 }
                            ))
                            Divider()
                            EditableRowView(label: "Weight: ", text: Binding(
                                get: { String(petProfile.weight) },  // Convert Int to String for display
                                set: { if let newValue = Int($0) {  // Try to convert String back to Int
                                    viewModel.petProfile?.weight = newValue
                                }}
                            ))
                            Divider()
                            EditableRowView(label: "Gender: ", text: Binding(
                                get: { petProfile.gender },
                                set: { viewModel.petProfile?.gender = $0 }
                            ))
                            Divider()
                            EditableRowView(label: "Colour: ", text: Binding(
                                get: { petProfile.colour },
                                set: { viewModel.petProfile?.colour = $0 }
                            ))
                        }
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .padding(.vertical)
                        
                        Button(action: {
                            // Save the updated profile to a database or server
                            Task {
                                await viewModel.saveProfile()
                                dismiss() // Dismiss the current view to return to ProfileView
                            }
                        }) {
                            Text("Save Changes")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding()
                    } else {
                        ProgressView("Loading profile...")
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Edit Profile")
    }
}

