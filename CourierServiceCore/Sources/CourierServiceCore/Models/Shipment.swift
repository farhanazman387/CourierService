//
//  Shipment.swift
//  CourierService
//
//  Created by Farhana Azman on 01/03/2026.
//

import Foundation

class Shipment {
    
    var packages: [Package]
    var totalWeight: Double
    var maxDistance: Double
    
    init(packages: [Package]) {
        self.packages = packages
        self.totalWeight = packages.reduce(0) { $0 + $1.weight }
        self.maxDistance = packages.map { $0.distance }.max() ?? 0
    }
}

