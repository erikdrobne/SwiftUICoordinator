//
//  TransitionProvidable.swift
//
//
//  Created by Erik Drobne on 12. 10. 23.
//

import Foundation

@MainActor
public protocol TransitionProvidable {
    var transitions: [Transitionable] { get }
}
