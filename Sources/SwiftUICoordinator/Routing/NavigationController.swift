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
    
    /// The collection of registered transition objects.
    private(set) var transitions = [WeakTransition]()
    
    // MARK: - Initialization
    
    /// Initializes an instance of the class with optional customization for the navigation bar's visibility.
    ///
    /// - Parameter isNavigationBarHidden: A Boolean value indicating whether the navigation bar should be hidden on the created instance.
    /// If set to `true`, the navigation bar will be hidden. If set to `false`, the navigation bar will be displayed.
    ///
    /// - Note: By default `isNavigationBarHidden` is set to `true`.
    ///
    public convenience init(isNavigationBarHidden: Bool = true) {
        self.init(nibName: nil, bundle: nil)
        
        self.isNavigationBarHidden = isNavigationBarHidden
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    /// Registers a single `Transition` for use in navigation animations.
    ///
    /// - Parameter transition: The `Transition` to be registered.
    public func register(_ transition: Transition) {
        transitions.append(WeakTransition(transition))
    }
    
    /// Registers multiple `Transition` objects for use in navigation animations.
    ///
    /// - Parameter transitions: An array of `Transition` objects to be registered.
    public func register(_ transitions: [Transition]) {
        self.transitions += transitions.map { WeakTransition($0) }
    }
    
    /// Unregisters all `Transition` instances of the specified type.
    ///
    /// - Parameter type: The type of `Transition` to be unregistered.
    public func unregister<T: Transition>(_ type: T.Type) {
        transitions.removeAll { $0.transition is T }
    }
    
    /// Removes all registered `Transition` objects from the navigation controller.
    public func unregisterAllTransitions() {
        transitions.removeAll()
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
        let transitions = self.transitions.compactMap({ $0.transition })
        
        for transition in transitions {
            guard
                let from = (fromVC as? RouteProvider)?.route,
                let to = (toVC as? RouteProvider)?.route,
                transition.isEligible(from: from,to: to, operation: operation)
            else {
                continue
            }
                            
            return transition
        }
        
        return nil
    }
}
