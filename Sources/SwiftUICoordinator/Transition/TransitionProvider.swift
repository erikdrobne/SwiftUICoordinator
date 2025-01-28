//
//  TransitionProvider.swift
//  
//
//  Created by Erik Drobne on 12. 10. 23.
//

import Foundation

@MainActor
public struct TransitionProvider: TransitionProvidable {
    public private(set) var transitions: [WeakTransition]
    /// A private array of transitions ensuring to retain them in memory as long as needed.
    private var _transitions: [Transitionable]

    public init(transitions: [Transitionable]) {
        self._transitions = transitions
        self.transitions = transitions.map { WeakTransition($0) }
    }
}
