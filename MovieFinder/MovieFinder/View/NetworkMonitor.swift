//
//  NetworkMonitor.swift
//  MovieFinder
//
//  Created by Selçuk Arıöz on 25.12.2023.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    public private(set) var connectiontype : ConnecitonType = .unknown
    
    enum ConnecitonType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    private init() {
        monitor = NWPathMonitor()
    }
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    public func stopMonitoring() {
        monitor.cancel()
    }
    private func getConnecitonType( path: NWPath){
        if path.usesInterfaceType(.wifi){
            connectiontype = .wifi
        }
        else if path.usesInterfaceType(.cellular){
            connectiontype = .cellular
        }
        else if path.usesInterfaceType(.wiredEthernet){
            connectiontype = .ethernet
        }
        else {
            connectiontype = .unknown
        }
    }
}
