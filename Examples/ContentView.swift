//
//  ContentView.swift
//  Examples
//
//  Created by E4 on 2022/12/19.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navModel = NavModel()
    
    var body: some View {
        ZStack{
            GeometryReader {
                geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                NavView(navModel: navModel)
                    .frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                MenuView(navModel: navModel)
                    .frame(width : width)
                    .offset(x: navModel.isShowMenu ? 0 : -width)
            }
        }
   
}

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
               
        }
    }
}
