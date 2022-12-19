//
//  MenuItemView.swift
//  Examples
//
//  Created by E4 on 2022/12/19.
//

import SwiftUI

struct MenuItemView: View {
    let menuModel : MenuModel
    
    var body: some View {
        HStack{
            Image(systemName: menuModel.systemName)
                .foregroundColor(.white)
                .imageScale(.large)
            Text(menuModel.title)
                .foregroundColor(.white)
                .font(.headline)
        }
        .padding(.leading, 10)
        Divider().background(Color(.white))
    }
}

struct MenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        MenuItemView(menuModel: MenuModel(systemName: "person", title: "Profile"))
    }
}
