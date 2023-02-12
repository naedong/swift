//
//  ColorModel.swift
//  myprojec
//
//  Created by E4 on 2023/01/11.
//

import SwiftUI

struct ColorSelectModel: Identifiable {
    var name: String
    var color: Color
    var id: String {name}
}

