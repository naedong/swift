//
//  MainView.swift
//  myprojec
//
//  Created by E4 on 2022/12/20.
//

import SwiftUI
import SPAlert
import os

    
    /**
     Returns device ip address. Nil if connected via celluar.
     */
    func printAddresses() -> String{
        var addrs : String = ""
        var addrList : UnsafeMutablePointer<ifaddrs>?
        guard
            getifaddrs(&addrList) == 0,
            let firstAddr = addrList
        else { return ""}
        defer { freeifaddrs(addrList) }
        for cursor in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interfaceName = String(cString: cursor.pointee.ifa_name)
            let addrStr: String
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            if
                let addr = cursor.pointee.ifa_addr,
                getnameinfo(addr, socklen_t(addr.pointee.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0,
                hostname[0] != 0
            {
                addrStr = String(cString: hostname)
                if addrStr.contains("192."){
                    addrs = addrStr
                }
            } else {
                addrStr = "?"
            }
            print(interfaceName, addrStr)
        }
        return addrs
    }

struct MainView: View {
    @EnvironmentObject var getId : Data
    @EnvironmentObject var getCheck : MySelectColor
    
    @Binding var gradient: ColorsModel
    @State private var selection : Panel? = Panel.myPage
    @State private var path = NavigationPath()
    
#if os(iOS)
    //    @Environment(\.displayStoreKitMessage) private var displayStoreMessage
    @Environment(\.scenePhase) private var scenePhase
#endif
    
    
    @State var colorSet : ColorSet? = ColorSet()
    @State var anotherView = false
    @State var keyboardOn = false
    @State var isOn = false
    @ObservedObject var viewModel : WebViewModel
    
    @State var webTitle : String = ""
    @State var showAlert : Bool = false
    //    @ObservedObject var viewModel = TestWebViewModel()
    @State var password = ""
    @State var viewCheck = false
    @ObservedObject var navModel : NavModel
    
    // showAlert가 true면 알림창이 뜬다 // If showAlert is true, a notification window pops up
    
    
    // alert에 표시할 내용 // This is the content to be displayed in the alert.
    @State var alertMessage: String = "error"
    // 웹뷰 확인/취소 작업을 처리하기 위한 핸드러를 받아오는 변수 // Variable that gets the handler to handle the web view confirmation/cancel operation
    @State var confirmHandler: (Bool) -> Void = {_ in }
    
    var body: some View {
        
        VStack {
         
            if anotherView {
                NavigationStack {
                    //                    ReactView(webView: WKWebView(), request: URLRequest(url: URL(string: URLInfo.reactUrl+"/charge")!), showAlert: $showAlert, alertMessage: $alertMessage, confirmHandler: $confirmHandler)
                    //                        .alert(isPresented: self.$showAlert) { () -> Alert in
                    //                            var alert = Alert(title: Text(alertMessage))
                    //                            if(self.showAlert == true) {
                    //                                alert = Alert(title: Text("알림"), message: Text(alertMessage), primaryButton: .default(Text("OK"), action: {
                    //                                    confirmHandler(true)
                    //                                }), secondaryButton: .cancel({
                    //                                    confirmHandler(false)
                    //                                }))
                    //                            }
                    //                            return alert;
                    //                        }
                    //                }
                    //                    WebView(webView: WKWebView(),url: URLInfo.reactUrl+"/charge", viewModel: WebViewModel())
                    //                                                        }.navigationBarBackButtonHidden(false)
                    //
                    //                    SwiftUIWebView(url: URL(string: URLInfo.reactUrl+"/charge"),
                    //                                   viewModel: viewModel)
                    //                    .navigationTitle(Text(webTitle))
                    //                    .alert(isPresented: $showAlert) {
                    //                        Alert(title: Text("Hello"), message: Text("Alert from React"), dismissButton: .default(Text("OK"), action: {
                    //                            self.showAlert = false
                    //                            self.viewModel.callbackValueFromNative.send(UUID().uuidString)vs
                    //                        }))
                    //                    }
                    //                    .onReceive(self.viewModel.webTitle, perform: { receivedTitle in
                    //                        self.webTitle = receivedTitle
                    //                    })
                    //                    .onReceive(self.viewModel.showAlert, perform: {result in
                    //                        self.showAlert = result
                    //                    })
                    //                }
                    
                    
                    //
                    //                    MyWebView(viewModel: viewModel, urlToLoad: URLInfo.reactUrl+"charge")
                
                    //
                    WebView(url: URLInfo.reactUrl+"charge", viewModel: viewModel)
                    
                }
                //                .onAppear(){
                //                    self.viewModel.send.send(getId.id)
                //                }
                
                //                .onAppear(){
                //                    self.viewModel.foos.send(foos)
                //                }
                //                .onReceive(self.viewModel.bars.receive(on: RunLoop.main)){ value in
                //
                //                    self.foos = "qwerqwer@naver.com"
                //
                //                }
                
            }
            else{
                //                NavigationView{
                //                    CityView(city: .seoul, selection: $selection)
                //
                //                }
                ////            detail: {
                ////                    NavigationStack(path: $path ){
                ////                        DetailColumn(selection: $selection)
                ////                    }
                ////                }
                ////                .onChange(of: selection){
                ////                    _ in
                ////                    path.removeLast(path.count)
                ////                }
                //                #if os(macOS)
                //                .frame(minWidth: 600, minHeight: 450)
                //                #elseif os(iOS)
                //                .onChange(of: scenePhase) {
                //                    newValue in
                //                    if newValue == .active {
                //
                //                    }
                //                }
                //                #endif
                //                }
                //
                
                NavigationLink(destination: CityView(city: .seoul, selection: $selection, gradient: $gradient)){
                    VStack{
                        Image(systemName: "slider.horizontal.3")
                        Text("설정")
                       
                    }
                    .background(in: Circle().inset(by: -20))
                    .backgroundStyle(.blue.gradient)
                    .foregroundStyle(.white)
                    .shadow(color: .blue, radius: 5, x: 3, y: 3)
                    .shadow(color: .white, radius: 5, x: -3, y: -3)
                    
                    .padding(10)
                 
                }.environmentObject(getCheck)
           
                .padding(.bottom, 100.0)
                    .padding(.leading, 250)
                    
                
                
                FloatingAvatar(keyboardOn: $keyboardOn, isOn: $isOn)
//                    .padding(.top, 300.0)
                   
                    .onTapGesture {
                        withAnimation{
                            keyboardOn = false
                            hidekeyboard()
                        }
                        
                    }
                Spacer()
                LoginStruct(id: $getId.id, password: $password)
//                    .padding(.top, 100.0)
                
                    .onTapGesture {
                        withAnimation{
                            keyboardOn = true
                        }
                    }
                
                LoginButtonView(gradient: $gradient, viewModel: viewModel,anotherView: $anotherView, login: LoginModel(membId: getId.id, membPwd: password, connectIp: printAddresses()), gets : $getId.trun)
                 
//                    .padding(.bottom, 250.0)
                    
                 
                Spacer()
                SignUp()
                    
            }
            
        }.background{
            
            LinearGradient(gradient: gradient.gradient, startPoint: .leading, endPoint: .trailing)
                          .ignoresSafeArea(.all)

        }
        /// 기본 백 그라운드 컬러
        /// 
        //.background(Color(.red))
        
//            if (UserDefaults.standard.string(forKey: "back") != nil){
//
//                LinearGradient(gradient: gradient.gradient, startPoint: .leading, endPoint: .trailing)
//                    .ignoresSafeArea(.all)
//
//
//            }
        
        
        
    }
    func hidekeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to : nil,
                                        from: nil, for: nil)
    }
    
    
    
    
    
    struct LoginStruct: View {
        @Binding var id : String
        @Binding var password : String
        @State var showPassword = false
        
        
        
        
        var body: some View {
            VStack(spacing: 5){
                HStack {
                    Image(systemName: "person")
                    TextField("I D", text: $id)
                        .keyboardType(.emailAddress)
                        .padding(10)
                        .autocapitalization(.none)
                    Image(systemName: id.isEmpty ? "" : "checkmark")
                        .foregroundColor(Color("green"))
                }
                Divider()
                HStack{
                    Image(systemName: "lock")
                    Group{
                        if showPassword {
                            TextField("Password",
                                      text: $password,
                                      prompt: Text("Password")
                            )
                        }
                        else{
                            SecureField("Password",
                                        text: $password,
                                        prompt : Text("Password"))
                        }
                    }     .padding(10)
                        .autocapitalization(.none)
                    Button { // add this new button
                        showPassword.toggle()
                    } label: {
                        Image(systemName: password.isEmpty || id.isEmpty ? "" : "checkmark")
                            .foregroundColor(Color("green"))
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                }
            }.padding(10)
            Divider()
        }
        
    }
    
    
    
    
    struct FloatingAvatar : View {
        
        @Binding var keyboardOn : Bool
        @Binding var isOn : Bool
        
        var body : some View {
            ZStack{
                AvatarView(pic: "image1", fontSize: 50, backSize: 25, xOffset: isOn ? 0 : 30, yOffset: isOn ? 0 : 30
                )
                .offset(x: keyboardOn ? 0 : -120, y:
                            keyboardOn ? 0 : -90.0)
                
                AvatarView(pic: "image2", fontSize: 60, backSize: 30, xOffset: isOn ? 0 : 30, yOffset: isOn ? 0 : 30
                )
                .offset(x: keyboardOn ? 0 : -110, y:
                            keyboardOn ? 0 : 80.0)
                AvatarView(pic: "image3", fontSize: 60, backSize: 25, xOffset: isOn ? 0 : -30, yOffset: isOn ? 0 : -30
                )
                .offset(x: keyboardOn ? 0 : 120, y:
                            keyboardOn ? 0 : 80.0)
                AvatarView(pic: "e4net", fontSize: 100, backSize: 60, xOffset: isOn ? 0 : 50, yOffset: isOn ? 0 : -40
                )
                .offset(x: 0, y:0)
            }
        }
    }
    
    
    struct AvatarView: View {
        
        var pic : String
        var fontSize : CGFloat;
        var backSize : CGFloat;
        var xOffset : CGFloat;
        var yOffset : CGFloat;
        @State private var offset: CGFloat = 200.0
        @State private var shimmer : Bool = .random();
        
        var body: some View {
            ZStack{
                Image(pic)
                    .resizable()
                    .scaledToFill().blendMode(.overlay)
                    .frame(width: backSize, height: backSize)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .saturation(Double(1.5))
                    .blur(radius: 1.5 - 2)
                    .offset(x: xOffset, y: yOffset)
                    .animation(Animation.linear(duration: 2.0)
                        .repeatForever(autoreverses: true), value: 100)
                    .shadow(color: Color("green"), radius: 3, x: -2, y: -2)
                    .shadow(color: Color("yellow"), radius: 3, x: 2, y: 2)
                
                Image(pic)
                    .resizable()
                    .scaledToFill()
                    .frame(width: fontSize, height: fontSize)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .scaleEffect(shimmer ? 1.1 : 1)
                    .animation(Animation.linear(duration: 3).repeatForever(autoreverses: true), value: 100)
                    .shadow(color: Color("yellow"), radius: 7, x: -2, y: -2)
                    .shadow(color: Color("pink"), radius: 7, x: 2, y: 2)
                    .onAppear{withAnimation{self.shimmer.toggle()}}
            }
        }
    }
    
    // 옵셔널 체크할것
    
    struct LoginButtonView : View {
        /// 쓸모 없음  테스트용
        @EnvironmentObject var getCheck : MySelectColor
        @Binding var gradient: ColorsModel
        let logger = Logger(subsystem: "net.e4net.myprojec.views.web.LoginButtonView", category: "View")
        @ObservedObject var viewModel : WebViewModel
        @Binding var anotherView : Bool
        var login : LoginModel
        @Binding var gets : Bool
        var body : some View {
            
            
            Button(action: {
                HttpClient<LoginResponse>().alamofireNetworkingLogin(url: URLInfo.getLogin(TbMembLogin: login),
                                                                     onSuccess: { (resData) in
                    logger.info("아이디 비번 값 확인 \(resData.membId), \(resData.membPwd)")
                    
                    anotherView = true
                    if getCheck.set {
                        UserDefaults.standard.set(login.membId, forKey: "id")
                    }
                    
                },  onFailure: {
                    logger.info("아이디 비번 값 없음")
                    
                    let alertView = SPAlertView(title: "로그인 실패", preset: .error)
                    alertView.duration = 1.5
                    alertView.dismissInTime = true
                    alertView.present()
                    
                }, param: login
                                                                     
                )
                
            }){
                Text("Login Btn")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .frame(width: 200, height: 50)
                    .background(Color("green"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(10)
            }.padding(.bottom, 10)
            // 여백 백 그라운드 컬러
//            if getCheck.set {
//                LinearGradient(gradient: gradient.gradient, startPoint: .leading, endPoint: .trailing)
//                    .ignoresSafeArea(edges: .bottom)
//            }
            
        }
        
        
    }
    
    struct FaceID: View {
        var body : some View {
            VStack(spacing : 10){
                Button(action: {}){
                    Image(systemName: "faceid")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.secondary)
                }
                Text("Face ID")
                Text("Login use Face Id")
                    .foregroundColor(.secondary)
            }
        }
    }
    
    struct SignUp : View {
        var body : some View {
            HStack(spacing: 20){
                Text("아이디가 없다면")
                    .foregroundColor(.secondary)
            }
        }
    }
    
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView(gradient: .constant(ColorsModel(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple])), viewModel: WebViewModel(), navModel: NavModel())
                .environmentObject(Data())
        }
    }
}
