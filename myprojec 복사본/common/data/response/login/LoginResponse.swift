//
//  LoginResponse.swift
//  myprojec
//
//  Created by E4 on 2022/12/27.
//

import Foundation

struct getLogin : Decodable  {
    var TbMembSign: [LoginResponse]
    var hasMorePages: Bool
}
