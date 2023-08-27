//
//  ContentView.swift
//  NetworkingTest
//
//  Created by Uriel Ortega on 27/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var user: GitHubUser?
    
    var body: some View {
        VStack(spacing: 20) {
            
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 120, height: 120)
            
            Text(user?.login ?? "Login Placeholder")
                .bold()
                .font(.title3)
            
            Text(user?.bio ?? "Bio Placeholder")
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getUser()
            } catch GHError.invalidURL {
                // Let the user know what's going on with the invalidURL error.
                print("Invalid URL")
            } catch GHError.invalidResponse {
                // Let the user know what's going on with the invalidResponse error.
                print("Invalid response")
            } catch GHError.invalidData {
                // Let the user know what's going on with the invalidData error.
                print("Invalid data")
            } catch {
                // Let the user know what's going if there's an unknown error.
                print("Unexpected error")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
