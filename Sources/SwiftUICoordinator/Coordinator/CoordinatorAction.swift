//
//  CoordinatorAction.swift
//  
//
//  Created by Erik Drobne on 23/07/2023.
//

import Foundation

public protocol CoordinatorAction {}

/// Essential actions that can be performed by coordinators.
public enum Action: CoordinatorAction {
    case done(Any)
    case cancel(Any)
}
