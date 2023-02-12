
//
//  URLInfo.swift
//  myprojec
//
//  Created by E4 on 2022/12/21.
//

import Foundation

class URLInfo {
    static var baseUrl : String = "https://localtunnelme.loca.lt"
//    static var reactUrl : String = "https://110f-221-148-126-58.jp.ngrok.io/"
    static var reactUrl : String = "https://abc0-218-237-62-232.jp.ngrok.io/"
    
    static func getItemListUrl(currentPage: Int) -> String {
        return "https://s3.eu-west-2.amazonaws.com/com.donnywals.misc/feed-\(currentPage).json"
    }
    
    static func getLogin(TbMembLogin : LoginModel) -> String {
        return "\(baseUrl)/login/login"
    }
    
    static func getIdCheck(membId : String) -> String {
        return "\(baseUrl)/login/checkid/\(membId)"
    }
    
    static func getSendSms() -> String {
        return "\(baseUrl)/login/sendone"
    }
    
    static func getSendVerification() -> String {
        return "\(baseUrl)/login/sendtwo"
    }
    
    
    static func getSignUp() -> String {
        return "\(baseUrl)/login/sendtwo"
    }
    
    static func getSign() -> String {
        return "\(baseUrl)/login/signs"
    }
    
//    static func getWeather() -> String {
//        return "\(baseUrl)/login/signs"
//    }
//    static func getUserSetting() -> String {
//        return "\(baseUrl)/user/setting"
//    }
//
//
}
