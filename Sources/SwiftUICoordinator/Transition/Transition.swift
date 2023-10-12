//
//  Transition.swift
//  
//
//  Created by Erik Drobne on 15/05/2023.
//

import SwiftUI

public typealias NavigationOperation = UINavigationController.Operation

/// Determines if the transition is eligible for a given pair of source and destination routes and the navigation operation.
///
/// - Parameters:
///   - fromRoute: The source `NavigationRoute` for the transition.
///   - toRoute: The destination `NavigationRoute` for the transition.
///   - operation: The `NavigationOperation` describing the navigation action (push or pop).
///
/// - Returns: `true` if the transition is eligible; otherwise, `false`.
@MainActor
public protocol Transitionable: UIViewControllerAnimatedTransitioning {
    func isEligible(
        from fromRoute: NavigationRoute,
        to toRoute: NavigationRoute,
        operation: NavigationOperation
    ) -> Bool
}
