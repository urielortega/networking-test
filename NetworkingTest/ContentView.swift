//
//  ContentView.swift
//  NetworkingTest
//
//  Created by Uriel Ortega on 27/08/23.
//

import SwiftUI

// View that shows user details and followers
struct ContentView: View {
    @State private var showingChangeUsernameView = false
    
    // 1. Instance of EnvironmentObject
    @StateObject var searchedUser = SearchedUser()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // User picture.
                    AsyncImage(url: URL(string: searchedUser.gitHubUser.avatarUrl)) { phase in
                        if let image = phase.image { // Image was loaded.
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.40), radius: 15)
                        } else if phase.error != nil { // An error ocurred.
                            Circle()
                                .foregroundColor(.secondary)
                        } else { // Image is loading.
                            ProgressView()
                        }
                    }
                    .frame(width: 120, height: 120)
                    
                    // Username.
                    Text(searchedUser.gitHubUser.login)
                        .bold()
                        .font(.title3)
                    
                    // User bio.
                    Text(searchedUser.gitHubUser.bio)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    // User location.
                    Text("📍\n\(searchedUser.gitHubUser.location)")
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                    
                    // List of user followers.
                    VStack(alignment: .leading) {
                        Text("Followers")
                            .bold()
                            .font(.title2)
                        
                        ForEach(searchedUser.gitHubUserFollowers) { follower in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.gray.opacity(0.2))
                                
                                HStack {
                                    Text(follower.login)
                                        .padding(.vertical, 0.5)
                                    
                                    Spacer()
                                }
                                .padding(12)
                            }
                        }
                    }
                }
                .padding()
                .navigationTitle("GitHub Finder")
                .toolbar {
                    Button {
                        showingChangeUsernameView.toggle()
                    } label: {
                        Label("Change username", systemImage: "magnifyingglass")
                    }
                }
                .sheet(isPresented: $showingChangeUsernameView) {
                    ChangeUsernameView()
                }
                .alert("Something went wrong", isPresented: $searchedUser.showingErrorAlert) { } message: {
                    Text(searchedUser.errorMessage)
                }
            }
        }
        // 2. Inject EnvironmentObject to the main View.
        .environmentObject(searchedUser)
        .task {
            await searchedUser.getGitHubUser(withUsername: searchedUser.username)
            await searchedUser.getGitHubUserFollowers(withUsername: searchedUser.username)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
