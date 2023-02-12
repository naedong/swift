//
//  WebViewModel.swift
//  example
//
//  Created by 이정훈 on 2022/12/18.
//

import Foundation
import Combine

// ObservableObject: 개체가 변경되기 전에 내보내는 게시자가 있는 개체 유형입니다.
class WebViewModel: ObservableObject {
    
    // PassthroughSubject: 다운스트림 구독자에게 요소를 브로드캐스트 하는 주제
    var foo = PassthroughSubject<Int, Never>()
    var bar = PassthroughSubject<Int, Never>()
   
        // Title of the HTML page
        var webTitle = PassthroughSubject<String, Never>()
        var send = PassthroughSubject<String, Never>()
    
}
