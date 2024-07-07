//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Hina Khan on 19/06/2024.
//

import SwiftUI


struct ContentView: View {
    @State private var username = ""
    @State private var email = ""

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
