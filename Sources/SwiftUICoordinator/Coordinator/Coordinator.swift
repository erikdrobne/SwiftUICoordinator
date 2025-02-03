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
    /// - Important: Implementations **must** declare this property as `weak var parent: Coordinator?`
    var parent: Coordinator? { get }

    /// A list of child coordinators.
    var childCoordinators: [Coordinator] { get set }

    /// The name of the coordinator.
    var name: String { get }
    
    /// Handles a given `CoordinatorAction`.
    func handle(_ action: CoordinatorAction)
    
    /// Adds a child coordinator.
    func add(child: Coordinator)
    
    /// Removes a child coordinator.
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
            Logger.coordinator.warning("Attempted to add \(child.name), but it is already a child of \(self.name).")
            return
        }
        
        childCoordinators.append(child)
        Logger.coordinator.notice("Added \(child.name) as a child to \(self.name).")
    }

    func remove(coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
        Logger.coordinator.notice("Removed \(coordinator.name) from \(self.name).")
    }
    
    func handle(_ action: CoordinatorAction) {
        Logger.coordinator.warning("Unhandled action: \(action.name) by \(self.name).")
    }
}
