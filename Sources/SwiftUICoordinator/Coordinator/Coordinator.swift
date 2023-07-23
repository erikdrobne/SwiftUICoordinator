//
//  Coordinator.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import Foundation

@MainActor
public protocol Coordinator: AnyObject {
    var parent: Coordinator? { get }
    var childCoordinators: [Coordinator] { get set }
    
    func handle(_ action: CoordinatorAction)
    func add(child: Coordinator)
    func removeFromParent()
}

// MARK: - Extensions

public extension Coordinator {
    
    // MARK: - Public methods

    func add(child: any Coordinator) {
        if !childCoordinators.contains(where: { $0 === child }) {
            childCoordinators.append(child)
        }
    }
    
    func removeFromParent() {
        parent?.childCoordinators.removeAll(where: { $0 === self })
    }
}
