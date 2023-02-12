//
//  SignUp.swift
//  myprojec
//
//  Created by E4 on 2022/12/20.
//

import SwiftUI
import SPAlert
import os

struct SignUpView: View {
    let logger = Logger(subsystem: "net.e4net.myprojec.views.web.SignUpView", category: "View")
    @EnvironmentObject var id : Data
    @ObservedObject var signUpModel = SignUpModel()
    @State var password = ""
    @State var email = ""
    @State var confirmPassword = ""
    @State var address = ""
    @State var zipCd = ""
    @State var detailAddress = ""
    @State var centerPhone = ""
    @State var endPhone = ""
    @State var nowPhone = ""
    @State var confirmPhone = ""
    @State var name = ""
    // @stateObject 사용할려다가 Environment 실험
    
    
    var body: some View {
        HStack{
            
            SignUpF(id: $id.id,
                    password: $password,
                    confirmPassword: $confirmPassword,
                    email: $email,
                    address: $address,
                    zipCd: $zipCd,
                    detailAddress: $detailAddress,
                    centerPhone: $centerPhone,
            
                    endPhone: $endPhone,
                    nowPhone : $nowPhone,
                    confirmPhone: $confirmPhone,
                    name: $name
            )
        }
    }
}

struct patt{
    let logger = Logger(subsystem: "net.e4net.myprojec.views.web.SignUpView.patt", category: "Struct")
    var check : Bool = false
    let pattern = "^[A-Za-z0-9]{8,}$"
    let phone = "^01([0-9])([0-9]{3,4})([0-9]{4})$"
    let phones = "^[0-9]{3,4}$"
    let emailPattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$"
    let idPattern = "^[A-Za-z0-9]{1,}$"
    let zipCd = "^[A-Za-z0-9]{5,}$"
    let koreanAddress = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9_]{1,}$"
    let overseas = "^[A-Za-z0-9]{1,}$"
    
    
    func phoneCheck(_ phones : String) -> Bool {
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phones)
        logger.debug("\(phoneTest)")
        return phoneTest.evaluate(with: phones)
    }
    
    
    @MainActor  func checkPass(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", pattern)
        logger.debug("\(password)")
      
          return passwordTest.evaluate(with: password)
      }
      
    
    @MainActor func idCheck(_ id : String) -> Bool {
        let idTest = NSPredicate(format: "SELF MATCHES%@", idPattern)

        logger.debug("\(id)")
      
        return idTest.evaluate(with: id)
    }
    
    @MainActor func emailCheck(_ email : String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES%@", emailPattern)
   
        logger.debug("\(email)")
        return emailTest.evaluate(with: email)
    }
 
    @MainActor func addressCheck(_ address : String ) ->  Bool{
        let koreanAddressTest = NSPredicate(format: "SELF MATCHES%@", koreanAddress)
      
             logger.debug("\(address)")
        
//        let overseasTest = NSPredicate(format: "SELF MAT CHES%@", overseas)
    
        return koreanAddressTest.evaluate(with: address)
    }
    
    
}

struct SignUpF : View{
    
    let logger = Logger(subsystem: "net.e4net.myprojec.views.web.SignUpView.SignUpF", category: "View")
    @State var showPassword = false
    @State var confirm = false
    @State var selectNumber = ""
    @State var checks : Bool = false
    @State var checkColor : Bool = true
    @State var checkAddress : Bool = false
    @State var countSet : Int = 0
    var checkPass = false
    var numbers = ["010", "011", "017"]
    var phone : PhoneModel = PhoneModel(phone: "", certificationNumber: "")
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var input = TextLimiter(limit: 5)
    @ObservedObject var addressModel = AddressModel()
    @Binding var id : String
    @Binding var password : String
    @Binding var confirmPassword : String
    @Binding var email : String
    @Binding var address : String
    @Binding var zipCd : String
    @Binding var detailAddress : String
    @Binding var centerPhone : String
    @Binding var endPhone : String
    @Binding var nowPhone : String
    @Binding var confirmPhone : String
    @Binding var name : String
   
    
    
