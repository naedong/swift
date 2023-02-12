//
//  WebModel.swift
//  myprojec
//
//  Created by E4 on 2023/01/04.
//

import Foundation
import Combine


// ObservableObject: 개체가 변경되기 전에 내보내는 게시자가 있는 개체 유형입니다.
class WebModel: ObservableObject {
    
    // PassthroughSubject: 다운스트림 구독자에게 요소를 브로드캐스트 하는 주제
    var foos = PassthroughSubject<Int, Never>()
    var bars = PassthroughSubject<Int, Never>()
   
    
}
