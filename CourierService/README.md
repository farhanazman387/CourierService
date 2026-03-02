important notes

priority orders
1. More packages
2. Heavier weight
3. Shorter distance

deliveryTime = distance / speed

file structure
==========================================================================================================================================================================

CourierService/                      ← Root folder / Xcode project
│
├─ CourierService/                    ← CLI target
│   └─ main.swift                     ← Handles input/output and calls framework
│
├─ CourierServiceCore/                ← Framework target
│   ├─ Sources/
│   │   └─ CourierServiceCore/
│   │       ├─ Models/                ← All data models
│   │       │   ├─ Package.swift
│   │       │   ├─ Vehicle.swift
│   │       │   ├─ Shipment.swift
│   │       │   └─ Offer.swift
│   │       │
│   │       └─ Services/              ← All service classes / calculation logic
│   │           ├─ OfferServices.swift
│   │           ├─ CostCalc.swift
│   │           ├─ ShipmentServices.swift
│   │           └─ DeliveryTimeCalc.swift
│   │
│   └─ Resources/                     ← Optional: assets if needed
│
├─ CourierServiceCoreTests/           ← Unit test target
│   └─ CourierServiceCoreTests.swift  ← Tests for all framework logic
│
└─ CourierService.xcodeproj           ← Xcode project file


Explanation
1. CLI Target – CourierService
Contains only main.swift
Handles user input/output
Imports the framework: import CourierServiceCore

2. Framework – CourierServiceCore
  a) Models/ folder → all data structures:
  - Package.swift, Vehicle.swift, Shipment.swift, Offer.swift
  b) Services/ folder → all calculation and business logic:
  - OfferServices.swift, CostCalc.swift, ShipmentServices.swift, DeliveryTimeCalc.swift
  Everything public so CLI and tests can access it
using framework because CLI cannot be tested due to it is not recognise as a framework
first framework creation

3. Tests – CourierServiceCoreTests
Imports CourierServiceCore
Tests logic in Services and Models independently of CLI
