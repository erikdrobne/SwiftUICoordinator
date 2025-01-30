//
//  TransitionProvider.swift
//  
//
//  Created by Erik Drobne on 12. 10. 23.
//

import Foundation

@MainActor
public struct TransitionProvider: TransitionProvidable {

    public var transitions: [Transitionable] {
        return _transitions.allObjects.compactMap { $0 as? Transitionable }
    }
    
    private let _transitions: NSHashTable<AnyObject>

    public init(transitions: [Transitionable]) {
        self._transitions = NSHashTable.weakObjects()
        transitions.forEach { self._transitions.add($0) }
    }
}
