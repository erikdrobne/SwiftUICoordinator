//
//  Transition.swift
//  
//
//  Created by Erik Drobne on 15/05/2023.
//

import SwiftUI

public typealias NavigationOperation = UINavigationController.Operation

public protocol Transition: UIViewControllerAnimatedTransitioning {
    func isEligible(from fromRoute: NavigationRoute, to toRoute: NavigationRoute, operation: NavigationOperation) -> Bool
}
