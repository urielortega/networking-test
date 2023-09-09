//
//  GitHubFollower.swift
//  NetworkingTest
//
//  Created by Uriel Ortega on 08/09/23.
//

import Foundation

// Struct used to show the user followers details.
struct GitHubFollower: Codable, Identifiable {
    let login: String
    let id: Int
}
