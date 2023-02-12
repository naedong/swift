//
//  LoginViewModel.swift
//  myprojec
//
//  Created by E4 on 2022/12/29.
//

import Foundation
import Combine
import Alamofire

class LoginViewModel : ObservableObject {
    
    var subscription = Set<AnyCancellable>()
    
    @Published var login = [Logins]()
    
    
}
