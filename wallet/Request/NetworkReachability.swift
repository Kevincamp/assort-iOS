//
//  NetworkReachability.swift
//  wallet
//
//  Created by Kevin Campuzano on 5/2/22.
//

import Foundation
import Network

class NetworkReachability {
    static let shared = NetworkReachability()
    var monitor: NWPathMonitor?
    var isMonitoring = false

    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }

    private init() { }

    deinit {
        stopMonitoring()
    }

    func startMonitoring() {
        guard !isMonitoring else { return }
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkReachability")
        monitor?.start(queue: queue)
        isMonitoring = true
    }

    func stopMonitoring() {
        guard
            isMonitoring,
            let monitor = monitor
        else { return }

        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
    }
}
