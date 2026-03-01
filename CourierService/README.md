priority orders
1. More packages
2. Heavier weight
3. Shorter distance

deliveryTime = distance / speed

file structure

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

CLI Target – CourierService

Contains only main.swift

Handles user input/output

Imports the framework: import CourierServiceCore

Framework – CourierServiceCore

Models/ folder → all data structures:

Package.swift, Vehicle.swift, Shipment.swift, Offer.swift

Services/ folder → all calculation and business logic:

OfferServices.swift, CostCalc.swift, ShipmentServices.swift, DeliveryTimeCalc.swift

Everything public so CLI and tests can access it

Tests – CourierServiceCoreTests

Imports CourierServiceCore

Tests logic in Services and Models independently of CLI

Resources/ (optional)

Only if the framework needs static a
