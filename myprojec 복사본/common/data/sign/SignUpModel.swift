//
//  SignUpModel.swift
//  myprojec
//
//  Created by E4 on 2022/12/20.
//

import Foundation


class SignUpModel : ObservableObject {

    @Published var check = false
    
    struct ChecksId: Decodable, Identifiable {
        var id : Bool
    }

}


struct TestId: Decodable, Identifiable {
    var id : Bool
}


