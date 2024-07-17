//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Hina Khan on 14/07/2024.
//

import SwiftUI

struct CheckoutView: View {
    @Bindable var order: Order

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order", action: { })
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)

    }
}

#Preview {
    CheckoutView(order: Order())
}
