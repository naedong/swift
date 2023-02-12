//
//  DetailSettingView.swift
//  myprojec
//
//  Created by E4 on 2023/01/10.
//

import SwiftUI
import os




struct DetailSettingView : View {
    
  
    var body : some View {
        #if os(iOS)
 
        
        #else
        
        #endif
    }
}
struct DetailSettingView_Previews: PreviewProvider {
    struct Preview: View {
        @State private var selection: ChoiceSetting? = .mySetting
        @State private var select : Panel? = .settings
        
        var body: some View {
            DetailSettingView()
        }
    }
    static var previews: some View {
        Preview()
    }
}
