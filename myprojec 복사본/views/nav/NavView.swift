//
//  NavView.swift
//  myprojec
//
//  Created by E4 on 2022/12/20.
//

import SwiftUI


@MainActor class Data : ObservableObject{
    @Published var id = ""
    @Published var trun = false
}

class MySelectColor : ObservableObject {
    @Published var set : Bool = false
    
}


struct NavView: View {
    @StateObject var selectColor = MySelectColor()
    @StateObject var id = Data()
    @Binding var gradient: ColorsModel
    @ObservedObject var signUpModel : SignUpModel
    @ObservedObject var navModel : NavModel
    @ObservedObject var webModel : WebViewModel
    @State var tag:Int? = 0
    
    
    var body: some View {
      
        NavigationStack{
            VStack{
                MainView(gradient: $gradient, viewModel: webModel, navModel: navModel)
                if id.trun {
                    
                }else {
                    
                    NavigationLink("회원가입 하러가기", destination: SignUpView(signUpModel: signUpModel)
                    )
                        
                    
                }
                
                    
            }
        }.environmentObject(selectColor)
        .environmentObject(id)
        
        
    }
}

func getWiFiAddress() -> String? {
    var address: String?

    // Get list of all interfaces on the local machine:
    var ifaddr: UnsafeMutablePointer<ifaddrs>?
    guard getifaddrs(&ifaddr) == 0 else { return nil }
    guard let firstAddr = ifaddr else { return nil }

    // For each interface ...
    for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
        let interface = ifptr.pointee

        // Check for IPv4 or IPv6 interface:
        let addrFamily = interface.ifa_addr.pointee.sa_family
        if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

            // Check interface name:
            let name = String(cString: interface.ifa_name)
            if name == "en0" {

                // Convert interface address to a human readable string:
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                            &hostname, socklen_t(hostname.count),
                            nil, socklen_t(0), NI_NUMERICHOST)
                address = String(cString: hostname)
            }
        }
    }
    freeifaddrs(ifaddr)

    return address
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView(gradient: .constant(ColorsModel(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple])), signUpModel: SignUpModel()
                ,navModel: NavModel(), webModel: WebViewModel())
                
    }
}
