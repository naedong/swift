//
//  LoginDTO.swift
//  myprojec
//
//  Created by E4 on 2022/12/27.
//

import Foundation



struct TestLogin: Decodable, Identifiable {
    var id : String
    var pwd : String
    var sn : Int
    var ip : String
}

