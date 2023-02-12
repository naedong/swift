//
//  Sidebar.swift
//  myprojec
//
//  Created by E4 on 2023/01/10.
//

import SwiftUI

enum ChoiceSetting: Hashable {
    case background
    case mySetting
    case effect
    case back
    case main
}

struct Sidebar: View {
    /// The person's selection in the sidebar.
    ///
    /// This value is a binding, and the superview must pass in its value.
    @Binding var selection: ChoiceSetting?
    
    /// The view body.
    ///
    /// The `Sidebar` view presents a `List` view, with a `NavigationLink` for each possible selection.
    var body: some View {
        List(selection: $selection) {
            NavigationLink(value: ChoiceSetting.mySetting) {
                Label("Setting", systemImage: "slider.horizontal.3")
            }
            
            
            Section("Decorating") {
                NavigationLink(value: ChoiceSetting.background) {
                    Label {
                        Text("Decorating")
                    } icon: {
                        Image.Symbol
                    }
                }
                
                NavigationLink(value: ChoiceSetting.effect) {
                    Label("Effect Editor", systemImage: "lightbulb.2")
                }
                
                
            }
            Section("Back") {
                NavigationLink(value: ChoiceSetting.back) {
                    Label {
                        Text("Select Page")
                    } icon: {
                        Image.BackSymbol
                    }
                }
                
                
                
            }
            Section("Main") {
                NavigationLink(value: ChoiceSetting.main) {
                    Label {
                        Text("Main Page")
                    } icon: {
                        Image.MainSymbol
                    }
                }
                
                
                
            }
          
#if os(macOS)
#endif
        }
        .navigationTitle("Menu Bar")
        .navigationSplitViewColumnWidth(min: 200, ideal: 200)
    }
    
    struct Sidebar_Preview : PreviewProvider {
        struct Preview: View {
            @State private var selection: ChoiceSetting? = ChoiceSetting.mySetting
            var body: some View {
                Sidebar(selection: $selection)
            }
        }
        
        static var previews: some View {
            NavigationSplitView {
                Preview()
            } detail: {
                Text("Detail!")
            }
        }
    }
}
