//
//  TransitionProvider.swift
//  
//
//  Created by Erik Drobne on 12. 10. 23.
//

import Foundation

@MainActor
public struct TransitionProvider: TransitionProvidable {
    public let transitions: [WeakTransition]
    /// A private array of transitions ensuring to retain them in memory as long as needed.
    private var _transitions: [Transition]
    
    public init(transitions: [Transition]) {
        self._transitions = transitions
        self.transitions = transitions.map { WeakTransition($0) }
    }
    
    public mutating func unregisterAll() {
        self._transitions.removeAll()
    }
}
