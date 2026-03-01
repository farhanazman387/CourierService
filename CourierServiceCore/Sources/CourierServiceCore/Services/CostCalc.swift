//
//  CostCalc.swift
//  CourierService
//
//  Created by Farhana Azman on 01/03/2026.
//

import Foundation

final class CostCalc {
    
    private let offerService: OfferServices
    private let baseDeliveryCost: Double
    
    init(baseDeliveryCost: Double, offerService: OfferServices) {
        self.baseDeliveryCost = baseDeliveryCost
        self.offerService = offerService
    }
    
    func calculateCost(for package: Package) -> Package {
        
        let deliveryCost = calculateDeliveryCost(
            weight: package.weight,
            distance: package.distance
        )
        
        let discount = offerService.calculateDiscount(
            for: package,
            baseCost: deliveryCost
        )
        
        let totalCost = deliveryCost - discount
        
        return buildUpdatedPackage(
            from: package,
            discount: discount,
            totalCost: totalCost
        )
    }
    
    private func calculateDeliveryCost(weight: Double, distance: Double) -> Double {
        return baseDeliveryCost + (weight * 10) + (distance * 5)
    }
    
    private func buildUpdatedPackage(
        from package: Package,
        discount: Double,
        totalCost: Double
    ) -> Package {
        
        var updatedPackage = package
        updatedPackage.discount = discount
        updatedPackage.totalCost = totalCost
        
        return updatedPackage
    }
}
