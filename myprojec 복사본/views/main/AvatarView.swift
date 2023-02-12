//
//  AvatarView.swift
//  myprojec
//
//  Created by E4 on 2022/12/20.
//

import SwiftUI

struct AvatarView: View {
    
    var pic : String
    var fontSize : CGFloat;
    var backSize : CGFloat;
    var xOffset : CGFloat;
    var yOffset : CGFloat;
    @State private var shimmer : Bool = .random();
    
    var body: some View {
        ZStack{
            Image(pic)
                .resizable()
                .scaledToFill().blendMode(.overlay)
                .frame(width: backSize, height: backSize)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .saturation(Double(1.5))
                .blur(radius: 1.5 - 2)
                .offset(x: xOffset, y: yOffset)
                .animation(Animation.linear(duration: 3)
                    .repeatForever(autoreverses: true))
                .shadow(color: Color("green"), radius: 3, x: -2, y: -2)
                .shadow(color: Color("yellow"), radius: 3, x: 2, y: 2)
                
             Image(pic)
                .resizable()
                .scaledToFill()
                .frame(width: fontSize, height: fontSize)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .scaleEffect(shimmer ? 1.1 : 1)
                .animation(Animation.linear(duration: 2).repeatForever(autoreverses: true))
                .shadow(color: Color("yellow"), radius: 7, x: -2, y: -2)
                .shadow(color: Color("green"), radius: 7, x: 2, y: 2)
                .onAppear(withAnimation(self.shimmer.toggle()))
                
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}
