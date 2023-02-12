//
//  CheckId.swift
//  myprojec
//
//  Created by E4 on 2022/12/27.
//

import Foundation


struct checkId : Decodable  {
    var items: [SignUpModel.ChecksId]
    var hasMorePages: Bool
}
