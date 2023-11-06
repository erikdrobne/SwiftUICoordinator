//
//  TransitionProvidable.swift
//
//
//  Created by Erik Drobne on 12. 10. 23.
//

import Foundation

@MainActor
public protocol TransitionProvidable {
    /// An array of transitions wrapped in weak references.
    var transitions: [WeakTransition] { get }
}
