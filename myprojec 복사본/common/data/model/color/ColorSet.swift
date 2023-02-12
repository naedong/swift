//
//  ColorSet.swift
//  myprojec
//
//  Created by E4 on 2023/01/10.
//


import SwiftUI

struct ColorSet {
    var gradients : [ColorsModel] = []

    static let defaultStore: Self = {
        var data = Self()
        data.append(colors: [.gray, .white], name: "Grayscale")
        data.append(colors: [.teal, .blue], name: "Blue")
        data.append(colors: [.orange, .red], name: "Orange")
        data.append(colors: [.green, .mint], name: "Green")
        data.append(colors: [.purple, .indigo], name: "Purple")
        data.append(colors: [.pink, .red], name: "Pink")
        data.append(colors: [.black, .brown], name: "Dark")
        return data
    }()

    @discardableResult
    mutating func append(colors: [Color], name: String = "") -> ColorsModel {
        var id = 0
        for gradient in gradients {
            id = max(id, gradient.id)
        }
        let gradient = ColorsModel(colors: colors, name: name, id: id + 1)
        gradients.append(gradient)
        return gradient
    }
}
