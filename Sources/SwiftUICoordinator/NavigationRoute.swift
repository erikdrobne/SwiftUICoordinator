//
//  NavigationRoute.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import Foundation

@MainActor
public protocol NavigationRoute {
    /// This title can be used to set the navigation bar title when the route is shown.
    var title: String? { get }
    /// The type of transition to be used when the route is shown.
    /// This can be a push transition, a modal presentation, or `nil` (for child coordinators).
    var transition: NavigationTransition? { get }
}
