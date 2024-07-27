//
//  NetworkConnectivity.swift
//  MovieAppTask
//
//  Created by NourAllah Ahmed on 26/07/2024.
//

import Foundation
import Network

protocol NetworkReachabilityDelegate {
    func networkStatusDidChange(isConnected: Bool)
}

@available(iOS 12.0, *)
class NetworkConnectivity{
    static let shared = NetworkConnectivity()
    
    private var monitor: NWPathMonitor?
    private var isMonitoring = false
    
    
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    var interfaceType: NWInterface.InterfaceType? {
        guard let _ = monitor else { return nil }
        return self.availableInterfacesTypes?.first
    }
    
    private var availableInterfacesTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }
    
    var delegate : NetworkReachabilityDelegate?
    
    private init(){}
    
    func startMonitoring() {
        if isMonitoring { return }
        
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        monitor?.start(queue: queue)
        monitor?.pathUpdateHandler = { path in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                if path.status == .satisfied {
                    guard let delegate = self.delegate else {
                        return
                    }
                    delegate.networkStatusDidChange(isConnected: true)
                
                } else {
                    guard let delegate = self.delegate else {
                        return
                    }
                    delegate.networkStatusDidChange(isConnected: false)
                }
            }
        }
        
        isMonitoring = true
    }

    func stopMonitoring() {
        if isMonitoring, let monitor = monitor {
            monitor.cancel()
            self.monitor = nil
            isMonitoring = false
        }
    }
    
    deinit {
        stopMonitoring()
    }
}
