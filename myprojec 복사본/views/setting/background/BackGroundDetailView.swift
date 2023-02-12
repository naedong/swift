//
//  BackGroundDetail.swift
//  myprojec
//
//  Created by E4 on 2023/01/10.
//

import SwiftUI
import os
struct BackGroundDetailView: View {
    @EnvironmentObject var getCheck : MySelectColor
    @State var log = Logger(subsystem: "com.e4net.myprojec.views.setting.background.BackGroundDetailView.log", category: "BackGroundDetailView")
    @Binding var gradient: ColorsModel
    @State private var isEditing = false
    @State private var isBackCheck = false
    @State private var selectedStopID: Int?
   
   
    
    var body: some View {
        VStack {
            #if os(macOS)
            gradientBackground
            if isBackCheck {
                EnviromentToggle
            }
            #else
            if !isEditing {
                gradientBackground
            } else {
                BackGroundControllVIew(colors: $gradient, selectedStopID: $selectedStopID)
                    .padding()

                if let selectedStopID = selectedStopID {
                    SystemColorList(color: $gradient[stopID: selectedStopID].color) {
                        gradient.remove(selectedStopID)
                        self.selectedStopID = nil
                    }
                } else {
                    SystemColorList.Empty()
                }
            }
            #endif
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                #if os(macOS)
                BackGroundControllVIew(gradient: $gradient, selectedStopID: $selectedStopID, drawGradient: false)
                    .padding(.horizontal)
                #endif

                HStack {
                    #if os(macOS)
                    // macOS always allows editing of the title
                    TextField("Name", text: $gradient.name)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: 200)
                    #else
                    if isEditing {
                        TextField("Name", text: $gradient.name)
                    } else {
                        gradient.name.isEmpty ? Text("New Gradient") : Text(gradient.name)
                    }
                    #endif

                    Spacer()

                    Text("\(gradient.stops.count) colors")
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
            .background(.thinMaterial)
            .controlSize(.large)
        }
        .navigationTitle(gradient.name)
#if os(iOS)
        .toolbar {
            Button(isEditing ? "Done" : "Edit") {
                isEditing.toggle()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarItem(placement: .navigation) { // 3
                Button {
                    UserDefaults.setValue(gradient, forKey: "backs")
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                }
                
            }
        
        }
        
#endif
    }
   
    private var gradientBackground: some View {
        LinearGradient(gradient: gradient.gradient, startPoint: .leading, endPoint: .trailing)
            .ignoresSafeArea(edges: .bottom)
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BackGroundDetailView(
                gradient: .constant(ColorsModel(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple])))
        }
    }
}
