//
//  ContentView.swift
//  NetworkingTest
//
//  Created by Uriel Ortega on 27/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingChangeUsernameView = false

    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    
    @State private var username = "urielortega"

    @State private var gitHubUser: GitHubUser? // Displayed user.
    @State private var userFollowers: [GitHubFollower]? // Followers of the displayed user.

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    AsyncImage(url: URL(string: gitHubUser?.avatarUrl ?? "")) { phase in
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
                    
                    Text(gitHubUser?.login ?? "Loading username...")
                        .bold()
                        .font(.title3)
                    
                    Text(gitHubUser?.bio ?? "Loading user bio...")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("📍\n\(gitHubUser?.location ?? "Loading user location...")")
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                    
                    VStack(alignment: .leading) {
                        Text("Followers")
                            .bold()
                            .font(.title2)
                        
                        ForEach(userFollowers ?? Array<GitHubFollower>()) { follower in
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
            }
        }
        .task {
            await searchUser(withUsername: username)
        }
    }
    
    func searchUser(withUsername username: String) async {
        do {
            gitHubUser = try await getUser(withUsername: username)
            userFollowers = try await getUserFollowers(withUsername: username)
            print(userFollowers?.count ?? "Not able to count userFollowers.")
        } catch GHError.invalidURL {
            errorMessage = "Please enter a valid username."
            showingErrorAlert = true
        } catch GHError.invalidResponse {
            errorMessage = "Please try again."
            showingErrorAlert = true
        } catch GHError.invalidData {
            errorMessage = "Please try again."
            showingErrorAlert = true
        } catch {
            errorMessage = "Unexpected error."
            showingErrorAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
