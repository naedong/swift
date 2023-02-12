//
//  MapView.swift
//  myprojec
//
//  Created by E4 on 2023/01/09.
//

import SwiftUI
import MapKit

#if os(iOS)
private typealias ViewControllerRepresentable = UIViewControllerRepresentable
#elseif os(macOS)
private typealias ViewControllerRepresentable = NSViewControllerRepresentable
#endif

struct MapView: ViewControllerRepresentable {
    #if os(iOS)
    
    typealias ViewController = UIViewController
    #elseif os(macOS)
    typealias ViewController = NSViewController
    #endif
 
    var location: CLLocation
    var distance: Double = 1000
    var pitch: Double = 0
    var heading: Double = 0
    var topSafeAreaInset: Double
    
    class Controller: ViewController {
        var mapView: MKMapView {
            guard let tempView = view as? MKMapView else {
                fatalError("View could not be cast as MapView.")
            }
            return tempView
        }
        
        override func loadView() {
            let mapView = MKMapView()
            view = mapView
            #if os(iOS)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            #elseif os(macOS)
            view.autoresizingMask = [.width, .height]
            #endif
    //        let configuration = MKImageryMapConfiguration(elevationStyle: .realistic)
                        let configuration = MKHybridMapConfiguration(elevationStyle: .realistic)
    //      let configuration = MKStandardMapConfiguration(elevationStyle: .realistic, emphasisStyle: .default)
            configuration.pointOfInterestFilter = .excludingAll
            configuration.showsTraffic = false
//
            mapView.preferredConfiguration = configuration
            mapView.isZoomEnabled = false
            mapView.isPitchEnabled = false
            mapView.isScrollEnabled = false
            mapView.isRotateEnabled = false
            mapView.showsCompass = false
            
        }
    }
        
    #if os(iOS)
    func makeUIViewController(context: Context) -> Controller {
        Controller()
    }
    
    func updateUIViewController(_ controller: Controller, context: Context) {
        update(controller: controller)
    }
    #elseif os(macOS)
    func makeNSViewController(context: Context) -> Controller {
        Controller()
    }
    
    func updateNSViewController(_ controller: Controller, context: Context) {
        update(controller: controller)
    }
    #endif
    
    func update(controller: Controller) {
        #if os(iOS)
        controller.additionalSafeAreaInsets.top = topSafeAreaInset
        #endif
        controller.mapView.camera = MKMapCamera(
            lookingAtCenter: location.coordinate,
            fromDistance: distance,
            pitch: pitch,
            heading: heading
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(location: CLLocation(latitude: 37.566_791, longitude: 126.978_914), topSafeAreaInset: 0)
    }
}
