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
    func link(from url: URL) throws -> DeepLink?
}

extension DeepLinkHandler {
    func link(from url: URL) throws -> DeepLink? {
        guard url.scheme == scheme else {
            throw DeepLinkError.invalidScheme
        }
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw DeepLinkError.invalidURL
        }
        
        guard let action = components.host else {
            throw DeepLinkError.unknownURL
        }
        
        return links.first(where: { $0.action == action })
    }
}
