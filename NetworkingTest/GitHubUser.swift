//
//  GitHubUser.swift
//  NetworkingTest
//
//  Created by Uriel Ortega on 27/08/23.
//

import Foundation

struct GitHubUser: Codable, Identifiable {
    let login: String
    let id: Int
    let avatarUrl: String
    let bio: String
    let location: String    
}