    func setSign() {
        
        HttpClient<SignCheck>().alamofireNetworkingSignUp(url: URLInfo.getSign(),
            onSuccess: { (resData) in
 
            if resData.check != "false"{
                let alertView = SPAlertView(title: "가입 성공", preset: .heart)
                alertView.dismissInTime = false
                alertView.dismissByTap = true
                alertView.present()
                presentationMode.wrappedValue.dismiss()
            }
        },
         onFailure: {
            logger.info("resData : ")
       
            let alertView = SPAlertView(title: "연결 실패", preset: .error)
            alertView.duration = 2
            alertView.dismissInTime = true
            alertView.dismissByTap = true
            alertView.present()
        }, param: SignModel(membCls: "사용자", membStatusCd: "10", membId: id, membPwd: password, mobileNo: selectNumber+"-"+centerPhone+"-"+endPhone, membNm: name, publicData: publicDataEncodable(detailAddr: detailAddress, emailAddr: email, zipCd: zipCd, zipAddr: address))
            
        )
       
    }
    
    func setCount(countSet : Int) {
        if countSet == 0 {
            logger.info(" 값 확인 \(selectNumber+centerPhone+endPhone) ")
            logger.info(" 값 확인 \(confirmPhone) ")
      
            
            HttpClient<Phone>().alamofireNetworkingPhone(url: URLInfo.getSendSms(),
                onSuccess: { (resData) in
                
                
                logger.info("resData : \(resData.certificationNumber), \(resData.phone)")
        
                let alertView = SPAlertView(title: resData.certificationNumber, preset: .heart)
                alertView.dismissInTime = false
                alertView.dismissByTap = true
                alertView.present()
                 self.countSet = 1
            },
             onFailure: {
                logger.info("resData : 없 음 연결실패")
                let alertView = SPAlertView(title: "연결 실패", preset: .error)
                alertView.duration = 2
                alertView.dismissInTime = true
                alertView.dismissByTap = true
                alertView.present()
            }, param: PhoneModel(phone: selectNumber+centerPhone+endPhone, certificationNumber: confirmPhone)
                
            )
           
        } else {
            logger.info("값 확인 \(selectNumber+centerPhone+endPhone)")
            logger.info("값 확인\(confirmPhone)")
            
            HttpClient<Phone>().alamofireNetworkingPhoneVertification(url: URLInfo.getSendVerification(),
                onSuccess: { (resData) in
                
                logger.info("resData : \(resData.certificationNumber), \(resData.phone)")
                
                if resData.certificationNumber != confirmPhone {
                    let alertView = SPAlertView(title: "번호 틀림", preset: .error)
                    alertView.dismissInTime = false
                    alertView.dismissByTap = true
                    alertView.present()
                }else{
                    let alertView = SPAlertView(title: "성공", preset: .heart)
                    alertView.dismissInTime = false
                    alertView.dismissByTap = true
                    alertView.present()
                    self.checks = true
                }
               
                 
              
            },
             onFailure: {
                
                logger.info("resData : 값 없음 에러")
                
                let alertView = SPAlertView(title: "연결 실패", preset: .error)
                alertView.duration = 2
                alertView.dismissInTime = true
                alertView.dismissByTap = true
                alertView.present()
            }, param: PhoneModel(phone: selectNumber+centerPhone+endPhone, certificationNumber: confirmPhone)
                
            )
            
        }
    }

