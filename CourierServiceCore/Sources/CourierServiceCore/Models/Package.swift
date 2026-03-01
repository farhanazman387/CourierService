//
//  Package.swift
//  CourierService
//
//  Created by Farhana Azman on 01/03/2026.
//

import Foundation

struct Package {
    
    let id: String
    let weight: Double
    let distance: Double
    let offerCode: String?
    
    // calculated values
    var discount: Double = 0
    var totalCost: Double = 0
    var deliveryTime: Double = 0
    
}
