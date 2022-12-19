//
//  MenuView.swift
//  Examples
//
//  Created by E4 on 2022/12/19.
//

import SwiftUI

struct MenuView: View {
    
    @ObservedObject var navModel: NavModel

    let menuModelList: [MenuModel] = [
        MenuModel(systemName: "person", title: "Profile"),
        MenuModel(systemName: "envelope", title: "Messages"),
        MenuModel(systemName: "gear", title: "setting")
    ]
    
    
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading){
                        Divider().background(Color(.white))
                            .padding(.top, 100)
                        ForEach(Array(menuModelList.enumerated())
                                , id:\.offset) {
                            i, menuModel in
                            MenuItemView(menuModel: menuModel)
                        }
                        Spacer()
                        
                        
//                        MenuModel(systemName: "person", title: "Profile")
//                        MenuModel(systemName: "envelope", title: "Messages")
//                        MenuModel(systemName: "gear", title: "setting")
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.blue)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Menu", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        withAnimation {
                            navModel.isShowMenu.toggle()
                        }
                    }){
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.white)
                            .imageScale(.large)
                    }
            )
        }
    }
}
    
    




struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(navModel : NavModel())
    }
}
