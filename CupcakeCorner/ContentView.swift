//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Hina Khan on 19/06/2024.
//

import SwiftUI
@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
            case _name = "name"
        }
    
    
    var name = "Taylor"
}


struct ContentView: View {
    @State private var counter = 0

    var body: some View {
        VStack{
            Button("Encode Taylor", action: encodeTaylor)
            Button("Tap Count: \(counter)") {
                counter += 1
            }.sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: counter)
        }
    }

    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    ContentView()
}
