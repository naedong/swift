//
//  ColorPicker.swift
//  myprojec
//
//  Created by E4 on 2023/01/11.
//

import SwiftUI

struct SystemColorList: View {
    @Binding var color: Color
    var remove: () -> Void

    var body: some View {
        List {
            Section(header: Text("Color")) {
                SystemColorPicker(color: $color)
                    .pickerStyle(.inline)
                    .labelsHidden()
            }

            Section {
                HStack {
                    Spacer()
                    Button("Delete", role: .destructive, action: remove)
                    Spacer()
                }
            }
        }
        .listStyle(.plain)
    }

    struct Empty: View {
        var body: some View {
            List {
                Section(header: Text("Color")) {
                    Text("No selection")
                        .foregroundStyle(.secondary)
                }
            }
            .listStyle(.plain)
        }
    }
}

struct SystemColorPicker: View {
    @Binding var color: Color

    var body: some View {
        let options = [
            ColorSelectModel(name: "White", color: .white),
            ColorSelectModel(name: "Gray", color: .gray),
            ColorSelectModel(name: "Black", color: .black),
            ColorSelectModel(name: "Red", color: .red),
            ColorSelectModel(name: "Orange", color: .orange),
            ColorSelectModel(name: "Yellow", color: .yellow),
            ColorSelectModel(name: "Green", color: .green),
            ColorSelectModel(name: "Mint", color: .mint),
            ColorSelectModel(name: "Teal", color: .teal),
            ColorSelectModel(name: "Cyan", color: .cyan),
            ColorSelectModel(name: "Blue", color: .blue),
            ColorSelectModel(name: "Indigo", color: .indigo),
            ColorSelectModel(name: "Purple", color: .purple),
            ColorSelectModel(name: "Pink", color: .pink),
            ColorSelectModel(name: "Brown", color: .brown)
        ]
        Picker("Color", selection: $color) {
            ForEach(options) { option in
                Label {
                    Text(option.name)
                } icon: {
                    option.color
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .strokeBorder(.tertiary, lineWidth: 1)
                        }
                        .cornerRadius(6)
                        .frame(width: 32, height: 32)
                }
                .tag(option.color)
            }
        }
    }
}

