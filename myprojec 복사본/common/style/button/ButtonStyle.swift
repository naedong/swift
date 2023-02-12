//
//  ButtonStyle.swift
//  myprojec
//
//  Created by E4 on 2022/12/21.
//

import SwiftUI


struct SignUpButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
           .background(Capsule().fill(Color("PrimaryColor")))
           .scaleEffect(configuration.isPressed ? 0.88 : 1.0) // <-
    }
    
}
