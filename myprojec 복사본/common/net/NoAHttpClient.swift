////
////  NoAHttpClient.swift
////  myprojec
////
////  Created by E4 on 2022/12/27.
////
//
//
//
//import Foundation
//import Alamofire
//
//class HttpsClient: ObservableObject {
//
//    typealias onSuccess = () -> ()
//    typealias onFailure = () -> ()
//
//    let headers: HTTPHeaders = [
//        .accept("application/json"),
//        .contentType("application/json")
//    ]
//
//
//
//    // DATA
////    @Published var resData: ResponseModel<T>!
////
////    // Data tasks: NSData 객체를 사용하여 데이터를 주고 받는 task이다. 주로 짧고 빈번한 통신에 사용한다.
////    // Upload tasks: 데이터를 업로드하고(종종 파일 형식), 앱이 실행되지 않는 동안 백그라운드 업로드를 지원한다.
////    // Download tasks: 파일 형식으로 데이터를 검색하고 앱이 실행되지 않는 동안 백그라운드 다운로드 및 업로드를 지원한다.
////    // WebSocket: 웹소켓 작업은 RFC 6455에 정의된 WebSocket 프로토콜을 사용하여 TCP, TLS를 통해 메시지를 교환한다.
////
////    func urlSession(url: String) {
////        guard let sessionUrl = URL(string: url) else {
////            print("Invalid URL")
////            return
////        }
////
////        // Dafault Session: Shared Session과 유사하지만 우리가 직접 구성할 수 있으며, 데이터를 점진적(data를 점차 증가시키면서)으로 받아올 수 있도록 delegate를 할당할 수 있다. 기본적인 Session으로 디스크 기반 캐싱을 지원한다.
////        // Ephemeral Session: 한글로 임시 세션으로 Shared Session과 비슷하지만 어떠한 데이터도 저장하지 않는다.
////        // Background Session: 앱이 백그라운드에 있어도 통신을 진행한다.
////        // shared Session: Singleton인 기본 Session이다. 우리가 직접 구성할 수 없기에 요구 사항이 매우 제한적인 경우 사용하기 좋다.
////
////        let session = URLSession.shared
////
////        var requestURL = URLRequest(url: sessionUrl)
////        requestURL.httpMethod = "GET"
////
////        let header: HTTPHeaders = ["Content-Type": "application/json", "Accept": "application/json"]
////        requestURL.headers = header
////
////        let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
////            // 에러검사
////            guard error == nil else {
////                print(error!)
////                return
////            }
////            let response = response as? HTTPURLResponse
////
////            // 상태코드 분기
////            guard let data = data, let response = response, (200...299) ~= response.statusCode else {
////                if let responses = response {
////                    print("response.statusCode : \(responses.statusCode)")
////                    if(responses.statusCode == 401){
////                        print("비정상 접근 또는 서버 에러")
////                        return
////                    } else if((404...500) ~= responses.statusCode){
////                        print("비정상 접근 또는 서버 에러")
////                        return
////                    }
////                    print("Error: # HTTP request failed")
////                    return
////                } else {
////                    print("Error: ## HTTP request failed")
////                    return
////                }
////            }
////
////            // 디코드한 data값을 resData에 T form으로 data를 디코드하여 decodedData에 저장
////            guard let decodaData = try? JSONDecoder().decode(ResponseModel<T>.self, from: data) else {
////                print("Error: JSON parsing failed")
////                return
////            }
////
////            self.resData = decodaData.self
////        }
////        dataTask.resume()
////    }
//
//    func alamofireNetworking(url: String, onSuccess: @escaping onSuccess, onFailure: @escaping onFailure) {
//        print("alamofireNetworking")
//        guard let sessionUrl = URL(string: url) else {
//            print("Invalid URL")
//            return
//        }
//
//        print("sessionUrl : \(sessionUrl)")
//        AF.request(sessionUrl,
//                   method: .get,
//                   parameters: nil,
//                   encoding: URLEncoding.default,
//                   headers: headers)
//        .responseDecodable(){ response in
//            print("response : \(response)")
//            switch response.result {
//                case .success(let value):
//                print("\(value)")
//                    onSuccess(value)
//                case .failure(let error):
//                    print(error)
//                    onFailure()
//            }
//        }
//    }
//}
