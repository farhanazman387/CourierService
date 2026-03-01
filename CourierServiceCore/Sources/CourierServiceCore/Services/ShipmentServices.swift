//
//  ShipmentServices.swift
//  CourierService
//
//  Created by Farhana Azman on 01/03/2026.
//

import Foundation

class ShipmentServices {
    
    func createOptimalShipment(
        from packages: [Package],
        maxWeight: Double
    ) -> Shipment? {
        
        let allCombinations = generateCombinations(packages)
        
        let validShipments = allCombinations
            .map { Shipment(packages: $0) }
            .filter { $0.totalWeight <= maxWeight }
        
        if validShipments.isEmpty {
            return nil
        }
        
        let sortedShipments = validShipments.sorted {
            
            // Rule 1: Maximize number of packages
            if $0.packages.count != $1.packages.count {
                return $0.packages.count > $1.packages.count
            }
            
            // Rule 2: Prefer heavier shipment
            if $0.totalWeight != $1.totalWeight {
                return $0.totalWeight > $1.totalWeight
            }
            
            // Rule 3: Prefer shorter distance
            return $0.maxDistance < $1.maxDistance
        }
        
        return sortedShipments.first
    }
    
    
    private func generateCombinations(
        _ packages: [Package]
    ) -> [[Package]] {
        
        var result: [[Package]] = []
        let n = packages.count
        
        for i in 1..<(1 << n) {
            
            var combination: [Package] = []
            
            for j in 0..<n {
                if (i & (1 << j)) != 0 {
                    combination.append(packages[j])
                }
            }
            
            result.append(combination)
        }
        
        return result
    }
}
