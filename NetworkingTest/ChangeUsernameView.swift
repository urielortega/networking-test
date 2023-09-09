//
//  ChangeUsernameView.swift
//  NetworkingTest
//
//  Created by Uriel Ortega on 07/09/23.
//

import SwiftUI

struct ChangeUsernameView: View {
    // 3. Access EnvironmentObject
    @EnvironmentObject var searchedUser: SearchedUser
    
    // Variable to dismiss ChangeUsernameView.
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Find a GitHub user") {
                    TextField("Enter a username", text: $searchedUser.username)
                        .textInputAutocapitalization(.never)
                }
            }
            .toolbar {
                Button("Search") {
                    // TODO: Look for user, i.e. change username property of ContentView with the value of enteredUsername and then activate searchUser() function.
                    Task {
                        await searchedUser.getGitHubUser(withUsername: searchedUser.username)
                        await searchedUser.getGitHubUserFollowers(withUsername: searchedUser.username)
                    }
                    
                    dismiss()
                }
            }
        }
    }
}
//
//struct ChangeUsernameView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangeUsernameView()
//    }
//}
