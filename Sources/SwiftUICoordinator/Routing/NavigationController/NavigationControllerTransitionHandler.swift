//
//  NavigationControllerTransitionHandler.swift
//  
//
//  Created by Erik Drobne on 19. 10. 23.
//

import UIKit

@MainActor
struct NavigationControllerTransitionHandler {

    /// The provider responsible for supplying transitions.
    let provider: TransitionProvidable

    /// Asks the transition handler for an animator object to use when transitioning a view controller on or off the navigation stack.
    ///
    /// - Parameters:
    ///   - navigationController: The navigation controller containing the view controllers involved in the transition.
    ///   - operation: The type of transition operation being performed.
    ///   - fromVC: The view controller that is being transitioned from.
    ///   - toVC: The view controller that is being transitioned to.
    ///
    /// - Returns: An animator object conforming to `UIViewControllerAnimatedTransitioning`, or nil if no animation is desired.
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        // Check if both fromVC and toVC conform to RouteProvider and retrieve their route information.
        guard
            let from = (fromVC as? RouteProvider)?.route,
            let to = (toVC as? RouteProvider)?.route
        else {
            return nil
        }

        // Find the eligible transition from the provider based on the given route and operation.
        if let transition = provider.transitions.first(where: {
            $0.isEligible(from: from, to: to, operation: operation)
        }) {
            return transition
        }

        return nil
    }
}
