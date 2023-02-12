//
//  PhoneDto.swift
//  myprojec
//
//  Created by E4 on 2023/01/02.
//

import Foundation


struct PhoneModel : Encodable, Identifiable{
    var id = UUID()
    var phone : String
     var certificationNumber : String
     
     private enum CodingKeys : String, CodingKey{
         case phone, certificationNumber
     }
}

