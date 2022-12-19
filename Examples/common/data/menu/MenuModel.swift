//
//  MenuModel.swift
//  Examples
//
//  Created by E4 on 2022/12/19.
//

import SwiftUI

struct MenuModel: View {
    
    var systemName: String
    var title : String

    var body : some View {
        HStack{
            Image(systemName: systemName)
                .foregroundColor(.white)
                .imageScale(.large)
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
        }
        .padding(.leading, 10)
        Divider().background(Color(.white))

    }
}
struct MenuModel_Previews : PreviewProvider  {
    static var previews: some View{
        MenuModel(systemName: "person", title: "Profile")
    }
    
}
