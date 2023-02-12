//
//  WeatherAPIClient.swift
//  myprojec
//
//  Created by E4 on 2023/01/09.
//

import Foundation
import CoreLocation

final class WeatherAPIClient: NSObject, CLLocationManagerDelegate {
    var currentWeather: WeatherValue?
    
    private let locationManager = CLLocationManager()
    private let dateFormatter = ISO8601DateFormatter()
    
    override init() {
        super.init()
        locationManager.delegate = self
        requestLocation()
    }

    func fetchWeather(lat : String, long : String) async -> Double {
//        guard let location = locationManager.location else {
//            requestLocation()
//            return
//        }
        
        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=\(lat),\(long)&fields=temperature&fields=weatherCode&units=metric&timesteps=1h&startTime=\(dateFormatter.string(from: Date()))&endTime=\(dateFormatter.string(from: Date().addingTimeInterval(60 * 60)))&apikey=S5X7qzJ1VNnbnsBhglNDfCsr5Cf8DK1c") else {
            return 0.0
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let weatherResponse = try? JSONDecoder().decode(WeatherModel.self, from: data) {
                currentWeather = weatherResponse.data.timelines.first?.intervals.first?.values
                if currentWeather != nil{
                    return currentWeather?.temperature ?? 0.0
                }
            }
        } catch {
            // handle the error
        }
        return currentWeather?.temperature ?? 0.0
    }
    
    private func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // handle the error
    }
}
