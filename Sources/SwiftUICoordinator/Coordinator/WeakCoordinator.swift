//
//  WeakCoordinator.swift
//  
//
//  Created by Erik Drobne on 9. 10. 23.
//

import Foundation

/// A wrapper class that holds a weak reference to a coordinator object.
///
/// `WeakCoordinator` is used internally to store weak references to child coordinators.
public final class WeakCoordinator {
    /// The weak reference to the coordinator.
    public private(set) weak var coordinator: Coordinator?

    /// Initializes a `WeakCoordinator` with the provided coordinator.
    ///
    /// - Parameter coordinator: The coordinator to wrap with a weak reference.
    init(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}
