//
//  NavigationController.swift
//  
//
//  Created by Erik Drobne on 12/05/2023.
//

import SwiftUI

public class NavigationController: UINavigationController {
    
    // MARK: - Properties
    
    public private(set) var transitions = [ObjectIdentifier: Transition]()
    
    // MARK: - Initialization
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Public methods
    
    public func register(_ transition: Transition) {
        let transitionType = ObjectIdentifier(type(of: transition))
        if transitions[transitionType] == nil {
            transitions[transitionType] = transition
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        for transition in transitions.values {
            if let from = (fromVC as? RouteProvider)?.route, let to = (toVC as? RouteProvider)?.route {
                if transition.isEligible(from: from,to: to, operation: operation) {
                    return transition
                }
            }
        }
        
        return nil
    }
}
