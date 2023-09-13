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
    let params: Set<String>
}

extension DeepLink: Hashable {
    public static func == (lhs: DeepLink, rhs: DeepLink) -> Bool {
        lhs.action == rhs.action
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(action)
    }
}
