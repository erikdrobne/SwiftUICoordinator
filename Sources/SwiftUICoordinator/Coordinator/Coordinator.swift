//
//  Coordinator.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import Foundation

@MainActor
public protocol Coordinator: AnyObject {
    /// A property that stores a reference to the parent coordinator, if any.
    var parent: Coordinator? { get }
    /// An array that stores references to any child coordinators.
    var childCoordinators: [Coordinator] { get set }
    
    /// Takes action parameter and handles it.
    func handle(_ action: CoordinatorAction)
    /// Adds child coordinator to the list.
    func add(child: Coordinator)
    /// Removes the coordinator from the list of children.
    func remove(coordinator: Coordinator)
}

// MARK: - Extensions

public extension Coordinator {
    
    // MARK: - Public methods

    func add(child: Coordinator) {
        if !childCoordinators.contains(where: { $0 === child }) {
            childCoordinators.append(child)
        }
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}
