//
//  DeliveryTimeCalc.swift
//  CourierService
//
//  Created by Farhana Azman on 01/03/2026.
//

import Foundation

final class DeliveryTimeCalc {
    
    private let shipmentService: ShipmentServices
    
    init(shipmentService: ShipmentServices) {
        self.shipmentService = shipmentService
    }
    
    func calculateDeliveryTimes(
        packages: [Package],
        vehicles: [Vehicle]
    ) -> [Package] {
        
        var remainingPackages = packages
        var updatedPackages: [String: Package] = [:]
        
        var vehiclesQueue = vehicles
        
        while !remainingPackages.isEmpty {
            
            // Sort vehicles by next available time
            vehiclesQueue.sort { $0.availableAt < $1.availableAt }
            
            // Remove the next available vehicle
            var vehicle = vehiclesQueue.removeFirst()
            
            // Get optimal shipment
            guard let shipment = shipmentService.createOptimalShipment(
                from: remainingPackages,
                maxWeight: vehicle.maxWeight
            ) else {
                break
            }
            
            let deliveryTime = shipment.maxDistance / vehicle.speed
            
            // Assign delivery times
            for var pkg in shipment.packages {
                
                let estimatedTime = vehicle.availableAt + deliveryTime
                
                pkg.deliveryTime = roundToTwoDecimals(estimatedTime)
                
                updatedPackages[pkg.id] = pkg
            }
            
            // Update vehicle next availability (go + return)
            vehicle.availableAt += deliveryTime * 2
            
            // Put vehicle back into queue
            vehiclesQueue.append(vehicle)
            
            // Remove shipped packages
            remainingPackages.removeAll { pkg in
                shipment.packages.contains { $0.id == pkg.id }
            }
        }
        
        // Return packages in original order
        return packages.map { updatedPackages[$0.id] ?? $0 }
    }
    
    private func roundToTwoDecimals(_ value: Double) -> Double {
        return floor(value * 100) / 100
    }
}
