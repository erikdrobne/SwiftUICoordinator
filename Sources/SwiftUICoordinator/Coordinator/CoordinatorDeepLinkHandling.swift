//
//  CoordinatorDeepLinkHandling.swift
//  
//
//  Created by Erik Drobne on 12. 10. 23.
//

import Foundation

@MainActor
public protocol CoordinatorDeepLinkHandling {
    /// Takes deep link and its parameters and handles it.
    func handle(_ deepLink: DeepLink, with params: [String: String])
}
