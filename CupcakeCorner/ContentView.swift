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
            Button("Tap Me", action: complexSuccess)
                .onAppear(perform: prepareHaptics)
        }
    }
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
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
