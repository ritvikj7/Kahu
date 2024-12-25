import SwiftUI

struct ProfileView: View {
    // Observing the ProfileViewModel
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
                        Button(action: {
                            // Add action to edit profile
                        }) {
                            Text("Edit Profile")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 51/255, green: 51/255, blue: 51/255))
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
                        .background(Color.white)
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
                Task {
                    await viewModel.getProfile()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("\(viewModel.petProfile?.name ?? "Pet")s Profile")
            .padding()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
