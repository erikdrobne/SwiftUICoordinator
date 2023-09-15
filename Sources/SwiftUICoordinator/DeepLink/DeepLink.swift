//
//  DeepLink.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 11/09/2023.
//

import Foundation

public struct DeepLink {
    public let action: String
    public let route: NavigationRoute
    public let params: Set<String>
    
    public init(action: String, route: NavigationRoute, params: Set<String> = []) {
        self.action = action
        self.route = route
        self.params = params
    }
}

extension DeepLink: Hashable {
    public static func == (lhs: DeepLink, rhs: DeepLink) -> Bool {
        lhs.action == rhs.action
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(action)
    }
}
