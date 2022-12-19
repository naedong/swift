//
//  NavView.swift
//  Examples
//
//  Created by E4 on 2022/12/19.
//

import SwiftUI

struct NavView: View {
    
    @ObservedObject var navModel: NavModel
    
    var body: some View {
        NavigationView{
            MainView(navModel: navModel)
        }
    }
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView(navModel : NavModel())
    }
}
