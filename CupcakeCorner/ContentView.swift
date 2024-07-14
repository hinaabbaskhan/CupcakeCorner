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
    @State private var order = Order()

    var body: some View {
        VStack{
            Button("Encode Taylor", action: encodeTaylor)
            Button("Tap Count: \(counter)") {
                counter += 1
            }.sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
            Button("Tap Me", action: complexSuccess)
                .onAppear(perform: prepareHaptics)
            NavigationStack {
                Form {
                    Section {
                        Picker("Select your cake type", selection: $order.type) {
                            ForEach(Order.types.indices, id: \.self) {
                                Text(Order.types[$0])
                            }
                        }

                        Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                    }
                }
                .navigationTitle("Cupcake Corner")
            }
            
            Section {
                Toggle("Any special requests?", isOn: $order.specialRequestEnabled)

                if order.specialRequestEnabled {
                    Toggle("Add extra frosting", isOn: $order.extraFrosting)

                    Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                }
            }
            Section {
                NavigationLink("Delivery details") {
                    AddressView(order: order)
                }
            }
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
