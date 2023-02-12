//
//  NetError.swift
//  myprojec
//
//  Created by E4 on 2022/12/27.
//

import Foundation
import Alamofire

struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
