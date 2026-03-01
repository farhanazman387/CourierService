//
//  main.swift
//  CourierService
//
//  Created by Farhana Azman on 01/03/2026.
//

import Foundation
import CourierServiceCore

func readLineInput(prompt: String) -> String {
    print(prompt, terminator: " ")
    guard let input = readLine(), !input.isEmpty else {
        fatalError("Invalid input")
    }
    return input
}

// MARK: - Step 1: Read base cost and number of packages
let firstLine = readLineInput(
    prompt: "Enter base delivery cost and number of packages (e.g. 100 3):"
).split(separator: " ")

let baseDeliveryCost = Double(firstLine[0])!
let numberOfPackages = Int(firstLine[1])!

// MARK: - Initialize services
let offerService = OfferServices()
let costCalculator = CostCalc(baseDeliveryCost: baseDeliveryCost, offerService: offerService)
let shipmentService = ShipmentServices()
let deliveryTimeCalculator = DeliveryTimeCalc(shipmentService: shipmentService)

// MARK: - Step 2: Read package inputs
print("\nEnter package details in format:")
print("PKG_ID WEIGHT(KG) DISTANCE(KM) OFFER_CODE")
print("Example: PKG1 50 30 OFR001")
print("Use NA if no offer\n")

var packages: [Package] = []

for i in 1...numberOfPackages {
    var input = readLineInput(prompt: "Enter details for package \(i):").split(separator: " ")
    
    while input.count != 4{
        print("input is not enough")
        input = readLineInput(prompt: "Enter details for package \(i):").split(separator: " ")
    }
    let id = String(input[0])
    let weight = Double(input[1])!
    let distance = Double(input[2])!
    let offerCode = input[3] == "NA" ? nil : String(input[3])
    
    let package = Package(id: id, weight: weight, distance: distance, offerCode: offerCode)
    packages.append(package)
}

// MARK: - Step 3: Calculate cost
packages = packages.map { costCalculator.calculateCost(for: $0) }

// MARK: - Step 4: Read vehicle info
print("\nEnter vehicle details:")
let vehicleLine = readLineInput(
    prompt: "Enter number_of_vehicles speed(km/hr) max_weight(kg) (e.g. 2 70 200):"
).split(separator: " ")

let numberOfVehicles = Int(vehicleLine[0])!
let speed = Double(vehicleLine[1])!
let maxWeight = Double(vehicleLine[2])!

// MARK: - Step 5: Create vehicles
var vehicles: [Vehicle] = []

for i in 0..<numberOfVehicles {
    let vehicle = Vehicle(id: i + 1, maxWeight: maxWeight, speed: speed)
    vehicles.append(vehicle)
}

// MARK: - Step 6: Calculate delivery times
let finalPackages = deliveryTimeCalculator.calculateDeliveryTimes(
    packages: packages,
    vehicles: vehicles
)

// MARK: - Step 7: Print output as table
print("\nDelivery Summary:")
print("----------------------------------------------------------------")

let col1 = "PKG_ID".padding(toLength: 10, withPad: " ", startingAt: 0)
let col2 = "DISCOUNT".padding(toLength: 10, withPad: " ", startingAt: 0)
let col3 = "TOTAL_COST".padding(toLength: 12, withPad: " ", startingAt: 0)
let col4 = "DELIVERY_TIME".padding(toLength: 15, withPad: " ", startingAt: 0)

print("\(col1)\(col2)\(col3)\(col4)")
print("----------------------------------------------------------------")

for pkg in finalPackages {
    let id = pkg.id.padding(toLength: 10, withPad: " ", startingAt: 0)
    let discount = "\(Int(pkg.discount))".padding(toLength: 10, withPad: " ", startingAt: 0)
    let totalCost = "\(Int(pkg.totalCost))".padding(toLength: 12, withPad: " ", startingAt: 0)
    let deliveryTime = String(format: "%.2f", pkg.deliveryTime).padding(toLength: 15, withPad: " ", startingAt: 0)
    
    print("\(id)\(discount)\(totalCost)\(deliveryTime)")
}

print("----------------------------------------------------------------")

