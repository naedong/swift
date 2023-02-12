//
//  NetWorkConfig.swift
//  myprojec
//
//  Created by E4 on 2022/12/28.
//

import Foundation
import SystemConfiguration
import Combine

protocol NetworkReachabilityProvider: AnyObject {
    var networkStatusHandler: AnyPublisher<NetworkReachabilityStatus, Never> { get }
    
    func stopListening()
    func startListening() -> AnyPublisher<Bool, Never>
}

public enum NetworkReachabilityStatus: Equatable {
    public enum ConnectionType {
        case ethernetOrWiFi
        case wwan
    }
    
    case unknown
    case notReachable
    case reachable(ConnectionType)
}

final class NetworkReachability: NetworkReachabilityProvider {
    
    public var networkStatusHandler: AnyPublisher<NetworkReachabilityStatus, Never> {
        reachabilityNotifier.eraseToAnyPublisher()
    }
    
    private let handlerQueue: DispatchQueue = .main
    private let reachability: SCNetworkReachability
    private var previousFlags: SCNetworkReachabilityFlags
    private let reachabilityNotifier: PassthroughSubject<NetworkReachabilityStatus, Never>
    
    private var flagsForCurrentReachability: SCNetworkReachabilityFlags? {
        var flags = SCNetworkReachabilityFlags()
        if SCNetworkReachabilityGetFlags(reachability, &flags) {
            return flags
        }
        
        return nil
    }
    
    // MARK: - Lifecycle
    
    convenience init?() {
        // Socket address, internet style
        var initialAddress = sockaddr_in()
        // The length member, sin_len, was added with 4.3BSD-Reno,
        // when support for the OSI protocols was added
        initialAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        // internetwork: UDP, TCP, etc
        initialAddress.sin_family = sa_family_t(AF_INET)
        
        if let initialReachability: SCNetworkReachability =
            withUnsafePointer(
                to: &initialAddress, {
                    $0.withMemoryRebound(
                        to: sockaddr.self,
                        capacity: MemoryLayout<sockaddr>.size
                    ) {
                        SCNetworkReachabilityCreateWithAddress(nil, $0)
                    }
                }) {
            self.init(reachability: initialReachability)
        } else {
            return nil
        }
    }
    
    private init(reachability: SCNetworkReachability) {
        self.reachability = reachability
        self.previousFlags = .init()
        self.reachabilityNotifier = PassthroughSubject<NetworkReachabilityStatus, Never>()
    }
    
    deinit {
        defer {
            reachabilityNotifier.send(completion: .finished)
        }
        stopListening()
    }
    
    // MARK: - Public
    
    func stopListening() {
        SCNetworkReachabilitySetCallback(reachability, nil, nil)
        SCNetworkReachabilitySetDispatchQueue(reachability, nil)
    }
    
    @discardableResult
    func startListening() -> AnyPublisher<Bool, Never> {
        var context = SCNetworkReachabilityContext(
            version: 0,
            info: nil,
            retain: nil,
            release: nil,
            copyDescription: nil
        )
        context.info = Unmanaged.passUnretained(self).toOpaque()
        
        let callbackEnabled = SCNetworkReachabilitySetCallback(
            reachability,
            { (_, flags, info) in
                if let info = info {
                    let reachability = Unmanaged<NetworkReachability>
                        .fromOpaque(info)
                        .takeUnretainedValue()
                    reachability.notifyListener(flags)
                }
            },
            &context
        )
        
        let queueEnabled = SCNetworkReachabilitySetDispatchQueue(
            reachability,
            handlerQueue
        )
        
        handlerQueue.async { [weak self] in
            self?.notifyListener(self?.flagsForCurrentReachability ?? .init())
        }
        
        return Just(callbackEnabled && queueEnabled).eraseToAnyPublisher()
    }
    
    // MARK: - Private
    
    private func reachabilityOfNetworkFor(
        _ flags: SCNetworkReachabilityFlags
    ) -> NetworkReachabilityStatus {
        var networkStatus: NetworkReachabilityStatus = .unknown
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        let canConnectAutomatically = flags.contains(.connectionOnDemand) ||
            flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically &&
            !flags.contains(.interventionRequired)
        let isNetworkAvailableFlag = isReachable &&
            (!needsConnection || canConnectWithoutUserInteraction)
        
        if isNetworkAvailableFlag {
            networkStatus = .reachable(.ethernetOrWiFi)
            
            #if os(iOS)
            if flags.contains(.isWWAN) {
                networkStatus = .reachable(.wwan)
            }
            #endif
            
        } else {
            networkStatus = .notReachable
        }
        
        return networkStatus
    }
    
    private func notifyListener(_ flags: SCNetworkReachabilityFlags) {
        guard previousFlags != flags else {
            return
        }
        previousFlags = flags
        let currentNetworkStatus = reachabilityOfNetworkFor(flags)
        
        reachabilityNotifier.send(currentNetworkStatus)
    }
}
