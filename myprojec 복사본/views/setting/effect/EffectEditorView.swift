//
//  EffectEditorView.swift
//  myprojec
//
//  Created by E4 on 2023/01/10.
//

import SwiftUI

struct EffectEditorView: View {
    @Binding var gradients : ColorSet
    @Binding var colorModels : ColorsModel

    @Binding var selection : Panel?
    var body: some View {
        Text("Hello, EffectEditor!")
        Text("이펙트 효과를  사용자 지정할 수 있는 페이지이 값들을 서버에 사용자별로 저장을 해야함")
        BackGroundColum(gradients: gradients.gradients.map(\.gradient), colorsModel: $colorModels, colorSet: $gradients, selection: $selection)
            .toolbar {
#if os(iOS)
                #endif
            }
        
    }
}


