//
//  MockTransition.swift
//  
//
//  Created by Erik Drobne on 29/05/2023.
//

import UIKit
import SwiftUICoordinator

class MockTransition: NSObject, Transitionable {
    func isEligible(
        from fromRoute: NavigationRoute,
        to toRoute: NavigationRoute,
        operation: NavigationOperation
    ) -> Bool {
        return (fromRoute as? MockRoute == .circle && toRoute as? MockRoute == .rectangle)
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }

        let containerView = transitionContext.containerView
        toView.alpha = 0.0

        containerView.addSubview(toView)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
