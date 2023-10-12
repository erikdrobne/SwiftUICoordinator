//
//  NavigationController.swift
//  
//
//  Created by Erik Drobne on 12/05/2023.
//

import SwiftUI

@MainActor
public class NavigationController: UINavigationController {
    
    // MARK: - Internal Properties
    
    private var transitionProvider: TransitionProvidable?
    
    // MARK: - Initialization
    
    /// Initializes an instance of the class with optional customization for the navigation bar's visibility.
    ///
    /// - Parameter isNavigationBarHidden: A Boolean value indicating whether the navigation bar should be hidden on the created instance.
    /// If set to `true`, the navigation bar will be hidden. If set to `false`, the navigation bar will be displayed.
    ///
    /// - Note: By default `isNavigationBarHidden` is set to `true`.
    ///
    public convenience init(isNavigationBarHidden: Bool = true, transitionProvider: TransitionProvidable? = nil) {
        self.init(nibName: nil, bundle: nil)
        
        self.isNavigationBarHidden = isNavigationBarHidden
        self.transitionProvider = transitionProvider
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        guard
            let provider = self.transitionProvider,
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
