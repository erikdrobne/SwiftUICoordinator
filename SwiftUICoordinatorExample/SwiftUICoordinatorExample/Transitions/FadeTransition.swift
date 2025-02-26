//
//  FadeTransition.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 15/05/2023.
//

import UIKit
import SwiftUICoordinator

final class FadeTransition: NSObject, Transitionable {
    func isEligible(
        from fromRoute: NavigationRoute,
        to toRoute: NavigationRoute,
        operation: NavigationOperation
    ) -> Bool {
        guard let from = fromRoute as? CatalogRoute, let to = toRoute as? CatalogRoute else {
            return false
        }
        
        let firstProduct = ProductItem.mock[0]
        return from == .productList && to == .productDetails(firstProduct) ||
            to == .productList && from == .productDetails(firstProduct)
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
