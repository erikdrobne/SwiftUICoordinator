//
//  Coordinator.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import Foundation
import SwiftUI

@MainActor
public protocol Coordinator: AnyObject {
    var parent: Coordinator? { get }
    var childCoordinators: [Coordinator] { get set }
    
    func add(child: Coordinator)
    func navigate(to route: NavigationRoute)
    func finish()
}

// MARK: - Extensions

public extension Coordinator {
    
    // MARK: - Public methods
    
    func finish() {
        parent?.childCoordinators.removeAll(where: { $0 === self })
    }

    func add(child: Coordinator) {
        if !childCoordinators.contains(where: { $0 === child }) {
            childCoordinators.append(child)
        }
    }
}
