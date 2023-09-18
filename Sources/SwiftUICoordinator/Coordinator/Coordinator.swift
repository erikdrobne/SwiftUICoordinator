//
//  Coordinator.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import Foundation
import OSLog

@MainActor
public protocol Coordinator: AnyObject {
    /// A property that stores a reference to the parent coordinator, if any.
    var parent: Coordinator? { get }
    /// An array that stores references to any child coordinators.
    var childCoordinators: [Coordinator] { get set }
    
    /// Takes action parameter and handles the `CoordinatorAction`.
    func handle(_ action: CoordinatorAction)
    /// Adds child coordinator to the list.
    func add(child: Coordinator)
    /// Removes the coordinator from the list of children.
    func remove(coordinator: Coordinator)
    /// Takes deep link and its parameters and handles it.
    func handle(_ deepLink: DeepLink, with params: [String: String])
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
    
    func handle(_ deepLink: DeepLink, with params: [String: String] = [:]) {
        Logger.deepLink.warning("Deep link handler is not implemented.")
        assertionFailure("Deep link handler is not implemented.")
    }
}
