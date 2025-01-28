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
    /// Should be used as a weak reference.
    var parent: Coordinator? { get }
    /// An array that stores references to any child coordinators.
    var childCoordinators: [WeakCoordinator] { get set }
    /// Coordinator type name
    var name: String { get }
    /// Takes action parameter and handles the `CoordinatorAction`.
    func handle(_ action: CoordinatorAction)
    /// Adds child coordinator to the list.
    func add(child: Coordinator)
    /// Removes the coordinator from the list of children.
    func remove(coordinator: Coordinator)
}

// MARK: - Extensions

public extension Coordinator {

    // MARK: - Public properties

    var name: String {
        return String(describing: type(of: self))
    }

    // MARK: - Public methods

    func add(child: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === child }) else {
            Logger.coordinator.warning(
                "Attempted to add a coordinator that is already a child: \(self.name)"
            )
            return
        }

        childCoordinators.append(WeakCoordinator(child))
    }

    func remove(coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0.coordinator === coordinator })
        Logger.coordinator.notice("Removed coordinator: \(self.name)")
    }
}
