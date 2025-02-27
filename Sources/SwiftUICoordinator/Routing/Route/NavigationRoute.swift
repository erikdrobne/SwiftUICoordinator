//
//  NavigationRoute.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import Foundation

@MainActor
public protocol NavigationRoute {
    /// Use this title to set the navigation bar title when the route is displayed.
    var title: String? { get }
    /// A property that provides the info about the appearance and styling of a route in the navigation system.
    var appearance: RouteAppearance? { get }
    /// A property that indicates whether the Coordinator should be attached to the View as an EnvironmentObject.
    var attachCoordinator: Bool { get }
    /// A property that hides the navigation bar
    var hidesNavigationBar: Bool? { get }
}

/// Protocol for stack-based navigation routes
@MainActor
public protocol StackNavigationRoute: NavigationRoute {
    /// Transition action to be used when the route is shown.
    var action: TransitionAction { get }
    /// A property that hides the back button during navigation
    var hidesBackButton: Bool? { get }
}

public extension NavigationRoute {
    var title: String? { return nil }
    var appearance: RouteAppearance? { return nil }
    var attachCoordinator: Bool { return true }
    var hidesNavigationBar: Bool? { return nil }
}

public extension StackNavigationRoute {
    var hidesBackButton: Bool? { nil }
}
