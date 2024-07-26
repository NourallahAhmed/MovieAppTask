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
    
    var didStartMonitoringHandler: (() -> Void)?
    var didStopMonitoringHandler: (() -> Void)?
    var netStatusChangeHandler: (() -> Void)?
    
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
            DispatchQueue.main.async {
                self.netStatusChangeHandler?()
                
                if path.status == .satisfied {
                    guard let delegate = self.delegate else {
                        return
                    }
                    delegate.networkStatusDidChange(isConnected: true)
                    // Perform some action when the network returns
                    // For example, fetch data from a server or update UI
                } else {
                    guard let delegate = self.delegate else {
                        return
                    }
                    delegate.networkStatusDidChange(isConnected: false)
                }
            }
        }
        
        isMonitoring = true
        didStartMonitoringHandler?()
    }

    func stopMonitoring() {
        if isMonitoring, let monitor = monitor {
            monitor.cancel()
            self.monitor = nil
            isMonitoring = false
            didStopMonitoringHandler?()
        }
    }
    
    deinit {
        stopMonitoring()
    }
}
