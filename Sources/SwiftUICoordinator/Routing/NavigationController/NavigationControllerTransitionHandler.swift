//
//  NavigationControllerTransitionHandler.swift
//  
//
//  Created by Erik Drobne on 19. 10. 23.
//

import SwiftUI

@MainActor
public class NavigationControllerTransitionHandler {
    
    public let provider: TransitionProvidable
    
    public init(provider: TransitionProvidable) {
        self.provider = provider
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        guard
            let from = (fromVC as? RouteProvider)?.route,
            let to = (toVC as? RouteProvider)?.route
        else {
            return nil
        }
        
        if let transition = provider.transitions
            .compactMap({ $0.transition })
            .first(where: { $0.isEligible(from: from, to: to, operation: operation) }) {
            return transition
        }
        
        return nil
    }
}
