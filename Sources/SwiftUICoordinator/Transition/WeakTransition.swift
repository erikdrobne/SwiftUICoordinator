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
public final class WeakTransition: Hashable {
    /// The weak reference to the transition.
    public private(set) weak var transition: Transitionable?
    
    /// Initializes a `WeakTransition` with the provided transition.
    ///
    /// - Parameter transition: The transition to wrap with a weak reference.
    init(_ transition: Transitionable) {
        self.transition = transition
    }
    
    public func hash(into hasher: inout Hasher) {
        // Hash based on the underlying transition object's memory address.
        hasher.combine(ObjectIdentifier(transition as AnyObject))
    }
    
    public static func == (lhs: WeakTransition, rhs: WeakTransition) -> Bool {
        return lhs.transition === rhs.transition
    }
}
