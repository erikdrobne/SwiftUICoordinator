//
//  Transition.swift
//  
//
//  Created by Erik Drobne on 15/05/2023.
//

import UIKit

public protocol Transition: UIViewControllerAnimatedTransitioning {
    func isEligible(from fromRoute: NavigationRoute, to toRoute: NavigationRoute) -> Bool
}
