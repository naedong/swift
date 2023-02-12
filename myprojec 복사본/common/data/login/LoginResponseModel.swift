//
//  LoginResponseModel.swift
//  myprojec
//
//  Created by E4 on 2022/12/28.
//

import Foundation



struct LoginResponse : Decodable{

    var membSn : Int
    var membCls : String
    var membStatusCd : Int
    var membId : String
    var membPwd : String
    var mobileNo : String
    var membNm : String
    var publicData : publicData?
    var lastLoginDtm : String
    private enum Codingkey : String, CodingKey {
        case publicData
        case membSn, membCls, membId, membPwd, mobileNo, membNm, lastLoginDtm
        case membStatusCd
    }
}


