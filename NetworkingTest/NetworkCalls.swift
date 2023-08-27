//
//  NetworkCalls.swift
//  NetworkingTest
//
//  Created by Uriel Ortega on 27/08/23.
//

import Foundation

func getUser() async throws -> GitHubUser {
    let endpoint = "https://api.github.com/users/urielortega" // Hardcoded user (can be any user later)
    guard let url = URL(string: endpoint) else {
        print("Invalid URL")
        throw GHError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url) // GET request.
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { // 200 means OK
        throw GHError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase // To convert the snake case from the JSON to camel case (as our GitHubUser)
        return try decoder.decode(GitHubUser.self, from: data)
    } catch {
        throw GHError.invalidData
    }
}
