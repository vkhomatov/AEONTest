//
//  NetworkMonitor.swift
//  AEONTest
//
//  Created by Vitaly Khomatov on 21.02.2021.
//

import Network

// монитор сети
final class NetworkMonitor {
    let monitor = NWPathMonitor()
    
    init() {
        monitor.start(queue: .global())
    }
}