    var body: some View{
        ZStack{
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color("PrimaryColor"), Color("SubPrimaryColor")]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            ScrollView (){
            VStack (spacing: 10){
                
                TextField("text",
                          text: $id,
                          prompt: Text("I D")

                                )
                .padding(.top, 10)
                .padding(10)
                .autocapitalization(.none)
                .frame(maxWidth: 280, maxHeight: 500)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            patt().idCheck(id) == true ? .green :
                                    .red, lineWidth: 2)
                        .frame(width: 280, height: 40)
                        .padding(.top, 10)// How to add rounded corner to a TextField and change it colour
                }
                Button{
                    Task{
                        let (datas, _) = try await URLSession.shared.data(from: URL(string:
                                            URLInfo.getIdCheck(membId: id))!)
                        let decodedResponse = try? JSONDecoder().decode(TestId.self, from: datas)
                        checkColor = decodedResponse?.id ?? true
                    
                        logger.info("checkColor :  \(checkColor)")
                    
                        logger.info("컬러값 확인 :  \(datas.hashValue)")
                       
                        
                    
                    }
                } label: {
                    Text("아이디 인증")
                        .foregroundColor(Color.black)
                }
                .padding(10)
                .frame(maxWidth: 280, maxHeight: 500)
                .foregroundColor(Color.blue)
                ZStack{
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
                        
                    }
                    .padding(10)
                    .frame(maxWidth: 280, maxHeight: 500)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke( patt().checkPass(password) == true ? .green : .red, lineWidth: 2) // How to add rounded corner to a TextField and change it colour
                    }
                    Button { // add this new button
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.red)
                    }
                    .padding(.leading, 240.0)
                    
                    
                }
                ZStack(alignment: .centerFirstTextBaseline){
                    
                    Group{
                        if confirm {
                            TextField("Password",
                                      text: $confirmPassword,
                                      prompt: Text("Confirm Password")
                            )
                        }
                        else{
                            SecureField("Password",
                                        text: $confirmPassword,
                                        prompt : Text("Confirm Password"))
                        }
                        
                    }
                    .padding(10)
                    
                    .frame(maxWidth: 280, maxHeight: 500)
                    .autocapitalization(.none)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke( password == confirmPassword && password.utf8.count != 0 ? .green : .red , lineWidth: 2) // How to add rounded corner to a TextField and change it colour
                    }
                    
                    Button { // add this new button
                        confirm.toggle()
                    } label: {
                        Image(systemName: confirm ? "eye.slash" : "eye")
                            .foregroundColor(.red)
                    }
                    .padding(.leading, 240.0)
                  
                }
                ZStack{
                    
         
                    VStack(alignment: .leading, spacing: 50){
              
                        
                        TextField("email",
                                  text: $email,
                                  prompt: Text("Email")
                        ) .padding(10)
                        
                        .frame(maxWidth: 280, maxHeight: 500)
                            .autocapitalization(.none)
                            .overlay{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        patt().emailCheck(email) == true
                                        ? .green :
                                                .red, lineWidth: 2) // How to add rounded corner to a TextField and change it colour
                            }
                      
                        
                        HStack(alignment: .center, spacing: 10){
                            Picker("전화번호 선택", selection: $selectNumber){
                                ForEach(numbers, id: \.self){
                                    Text($0)
                                }
                            }
                            .pickerStyle(.wheel)
                            .background(Color.blue)
                            .foregroundColor(.black)
                            .cornerRadius(15)
                            .frame(width: 70, height: 50)
                        }
                        
                        
                        
                    }
                    Text("-")
                        .padding([.top], 95.0)
                        .padding([.trailing], 130)
                    TextField("text",
                              text: $centerPhone,
                              prompt: Text("number")
                    ).padding(.trailing, 0.0)
                        .keyboardType(.numberPad)
                        .autocapitalization(.none)
                        .frame(width: 80, height: 50, alignment: .leading)
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(patt().phoneCheck(centerPhone) == true
                                        ? .green :
                                                .red, lineWidth: 2) // How to add rounded corner to a TextField and change it colour
                            
                        }.padding(.top, 90.0)
                    
                    .frame(maxWidth: 80, maxHeight: 80)
              
                    Text("-")
                        .padding([.top], 95.0)
                        .padding([.leading], 110)
                    TextField("text",
                              text: $endPhone,
                              prompt: Text("number")
                    ).padding(.trailing, 20.0)
                        
                        .keyboardType(.numberPad)
                        .autocapitalization(.none)
                        .frame(width: 80, height: 50, alignment: .leading)
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                    .stroke(patt().phoneCheck(endPhone) == true ? .green :
                                                          .red, lineWidth: 2) // How to add rounded corner to a TextField and change it colour
                        }.padding(.top, 90.0)
                        .padding(.leading, 215)
                    
                    
                    
                    
                }
                HStack{
                    TextField("text",
                              text: $confirmPhone,
                              prompt: Text("인증 번호")
                    ).padding(.leading, 20)
                        .keyboardType(.numberPad)
                        .autocapitalization(.none)
                        .frame(width: 200, height: 40)
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(checks == true ? .green : .red, lineWidth: 2)
                            // How to add rounded corner to a TextField and change it colour
                                .padding(.leading, 12.0)
                        }
                     
                    
                    
                    
                    Button{
                        setCount(countSet: countSet)
                    } label: {
                        Text("휴대폰 인증")
                            .foregroundColor(Color.black)
                           
                    }
                    
                    .padding(.trailing, 30.0)
                    .foregroundColor(Color.blue)
                }
                HStack(spacing: 10){
                    
                    TextField("text",
                              text:  $addressModel.zonecode,
                              prompt: Text("우편 번호")
                    ).padding(.leading, 35)
                        .autocapitalization(.none)
                    
                        .frame(width: 200, height: 40)
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(addressModel.zonecode.count > 4 ?
                                    .green :
                                    .red, lineWidth: 2)
                                .padding(.leading, 28.0)// How to add rounded corner to a TextField and change it colour
                        }
                    
                    
                    
                    NavigationLink(destination: WebView(url: "https://project2-c3089.web.app/",   addressModel: addressModel)
                           
                    ){
                        Text("주소 찾기")
                            .foregroundColor(Color.black)
                            .frame(width: 80)
                            .padding(.trailing, 60.0)
                            
                    }
                 
                    
               
                    
                }
            
                
                
                
                TextField("text",
                          text: $addressModel.jibunAddress,
                          prompt: Text("Address")
                ).padding(.leading, 40.0)
                    .padding(10)
                    .autocapitalization(.none)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                addressModel.jibunAddress.count > 0 ? .green : .red, lineWidth: 2)
                        
                        .frame(width: 280, height: 40)// How to add rounded corner to a TextField and change it colour
                    }
                TextField("text",
                          text: $detailAddress,
                          prompt: Text("DetailAddress")
                ).padding(.leading, 40.0)
                    .padding(10)
                    .autocapitalization(.none)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                detailAddress.count > 0 ? .green : .red, lineWidth: 2)
                            .frame(width: 280, height: 40)
                            .padding(.leading, 0)// How to add rounded corner to a TextField and change it colour
                    }
          
                TextField("Name",
                          text: $name,
                          prompt: Text("Name")
                ) .padding(10)
                
                .frame(maxWidth: 280, maxHeight: 150)
                    .autocapitalization(.none)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                name.count > 0
                                ? .green :
                                        .red, lineWidth: 2)
                    
                        // How to add rounded corner to a TextField and change it colour
                    }
                
                
            }
                
                Button{
                    setSign()
                } label: {
                    Text("회원 가입")
                        .foregroundColor(Color.black)
                }.backgroundStyle(Color(.white))
            
            
            }// VStack
            .frame(width: 300)
          
        }
        .padding(.horizontal, 10)
        .frame(width: 300)
        .cornerRadius(10)
        .padding()
        .overlay{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black)
                .padding(15)
             
          
        }
            
        // ScrollView
        }
        .frame(width: 400.0)// ZStack
        .background(Color.cyan)
        .frame(minWidth: 340, minHeight: 400,
        maxHeight: 960)
        
     
        }
        
    }// ZStack
    


func setSign(){
    return
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signUpModel: SignUpModel())
            .environmentObject(Data())
    }
}
