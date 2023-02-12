//
//  City.swift
//  myprojec
//
//  Created by E4 on 2023/01/09.
//

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The city model object.
*/

import Foundation
import CoreLocation

public struct City: Identifiable, Hashable {
    public var id: String { name }
    public var name: String
    public var parkingSpots: [Parking]
}

public extension City {
  
    static let seoul = City(
        name: String(localized: "E4net",  comment: "A city in Korea."),
        parkingSpots: [
            Parking(
                name: String(localized: "Dong Sung Building", comment: "A landmark in E4net."),
                location: CLLocation(latitude: 37.509084, longitude: 127.058316),
                cameraDistance: 350
            ),
            Parking(
                name: String(localized: "Coex", comment: "A station in E4net."),
                location: CLLocation(latitude: 37.512661, longitude: 127.058714),
                cameraDistance: 850
            )
        ]
    )
    
    static let all = [ seoul]
    
    static func identified(by id: City.ID) -> City {
        guard let result = all.first(where: { $0.id == id }) else {
            fatalError("Unknown City ID: \(id)")
        }
        return result
    }
}
