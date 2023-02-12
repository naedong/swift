//
//  ParkingSpot.swift
//  myprojec
//
//  Created by E4 on 2023/01/09.
//

import Foundation
import CoreLocation

public struct Parking: Identifiable, Hashable {
    public var id: String { name }
    public var name: String
    public var location: CLLocation
    public var cameraDistance: Double = 1000
}
