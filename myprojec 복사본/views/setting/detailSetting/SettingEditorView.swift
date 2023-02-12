//
//  SettingEditorView.swift
//  myprojec
//
//  Created by E4 on 2023/01/10.
//

import SwiftUI

struct SettingEditorView: View {
    
    
    var body: some View {
              
        #if os(iOS)
        Text("Hello Detail Editor")
        
        Text("Push 설정 // SWIFT 는 개발 제한 (APPLE ID) ")
        
        Text("자동 로그인")
        Text("Map 화면 설정")
        Text("서버 연동")
        
        #else
                
        #endif
                
    }
}
struct SettingEditorView_Previews: PreviewProvider {
    static var previews: some View {
        SettingEditorView()
    }
}
