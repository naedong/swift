//
//  PublicData.swift
//  myprojec
//
//  Created by E4 on 2022/12/27.
//

import Foundation


struct publicData : Decodable, Identifiable {
    var id = UUID()
    var detailAddr : String?
    var emailAddr : String?
    var zipCd : String?
    var zipAddr : String?
    
    private enum CodingKeys : String, CodingKey{
         case  detailAddr, emailAddr, zipCd,zipAddr
     }
    
    
}

struct publicDataEncodable : Encodable, Identifiable {
    var id = UUID()
    var detailAddr : String?
    var emailAddr : String?
    var zipCd : String?
    var zipAddr : String?
    private enum CodingKeys : String, CodingKey{
         case  detailAddr, emailAddr, zipCd,zipAddr
     }
    
}

