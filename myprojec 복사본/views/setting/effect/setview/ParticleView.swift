//
//  Particle.swift
//  myprojec
//
//  Created by E4 on 2023/01/11.
//

import SwiftUI

struct ParticleView: View {
    var gradients: [Gradient]
    @StateObject private var model = ParticleModel()
    @State var choice : Bool = false
    @Binding var grad : ColorsModel
    @Binding var colorSet : ColorSet
    @State  var path = NavigationPath()
    @State  var selectset : ChoiceSetting? = ChoiceSetting.mySetting
    @Binding var selection : Panel?
    var body: some View {
      
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let now = timeline.date.timeIntervalSinceReferenceDate
                model.update(time: now, size: size)
                NavigationLink(destination: SettingView(gradient: $grad, colorSet: colorSet, select: selection, selection: selectset, path: path)){
                    Image(systemName: "checkmark")
                        
                }.padding(.top, 65.0).padding(.leading, 300.0)
                
               
                    
                context.blendMode = .screen
                model.forEachParticle { particle in
                    var innerContext = context
                    innerContext.opacity = particle.opacity
                    innerContext.fill(
                        Ellipse().path(in: particle.frame),
                        with: particle.shading(gradients))
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded { model.add(position: $0.location) }
        )
        .accessibilityLabel("A particle visualizer")
    }
}

