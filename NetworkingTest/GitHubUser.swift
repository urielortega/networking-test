//
//  GitHubUser.swift
//  NetworkingTest
//
//  Created by Uriel Ortega on 27/08/23.
//

import Foundation

struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}
