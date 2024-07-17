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
        Text("Hello, World!")
    }
}

#Preview {
    CheckoutView(order: Order())
}
