//
//  NavigationControllerDelegateProxy.swift
//
//
//  Created by Erik Drobne on 19. 10. 23.
//

import SwiftUI

@MainActor
open class NavigationControllerDelegateProxy: NSObject, UINavigationControllerDelegate {
    
    public let transitionHandler: NavigationControllerTransitionHandler
    
    public init(transitionHandler: NavigationControllerTransitionHandler) {
        self.transitionHandler = transitionHandler
    }
    
    public func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return transitionHandler.navigationController(
            navigationController,
            animationControllerFor: operation,
            from: fromVC,
            to: toVC
        )
    }
}
