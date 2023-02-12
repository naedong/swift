//
//  SettingsWeb.swift
//  myprojec
//
//  Created by E4 on 2023/01/09.
//


import SwiftUI


struct ParkingSpotShowcaseView: View {
    var spot: Parking
    var topSafeAreaInset: Double
    var animated = true

    var body: some View {
        GeometryReader { proxy in
            TimelineView(.animation(paused: !animated)) { context in
                let seconds = context.date.timeIntervalSince1970
                let rotationPeriod = 240.0
                let headingDelta = seconds.percent(truncation: rotationPeriod)
                let pitchPeriod = 60.0
                let pitchDelta = seconds
                    .percent(truncation: pitchPeriod)
                    .symmetricEaseInOut()

                let viewWidthPercent = (350.0 ... 1000).percent(for: proxy.size.width)
                let distanceMultiplier = (1 - viewWidthPercent) * 0.5 + 1

                MapView(
                    location: spot.location,
                    distance: distanceMultiplier * spot.cameraDistance,
                    pitch: (50...60).value(percent: pitchDelta),
                    heading: 360 * headingDelta,
                    topSafeAreaInset: topSafeAreaInset
                )
            }
        }
    }
}

struct ParkingSpotShowcaseView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingSpotShowcaseView(spot: City.seoul.parkingSpots[0], topSafeAreaInset: 0)
    }
}
