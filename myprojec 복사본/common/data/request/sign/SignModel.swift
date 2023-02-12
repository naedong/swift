//
//  SignModel.swift
//  myprojec
//
//  Created by E4 on 2023/01/04.
//

import Foundation

struct SignModel : Encodable, Identifiable{
     var id = UUID()
  
    var membCls : String
    var membStatusCd : String
    
    var membId: String
    var membPwd : String
    var mobileNo : String
    var membNm : String
    var publicData : publicDataEncodable
 
    
    private enum CodingKeys : String, CodingKey{
         case  membCls, membStatusCd, membId,membPwd, mobileNo, membNm, publicData
     }
}


