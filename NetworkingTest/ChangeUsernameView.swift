//
//  ChangeUsernameView.swift
//  NetworkingTest
//
//  Created by Uriel Ortega on 07/09/23.
//

import SwiftUI

struct ChangeUsernameView: View {
    @State private var enteredUsername: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Find a GitHub user") {
                    TextField("Enter a username", text: $enteredUsername)
                        .textInputAutocapitalization(.never)
                }
            }
            .toolbar {
                Button("Search") {
                    // TODO: Look for user
                    
                    dismiss()
                }
            }
        }
    }
}

struct ChangeUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUsernameView()
    }
}
