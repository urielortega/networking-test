//
//  SearchedUser.swift
//  NetworkingTest
//
//  Created by Uriel Ortega on 09/09/23.
//

import Foundation

// Class used to get and set the username value and find a GitHub user.
@MainActor class SearchedUser: ObservableObject {
    @Published var username: String = "urielortega"
    @Published var errorMessage: String = ""
    @Published var showingErrorAlert: Bool = false
    
    @Published var gitHubUser: GitHubUser = .example
    @Published var gitHubUserFollowers: [GitHubFollower] = []
        
    func getGitHubUser(withUsername username: String) async {
        do {
            gitHubUser = try await getUser(withUsername: username)
        } catch GHError.invalidURL {
            errorMessage = "Please try with another username."
            showingErrorAlert = true
            
            setDefaultValues()
        } catch GHError.invalidResponse {
            setUnexpectedErrorValues()
            setDefaultValues()
        } catch GHError.invalidData {
            setUnexpectedErrorValues()
            setDefaultValues()
        } catch {
            setUnexpectedErrorValues()
            setDefaultValues()
        }
    }
        
    func getGitHubUserFollowers(withUsername username: String) async {
        do {
            gitHubUserFollowers = try await getUserFollowers(withUsername: username)
        } catch GHError.invalidURL {
            errorMessage = "Please try with another username."
            showingErrorAlert = true
            
            setDefaultValues()
        } catch GHError.invalidResponse {
            setUnexpectedErrorValues()
            setDefaultValues()
        } catch GHError.invalidData {
            setUnexpectedErrorValues()
            setDefaultValues()
        } catch {
            setUnexpectedErrorValues()
            setDefaultValues()
        }
    }
    
    func setDefaultValues() {
        gitHubUser = .example
        gitHubUserFollowers = []
    }
    
    func setUnexpectedErrorValues() {
        errorMessage = "An unexpected error occured. Please try again."
        showingErrorAlert = true
    }
}
