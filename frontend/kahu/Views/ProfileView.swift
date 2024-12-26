//
//  ProfileView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-21.
//

import SwiftUI

struct ProfileView: View {
    // Observing the ProfileViewModel
    // @StateObject is used to create and manage the lifecycle of an ObservableObject within a view. It ensures that the object persists across view updates and is not recreated unnecessarily
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            ScrollView{
                VStack() { // Added spacing: 0 to reduce default spacing
                   if let petProfile = viewModel.petProfile {
                       HStack {
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
                           
                           HStack(spacing: 10){
                               CountLabelView(count: "0", label: "Posts")
                               CountLabelView(count: "4", label: "Followers")
                               CountLabelView(count: "15", label: "Following")
                           }
                           .padding()
                       }

                        
                        // Edit Profile Button
                       NavigationLink(destination: EditProfileView2(viewModel: viewModel)) {
                            Text("Edit Profile")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding()
                        

                        // Pet profile details
                        VStack(alignment: .leading, spacing: 15) {
                            ProfileRowView(label: "Name: ", labelInfo: "\(petProfile.name)")
                            Divider()
                            ProfileRowView(label: "Breed: ", labelInfo: "\(petProfile.breed)")
                            Divider()
                            ProfileRowView(label: "Age: ", labelInfo: "\(petProfile.age)")
                            Divider()
                            ProfileRowView(label: "Birthday: ", labelInfo: "\(petProfile.birthday)")
                            Divider()
                            ProfileRowView(label: "Weight: ", labelInfo: "\(petProfile.weight)")
                            Divider()
                            ProfileRowView(label: "Gender: ", labelInfo: "\(petProfile.gender)")
                            Divider()
                            ProfileRowView(label: "Colour: ", labelInfo: "\(petProfile.colour)")
                        }
                        .padding()
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .padding(.vertical)

                    } else {
                        // Show a loading or placeholder message
                        Text("Loading profile...")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onAppear {
                // Fetch the profile when the view appears
                // .onAppear is a SwiftUI view modifier that attaches an action to be performed when the view is added to the view hierarchy
                if viewModel.petProfile == nil {
                        // Task is a unit of asynchronous work
                        Task {
                            await viewModel.getProfile()
                        }
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Profile")
            .padding()
        }
    }
}

struct EditProfileView2: View {
    // @ObservedObject, similar to @StateObject is used when you want a view to watch for changes in an external object (like your ViewModel) When something changes in the ViewModel (like petProfile), any view observing it will automatically update
    @ObservedObject var viewModel: ProfileViewModel
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
