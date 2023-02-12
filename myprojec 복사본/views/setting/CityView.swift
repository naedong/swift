//
//  Settings.swift
//  myprojec
//
//  Created by E4 on 2023/01/09.
//
/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that shows details about a city.
*/

import SwiftUI
import WeatherKit
import os

enum Panel: Hashable {
   
    case myPage
  
    case settings

    case city(City.ID)
}

@MainActor struct CityView: View {
    var city: City
    
    @EnvironmentObject var getCheck : MySelectColor
    @Binding var selection : Panel?
    @Binding var gradient : ColorsModel
    @State private var spot: Parking = City.seoul.parkingSpots[0]
    @State  var path = NavigationPath()
    
    @State private var condition: WeatherCondition?
    
    @State private var willRainSoon: Bool?
    @State private var cloudCover: Double?
    @State private var temperature: Measurement<UnitTemperature>?
    @State private var symbolName: String?
    
    @State private var attributionLink: URL?
    @State private var attributionLogo: URL?
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var colorSet = ColorSet.defaultStore

    @State  var selectset : ChoiceSetting? = ChoiceSetting.mySetting
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ZStack {
                    Text("Beautiful Map")
                        .hidden()
                        .frame(height: 350)
                        .frame(maxWidth: .infinity)
                }
                .background(alignment: .bottom) {
                    ParkingSpotShowcaseView(spot: spot, topSafeAreaInset: 0)
#if os(iOS)
                        .mask {
                            //                            MapMarker(coordinate: , tint: Color(.red))
                            
                            LinearGradient(
                                stops: [
                                    .init(color: .clear, location: 0),
                                    .init(color: .black.opacity(0.15), location: 0.1),
                                    .init(color: .black, location: 0.6),
                                    .init(color: .black, location: 1)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        }
                    
                        .padding(.top, -150)
#endif
                }
                .overlay(alignment: .bottomTrailing) {
                    if let currentWeatherCondition = condition, let willRainSoon = willRainSoon, let symbolName = symbolName {
                        CityWeatherCard(
                            condition: currentWeatherCondition,
                            willRainSoon: willRainSoon,
                            symbolName: symbolName
                        )
                        .padding(.bottom)
                    }
                }
                
                VStack {
                    RecommendedParkingSpotCard(
                        parkingSpot: spot,
                        condition: condition ?? .clear,
                        temperature: temperature ?? Measurement(value: 72, unit: .fahrenheit),
                        symbolName: symbolName ?? "sun.max"
                    )
                    
                    Group {
                        /// 별로지만 빨리 끝낼때 효율 안 좋음
                        /// 모델 및 링크 X 처리하여야 됨
                        NavigationLink(destination: SettingView(gradient: $gradient, colorSet: colorSet, select: selection, selection: selectset, path: path)){
                            Label("설정", systemImage: "slider.horizontal.3")
                                
                        }.navigationTitle("E4net")
                            .environmentObject(getCheck)
                            
                           
                        
                        NavigationLink(destination:   CityView(city: .seoul, selection: $selection, gradient: $gradient)){
                            Label("myPage", systemImage: "person")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding()
                
                    
                    //  효율 좋음 정석 방식
                    
                    //                                            NavigationSplitView{
                    //                                                List(selection: $selection){
                    //                                                    NavigationLink(value: Panel.settings) {
                    //                                                        Label("Settings", systemImage: "slider.horizontal.3")
                    //                                                    }
                    //                                                    //                        Text("Cloud cover percentage is currently \(String(format: "%.0f", (cloudCover ?? 0) * 100))% in \(city.name)")
                    //                                                    //
                    //                                                    NavigationLink(value: Panel.myPage) {
                    //                                                        Label("EKMP 마이페이지 넣을 예쩡", systemImage: "clock")
                    //                                                    }
                    //
                    //                                                }
                    //                                            }detail: {
                    //                                                NavigationStack(path: $path) {
                    //                                                    DetailColumn(selection: $selection)
                    //                                                }
                    //                                            }  .onChange(of: selection) { _ in
                    //                                                path.removeLast(path.count)
                    //                                            }.onOpenURL { url in
                    //                                                let urlLogger = Logger(subsystem: "com.example.apple-samplecode.Food-Truck", category: "url")
                    //                                                urlLogger.log("Received URL: \(url, privacy: .public)")
                    //                                                let order = "Order#\(url.lastPathComponent)"
                    //                                                var newPath = NavigationPath()
                    //                                                selection = Panel.myPage
                    //                                                Task {
                    //                                                    newPath.append(Panel.settings)
                    //                                                    newPath.append(order)
                    //                                                    path = newPath
                    //                                                }
                    
                    
                
                    //                   커스텀 네비게이션 레이아웃 나누는버젼
                    //                    WidthThresholdReader(widthThreshold: 320){ proxy in
                    //                        ScrollView(.vertical){
                    //
                    //                            NavigationStack(path: $path){
                    //                                    Text("왜??")
                    //                                    NavigationLink(value: Panel.settings) {
                    //                                        Label("Settings", systemImage: "slider.horizontal.3")
                    //                                    }
                    //                                    NavigationLink(value: Panel.myPage) {
                    //                                        Label("EKMP 마이페이지 넣을 예쩡", systemImage: "clock")
                    //                                    }
                    //                            } .navigationDestination(for: Panel.self) { path in
                    //                                switch path {
                    //                                case .settings:
                    //                                    CityView(city: .seoul, selection: $selection)
                    //                                case .myPage:
                    //                                    CityView(city: .seoul, selection: $selection)
                    //                                default:
                    //                                    CityView(city: .seoul, selection: $selection)
                    //                                }
                    //
                    //                            }
                    //                        }.background(Color(.red))
                    //                    }
                    //                }
                    //                        .navigationSplitViewColumnWidth(min: 200, ideal: 200)
                    //
                    
                    
                    //                        .navigationSplitViewStyle()
                    
                    
                    
                    VStack {
                        AsyncImage(url: attributionLogo) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                                .controlSize(.mini)
                        }
                        .frame(width: 20, height: 20)
                        
                        Link("Other data sources", destination: attributionLink ?? URL(string: "https://weather-data.apple.com/legal-attribution.html")!)
                    }
                    .font(.footnote)
                }
                .padding(.bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background()
            .navigationTitle(city.name)
            .onChange(of: city) { newValue in
                spot = newValue.parkingSpots[0]
            }
            .onAppear {
                spot = city.parkingSpots[0]
            }
            .task(id: city.id) {
                // 애플아이디 등록 안되어있음
                for parkingSpot in city.parkingSpots {
                    do {
                        let weather = try await WeatherService.shared.weather(for: parkingSpot.location)
                        condition = weather.currentWeather.condition
                        willRainSoon = weather.minuteForecast?.contains(where: { $0.precipitationChance >= 0.3 })
                        cloudCover = weather.currentWeather.cloudCover
                        temperature = weather.currentWeather.temperature
                        symbolName = weather.currentWeather.symbolName
                        
                        let attribution = try await WeatherService.shared.attribution
                        attributionLink = attribution.legalPageURL
                        attributionLogo = colorScheme == .light ? attribution.combinedMarkLightURL : attribution.combinedMarkDarkURL
                        
                        if willRainSoon == false {
                            spot = parkingSpot
                            break
                        }
                    } catch {
                        print("Could not gather weather information...", error.localizedDescription)
                        condition = .clear
                        willRainSoon = false
                        cloudCover = 0.15
                    }
                }
            }
        }
    }
    
    struct Sidebar_Previews: PreviewProvider {
        struct Preview: View {
            
            @State private var selection: Panel? = Panel.myPage
            var body: some View {
                CityView(city: .seoul, selection: $selection, gradient: .constant(ColorsModel(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple])))
            }
        }
        
        static var previews: some View {
            NavigationSplitView {
                Preview()
            } detail: {
                Text("Detail!")
            }
        }
    }
 

