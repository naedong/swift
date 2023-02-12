//
//  BackGroundEditorView.swift
//  myprojec
//
//  Created by E4 on 2023/01/10.
//

import SwiftUI

struct BackGroundEditorView: View {

    @Binding var colorModel : ColorsModel
    @State private var isPlaying = false
    
    /// 밑으로는 코드와 관계없는 연습용 추가됨
    @Binding var panel : Panel?
    @EnvironmentObject var getCheck : MySelectColor
    @Binding var colorSet : ColorSet
    var body: some View {
        Text("Hello, Background!")
        
        
        
        Text("백 그라운드 색깔을 사용자 지정할 수 있는 페이지이 값들을 서버에 사용자별로 저장을 해야함")
        #if os(iOS)
        content
            .fullScreenCover(isPresented: $isPlaying) {
                colorView
            }
        #else
        let item = ToolbarItem(placement: .navigation) {
            Toggle(isOn: $isPlaying) {
                Image(systemName: "play.fill")
            }
        }
        
        if isPlaying {
            colorSet
                .toolbar { item }
        } else {
            content
                .toolbar { item }
        }
        #endif
    }
    var content: some View {
        // 수정 및 옛날 버전용 예정 
        NavigationView {
            List {
                ForEach(colorSet.gradients.indices, id: \.self) { index in
                    let gradient = colorSet.gradients[index]
                
                    NavigationLink(destination: BackGroundDetailView(gradient: $colorSet.gradients[index])) {
                        HStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.linearGradient(gradient.gradient, startPoint: .leading, endPoint: .trailing))
                                .frame(width: 32, height: 32)

                            VStack(alignment: .leading) {
                                gradient.name.isEmpty ? Text("New BackGround") : Text(gradient.name)
                                Text("\(gradient.stops.count) colors")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .environmentObject(getCheck)
                }
            }
            .navigationTitle("Gradients")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        colorSet.append(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple])
                    } label: {
                        Image(systemName: "plus")
                    }
                }
             

                #if os(iOS)
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        isPlaying = true
                    } label: {
                        Image(systemName: "play.fill")
                    }
                }
                #endif

            }

            Text("No Gradient")
        }
    }
    var colorView : some View {
        NavigationView {
            BackGroundColum(gradients: colorSet.gradients.map(\.gradient), colorsModel: $colorModel, colorSet: $colorSet, selection: $panel)
                .toolbar {
#if os(iOS)
                    Button {
                        isPlaying = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
#endif
                }

            Text("Choose a visualizer")
        }
        .environmentObject(getCheck)
        .preferredColorScheme(.dark)
    }
}
            
            
            
     
