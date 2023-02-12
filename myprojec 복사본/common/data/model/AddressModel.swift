//
//  AddressModel.swift
//  myprojec
//
//  Created by E4 on 2023/01/02.
//

import Foundation
import Combine

class AddressModel : ObservableObject {
    @Published var roadAddress  : String = ""
    @Published var jibunAddress : String = ""
    @Published var zonecode     : String = ""
 
}
