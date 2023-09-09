//
//  GitHubUser.swift
//  NetworkingTest
//
//  Created by Uriel Ortega on 27/08/23.
//

import Foundation

// struct used to show GitHub user details.
struct GitHubUser: Codable, Identifiable {
    let login: String
    let id: Int
    let avatarUrl: String
    let bio: String
    let location: String
    
    static let example = GitHubUser(
        login: "Loading username...",
        id: 1,
        avatarUrl: "",
        bio: "Loading bio...",
        location: "Loading location..."
    )
}
