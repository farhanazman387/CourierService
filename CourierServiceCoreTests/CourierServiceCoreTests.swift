//
//  CourierServiceCoreTests.swift
//  CourierServiceCoreTests
//
//  Created by Farhana Azman on 02/03/2026.
//

import XCTest
@testable import CourierServiceCore

final class CourierServiceCoreTests: XCTestCase {

    func testOffer() {
        let offer = Offer(code: "OFR001", discountPercentage: 10, minWeight: 10, maxWeight: 100, minDistance: 5, maxDistance: 50)
        let pkg = Package(id: "PKG1", weight: 50, distance: 30, offerCode: "OFR001")
        XCTAssertTrue(offer.isApplicable(weight: 50, distance: 30))
    }

    func testCalculateCost() {
        let offerService = OfferServices()
        let costCalc = CostCalc(baseDeliveryCost: 100, offerService: offerService)

        var pkg = Package(id: "PKG1", weight: 50, distance: 30, offerCode: nil)
        pkg = costCalc.calculateCost(for: pkg)

        XCTAssertTrue(pkg.totalCost > 0)
    }

    func testDeliveryTime() {
        let shipmentService = ShipmentServices()
        let calc = DeliveryTimeCalc(shipmentService: shipmentService)

        let pkg = Package(id: "PKG1", weight: 50, distance: 70, offerCode: nil)
        let vehicle = Vehicle(id: 1, maxWeight: 200, speed: 70)
        let result = calc.calculateDeliveryTimes(packages: [pkg], vehicles: [vehicle])

        XCTAssertEqual(result[0].deliveryTime, 1.0, accuracy: 0.001)
    }
}
