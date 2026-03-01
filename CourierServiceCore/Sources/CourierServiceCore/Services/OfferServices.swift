//
//  OfferServices.swift
//  CourierService
//
//  Created by Farhana Azman on 01/03/2026.
//

import Foundation

class OfferServices {
    
    private var offers: [String: Offer] = [:]
    
    init() {
        loadOffers()
    }
    
    private func loadOffers() {
        
        let offer1 = Offer(
            code: "OFR001",
            discountPercentage: 10,
            minWeight: 70,
            maxWeight: 200,
            minDistance: 0,
            maxDistance: 200
        )
        
        let offer2 = Offer(
            code: "OFR002",
            discountPercentage: 7,
            minWeight: 100,
            maxWeight: 250,
            minDistance: 50,
            maxDistance: 150
        )
        
        let offer3 = Offer(
            code: "OFR003",
            discountPercentage: 5,
            minWeight: 10,
            maxWeight: 150,
            minDistance: 50,
            maxDistance: 250
        )
        
        offers[offer1.code] = offer1
        offers[offer2.code] = offer2
        offers[offer3.code] = offer3
    }
    
    func calculateDiscount(for package: Package, baseCost: Double) -> Double {
        
        guard let code = package.offerCode,
              let offer = offers[code],
              offer.isApplicable(weight: package.weight, distance: package.distance)
        else {
            return 0
        }
        
        return baseCost * offer.discountPercentage / 100
    }
}

