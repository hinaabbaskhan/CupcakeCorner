//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Hina Khan on 19/06/2024.
//

import SwiftUI
import CoreHaptics
@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
            case _name = "name"
        }
    
    
    var name = "Taylor"
}


struct ContentView: View {
    @State private var counter = 0
    @State private var engine: CHHapticEngine?

    var body: some View {
        VStack{
            Button("Encode Taylor", action: encodeTaylor)
            Button("Tap Count: \(counter)") {
                counter += 1
            }.sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
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
