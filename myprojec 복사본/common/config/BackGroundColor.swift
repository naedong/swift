//
//  BackGroundColor.swift
//  myprojec
//
//  Created by E4 on 2023/01/11.
//

import SwiftUI
import os


extension View {
  func myCustomBackgroundColor(_ color: Color) -> some View {
      
      environment(\.captionBackgroundColor, color)
  }
}

extension EnvironmentValues {
  var captionBackgroundColor: Color {
    get { self[CaptionColorKey.self] }
    set { self[CaptionColorKey.self] = newValue }
  }
}

private struct CaptionColorKey: EnvironmentKey {
    let log = Logger(subsystem: "e4net.enviroment", category: "enviroment")
    static let defaultValue = Color(.systemBackground)
}

