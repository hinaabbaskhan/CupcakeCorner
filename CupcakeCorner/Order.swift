//
//  Order.swift
//  CupcakeCorner
//
//  Created by Hina Khan on 13/07/2024.
//

import Foundation
@Observable
class Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var extraFrosting = false
    var addSprinkles = false
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
}
