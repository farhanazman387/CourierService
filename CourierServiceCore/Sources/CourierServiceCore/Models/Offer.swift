//
//  Offer.swift
//  CourierService
//
//  Created by Farhana Azman on 01/03/2026.
//

import Foundation

struct Offer {
    
    let code: String
    let discountPercentage: Double
    let minWeight: Double
    let maxWeight: Double
    let minDistance: Double
    let maxDistance: Double
    
    func isApplicable(weight: Double, distance: Double) -> Bool {
        return weight >= minWeight &&
               weight <= maxWeight &&
               distance >= minDistance &&
               distance <= maxDistance
    }
}
