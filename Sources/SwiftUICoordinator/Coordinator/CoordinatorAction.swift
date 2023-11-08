//
//  CoordinatorAction.swift
//  
//
//  Created by Erik Drobne on 23/07/2023.
//

import Foundation

/// A protocol that defines coordinator actions.
public protocol CoordinatorAction {}

public enum Action: CoordinatorAction {
    /// Indicates a successful completion with an associated value.
    case done(Any)
    /// Indicates cancellation with an associated value.
    case cancel(Any)
}
