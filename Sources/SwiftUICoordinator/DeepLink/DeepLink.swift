//
//  DeepLink.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 11/09/2023.
//

import Foundation

public struct DeepLink {
    let action: String
    let route: NavigationRoute
}

extension DeepLink: Hashable {
    public static func == (lhs: DeepLink, rhs: DeepLink) -> Bool {
        lhs.action == rhs.action
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(action)
    }
}

public protocol DeepLinkHandler {
    var scheme: String { get }
    var links: Set<DeepLink> { get }
    func link(from url: URL) -> DeepLink?
}

extension DeepLinkHandler {
    func link(from url: URL) -> DeepLink? {
        guard url.scheme == scheme else {
            return nil
        }
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        guard let action = components.host else {
            return nil
        }
        
        return links.first(where: { $0.action == action })
    }
}
