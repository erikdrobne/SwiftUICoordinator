//
//  File.swift
//  
//
//  Created by Erik Drobne on 10. 10. 23.
//

import Foundation

/// A wrapper class that holds a weak reference to a transition object.
///
/// `WeakTransition` is used internally to store weak references to transitions.
public final class WeakTransition {
    /// The weak reference to the transition.
    public private(set) weak var transition: Transition?
    
    /// Initializes a `WeakTransition` with the provided transition.
    ///
    /// - Parameter transition: The transition to wrap with a weak reference.
    init(_ transition: Transition) {
        self.transition = transition
    }
}
