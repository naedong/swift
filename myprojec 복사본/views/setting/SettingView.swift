//
//  SettingView.swift
//  myprojec
//
//  Created by E4 on 2023/01/10.
//

import SwiftUI



struct SettingView: View {
    @Binding var gradient : ColorsModel
    @State  var colorSet : ColorSet
    @State  var select : Panel? = Panel.myPage
    @State  var selection : ChoiceSetting? = ChoiceSetting.mySetting
    @State  var path = NavigationPath()
    var body: some View {
        #if os(iOS)
       
        setSetting
        #else
        
        #endif
    }
    var setSetting : some View {
      
        NavigationSplitView{
            Sidebar(selection: $selection)
        } detail : {
            NavigationStack(path : $path){
                DetailColumn(gradient: $gradient, colorSet: $colorSet, select: $select, selection: $selection)
            }
        }
        .onChange(of: selection) {
            _ in path.removeLast(path.count)
        }

        
        
        .navigationBarBackButtonHidden(true)
     
        
        
    }
}
