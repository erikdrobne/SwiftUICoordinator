//
//  TransitionProvider.swift
//  
//
//  Created by Erik Drobne on 12. 10. 23.
//

import Foundation

@MainActor
struct TransitionProvider: TransitionProvidable {
    
    /// This property returns an array of `Transitionable` objects by casting the weakly
    /// referenced objects stored in the internal `NSHashTable`.
    ///
    /// - Returns: An array of `Transitionable` objects, or an empty array if no transitions are available.
    var transitions: [Transitionable] {
        return _transitions.allObjects.compactMap { $0 as? Transitionable }
    }
    
    /// A private `NSHashTable` that stores weak references to `Transitionable` objects.
    private let _transitions: NSHashTable<AnyObject>

    init(transitions: [Transitionable]) {
        self._transitions = NSHashTable.weakObjects()
        transitions.forEach { self._transitions.add($0) }
    }
}
