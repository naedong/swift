//
//  SaveColor.swift
//  myprojec
//
//  Created by E4 on 2023/01/11.
//
import SwiftUI

extension View {
  // 1
  func inverseMask<Mask>(_ mask: Mask) -> some View where Mask: View {
    
      
      self.mask(mask
      .foregroundColor(.black)
      .background(Color.white)
      .compositingGroup()

      .luminanceToAlpha()
    )
  }
}
