//
//  RecommendCard.swift
//  myprojec
//
//  Created by E4 on 2023/01/09.
//

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the recommended parking spot.
*/

import SwiftUI
import WeatherKit
import CoreLocation
import os

// 자신의 위치에 날씨정보 및 자신의 위치 표시할때 사용
struct weatherIconView : View {
    
    let logger = Logger(subsystem: "net.e4net.myprojec.views.setting.RecommendCard.weatherIconView", category: "Struct")
    
    var imageName: String
    var temperature : Int
    @State var weater :String
    let locationManager = CLLocationManager()
    var weatherManager = WeatherAPIClient()
    func WhenYourWeather() async throws -> String {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
//        locationManager.requestLocation()
        Task{
            let ste = await weatherManager.fetchWeather(lat: "37.509084", long: "127.058316")
            logger.info("\(ste)")
            return String(ste)
        }
    
        
        return ""
    }
    
    func Weather() async throws -> String {
        
    
      let basic =  Task{
         let wt = try await WhenYourWeather()
          return wt
         }
        return try! await basic.value
    }

    var body: some View {
        
        Text(weater).onAppear{
            Task{
                do{
                    weater = try await WhenYourWeather()
                }
                
            }
            
            
        }
        
      
        Image(systemName: imageName).renderingMode(.original)
        
        
    }
    
    
}
struct RecommendedParkingSpotCard: View {
    var parkingSpot: Parking
    var condition: WeatherCondition
    var temperature: Measurement<UnitTemperature>
    var symbolName: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.tertiary)
                Text("E4net")
                Text("Gang Nam Land Mark")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .layoutPriority(1)
            
            Spacer()
            
            ViewThatFits {
                HStack {
//                    weatherIconView(imageName: "sun.max.fill", temperature: 0, weater: "")
                
                    Label("Popular", systemImage: "person.3")
                    Label("Transtor", systemImage: "text.bubble")
                }
                
                HStack {
                    Label(temperature.formatted(), systemImage: symbolName)
                    Label("Popular", systemImage: "person.3")
                }
                
                Label(temperature.formatted(), systemImage: symbolName)
            }
            .labelStyle(RecommendedSpotSummaryLabelStyle())
        }
        .padding()
        .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

struct RecommendedParkingSpotCard_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedParkingSpotCard(
            parkingSpot: City.seoul.parkingSpots[0],
            condition: .clear,
            temperature: Measurement(value: 72, unit: .fahrenheit),
            symbolName: "sun.max"
        )
    }
}

struct RecommendedSpotSummaryLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
                .font(.system(size: 18))
                .imageScale(.large)
                .frame(width: 30, height: 30)
                .foregroundStyle(.secondary)
            configuration.title
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
    }
}
