//
//  MainView.swift
//  Examples
//
//  Created by E4 on 2022/12/19.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var navModel : NavModel
    
    var body: some View {
        TabView{
            AnyView1()
                .tabItem{
                    Label("Any1", systemImage:"house")
                }
            AnyView2()
                .tabItem{
                    Label("Any2", systemImage:"bag")
                }
        }
        .navigationBarTitle("EXAMPLE", displayMode: .inline)
        .navigationBarItems(
            leading:
                Button(
                    action:{
                        withAnimation{
                            navModel.isShowMenu.toggle()
                        }
                    })
                {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(Color/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .imageScale(.large)
                },
            trailing:
                Button(
                    action:{
                        withAnimation{
                            print("click trailing")
                        }
                    })
                {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .imageScale(.large)
                }
        )
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(navModel: NavModel())
    }
}
