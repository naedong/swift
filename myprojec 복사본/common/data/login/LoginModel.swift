//
//  LoginModel.swift
//  myprojec
//
//  Created by E4 on 2022/12/27.
//

import Foundation
import Alamofire


struct LoginModel : Encodable, Identifiable{
     var id = UUID()
     var membId: String
     var membPwd : String
     var connectIp : String
     private enum CodingKeys : String, CodingKey{
         case  membId, membPwd, connectIp
     }
}