//func readLineInput(prompt: String) -> String {
//    
//    print(prompt, terminator: " ")
//    
//    guard let input = readLine(), !input.isEmpty else {
//        fatalError("Invalid input")
//    }
//    
//    return input
//}
//
//
//let firstLine = readLineInput(
//    prompt: "Enter base delivery cost and number of packages (e.g. 100 3):"
//).split(separator: " ")
//
//let baseDeliveryCost = Double(firstLine[0])!
//let numberOfPackages = Int(firstLine[1])!
//
//// MARK: - Initialize services
//
//let offerService = OfferServices()
//
//let costCalculator = CostCalc(
//    baseDeliveryCost: baseDeliveryCost,
//    offerService: offerService
//)
//
//let shipmentService = ShipmentServices()
//
//let deliveryTimeCalculator = DeliveryTimeCalc(
//    shipmentService: shipmentService
//)
//
//// MARK: - Step 2: Read package inputs
//
//print("\nEnter package details in format:")
//print("PKG_ID WEIGHT(KG) DISTANCE(KM) OFFER_CODE")
//print("Example: PKG1 50 30 OFR001")
//print("Use NA if no offer\n")
//
//var packages: [Package] = []
//
//for i in 1...numberOfPackages {
//    
//    let input = readLineInput(
//        prompt: "Enter details for package \(i):"
//    ).split(separator: " ")
//    
//    let id = String(input[0])
//    let weight = Double(input[1])!
//    let distance = Double(input[2])!
//    
//    let offerCode = input[3] == "NA" ? nil : String(input[3])
//    
//    let package = Package(
//        id: id,
//        weight: weight,
//        distance: distance,
//        offerCode: offerCode
//    )
//    
//    packages.append(package)
//}
//
//// MARK: - Step 3: Calculate cost
//
//packages = packages.map {
//    costCalculator.calculateCost(for: $0)
//}
//
//// MARK: - Step 4: Read vehicle info
//
//print("\nEnter vehicle details:")
//
//let vehicleLine = readLineInput(
//    prompt: "Enter number_of_vehicles speed(km/hr) max_weight(kg) (e.g. 2 70 200):"
//).split(separator: " ")
//
//let numberOfVehicles = Int(vehicleLine[0])!
//let speed = Double(vehicleLine[1])!
//let maxWeight = Double(vehicleLine[2])!
//
//// MARK: - Step 5: Create vehicles
//
//var vehicles: [Vehicle] = []
//
//for i in 0..<numberOfVehicles {
//    
//    let vehicle = Vehicle(
//        id: i + 1,
//        maxWeight: maxWeight,
//        speed: speed
//    )
//    
//    vehicles.append(vehicle)
//}
//
//// MARK: - Step 6: Calculate delivery times
//
//let finalPackages = deliveryTimeCalculator.calculateDeliveryTimes(
//    packages: packages,
//    vehicles: vehicles
//)
//
//// MARK: - Step 7: Print output as table
//
//print("\nDelivery Summary:")
//print("----------------------------------------------------------------")
//
//let col1 = "PKG_ID".padding(toLength: 10, withPad: " ", startingAt: 0)
//let col2 = "DISCOUNT".padding(toLength: 10, withPad: " ", startingAt: 0)
//let col3 = "TOTAL_COST".padding(toLength: 12, withPad: " ", startingAt: 0)
//let col4 = "DELIVERY_TIME".padding(toLength: 15, withPad: " ", startingAt: 0)
//
//print("\(col1)\(col2)\(col3)\(col4)")
//print("----------------------------------------------------------------")
//
//for pkg in finalPackages {
//    
//    let id = pkg.id.padding(toLength: 10, withPad: " ", startingAt: 0)
//    
//    let discount = "\(Int(pkg.discount))"
//        .padding(toLength: 10, withPad: " ", startingAt: 0)
//    
//    let totalCost = "\(Int(pkg.totalCost))"
//        .padding(toLength: 12, withPad: " ", startingAt: 0)
//    
//    let deliveryTime = String(format: "%.2f", pkg.deliveryTime)
//        .padding(toLength: 15, withPad: " ", startingAt: 0)
//    
//    print("\(id)\(discount)\(totalCost)\(deliveryTime)")
//}
//
//print("----------------------------------------------------------------")
