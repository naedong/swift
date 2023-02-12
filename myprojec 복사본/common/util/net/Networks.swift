//
//  Networks.swift
//  myprojec
//
//  Created by E4 on 2022/12/28.
//
import Foundation
import Combine
import Network

final class NetworkMonitor: NetworkReachabilityProvider {
    public var networkStatusHandler: AnyPublisher<NetworkReachabilityStatus, Never> {
        reachabilityNotifier.eraseToAnyPublisher()
    }
    
    private let monitor: NWPathMonitor = .init()
    private let handlerQueue: DispatchQueue = .main
    private let reachabilityNotifier: PassthroughSubject<NetworkReachabilityStatus, Never>
    
    // MARK: - Lifecycle
    
    public init() {
        reachabilityNotifier = PassthroughSubject<NetworkReachabilityStatus, Never>()
        configureListener()
    }
    
    deinit {
        monitor.cancel()
    }
    
    // MARK: - Public
    
    public func stopListening() {
        monitor.cancel()
    }
    
    @discardableResult
    public func startListening() -> AnyPublisher<Bool, Never> {
        monitor.start(queue: handlerQueue)
        return Just(true).eraseToAnyPublisher()
    }
    
    // MARK: - Private
    
    private func configureListener() {
        var networkStatus: NetworkReachabilityStatus = .unknown

        monitor.pathUpdateHandler = { [weak self] path in
            switch path.status {
            case .satisfied:
                if path.usesInterfaceType(.wifi) || path.usesInterfaceType(.wiredEthernet) {
                    networkStatus = .reachable(.ethernetOrWiFi)
                } else {
                    networkStatus = .reachable(.wwan)
                }
            case .unsatisfied,
                 .requiresConnection:
                networkStatus = .notReachable
            @unknown default:
                networkStatus = .notReachable
            }
            
            self?.reachabilityNotifier.send(networkStatus)
        }
    }
}
