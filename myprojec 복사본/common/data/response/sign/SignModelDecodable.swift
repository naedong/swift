//
//  SignModelDecodable.swift
//  myprojec
//
//  Created by E4 on 2023/01/04.
//

import Foundation
struct SignCheck : Decodable, Identifiable  {
    var id = UUID()
    var check : String?

    private enum CodingKeys : String, CodingKey{
        case check
    }
}



