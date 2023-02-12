//
//  DetailColum.swift
//  myprojec
//
//  Created by E4 on 2023/01/10.
//

import SwiftUI

struct DetailColumn: View {
    @EnvironmentObject var getCheck : MySelectColor
    @Binding var gradient : ColorsModel
    @Binding var colorSet : ColorSet
    @Binding var select : Panel?
    @Binding var selection : ChoiceSetting?
    @Environment(\.presentationMode) var presentationMode
    //    @State var timeframe: Timeframe = .today
    // 정석 방법
    var body: some View {
        switch selection ?? .mySetting {
        case .mySetting:
            SettingEditorView()
                .environmentObject(getCheck)
        case .background:
            BackGroundEditorView(colorModel: $gradient, panel: $select, colorSet: $colorSet)
                .environmentObject(getCheck)
        case .effect:
            EffectEditorView(gradients: $colorSet, colorModels: $gradient, selection: $select)
                .environmentObject(getCheck)
        case .back:
            CityView(city: .seoul, selection: $select, gradient: $gradient)
        case .main:
            ContentView(gradient: $gradient)
                .navigationBarBackButtonHidden(true)
                
        }
    }
    
    struct DetailColumn_Previews: PreviewProvider {
        struct Preview: View {
            @State private var colorSet : ColorSet = ColorSet()
            @State private var selection: ChoiceSetting? = .mySetting
            @State private var select : Panel? = .settings
            
            var body: some View {
                DetailColumn(gradient: .constant(ColorsModel(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple])), colorSet: $colorSet,select: $select, selection: $selection)
            }
        }
        static var previews: some View {
            Preview()
        }
    }
}
