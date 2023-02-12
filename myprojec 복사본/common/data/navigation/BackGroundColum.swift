//
//  BackGroundColum.swift
//  myprojec
//
//  Created by E4 on 2023/01/11.
//

import SwiftUI

struct BackGroundColum : View {
    var gradients: [Gradient]
    @EnvironmentObject var getCheck : MySelectColor
    @Binding var colorsModel : ColorsModel
    @Binding var colorSet : ColorSet
    @Binding var selection : Panel?
    var body: some View {
        List {
            NavigationLink(destination: ShapeVisualizer(gradients: gradients).ignoresSafeArea()) {
                Label("Shapes", systemImage: "star.fill")
            }
            .environmentObject(getCheck)
            
            NavigationLink(destination: ParticleView(gradients: gradients, grad: $colorsModel, colorSet: $colorSet, selection: $selection).ignoresSafeArea()) {
                Label("Particles", systemImage: "sparkles")
            }
            .environmentObject(getCheck)
        }
        .navigationTitle("Visualizers")
    }
}
