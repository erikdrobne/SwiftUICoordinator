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
    case done(Any)
    case cancel(Any)
}
