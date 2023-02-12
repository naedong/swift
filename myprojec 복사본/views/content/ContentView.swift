//
//  ContentView.swift
//  myprojec
//
//  Created by E4 on 2022/12/20.
//

import SwiftUI
import FirebaseCore


//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}
@available(iOS 13.0, *)

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
   //Other code
} 


@available(iOS 13.0, *)
func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

}

@available(iOS 13.0, *)
struct ContentView: View {
    @Binding var gradient: ColorsModel
    @StateObject var navModel = NavModel()
    @StateObject var signUpModel = SignUpModel()
    @StateObject var webModel = WebViewModel()
//
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
    var body: some View {
        
        
        
        ZStack{
          
            GeometryReader{
                geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                
                NavView(gradient: $gradient, signUpModel: signUpModel, navModel: navModel, webModel: webModel)
                    .frame(width: width, height: height)
                    
                
            }
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(gradient: .constant(ColorsModel(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple])))
        }
        
    }
    
}
