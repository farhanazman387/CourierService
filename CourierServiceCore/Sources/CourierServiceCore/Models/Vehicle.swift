//
//  Vehicle.swift
//  CourierService
//
//  Created by Farhana Azman on 01/03/2026.
//

import Foundation

class Vehicle {
    
    let id: Int
    let maxWeight: Double
    let speed: Double
    
    // This tells when vehicle becomes available again
    var availableAt: Double
    
    init(id: Int, maxWeight: Double, speed: Double) {
        self.id = id
        self.maxWeight = maxWeight
        self.speed = speed
        self.availableAt = 0
    }
}
