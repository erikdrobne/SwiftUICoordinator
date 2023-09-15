//
//  DeepLinkHandler.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 15/09/2023.
//

import Foundation
import SwiftUICoordinator

class DeepLinkHandler: DeepLinkHandling {
    
    static let shared = DeepLinkHandler()
    
    let scheme = "coordinatorexample"
    let links = Set<DeepLink>.init()
    
    private init() {}
    
    func link(for url: URL) throws -> DeepLink? {
        return nil
    }
    
    func params(for url: URL, and keys: [String]) throws -> [String : String] {
        return [:]
    }
}
