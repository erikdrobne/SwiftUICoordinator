//
//  CoordinatorAction.swift
//  
//
//  Created by Erik Drobne on 23/07/2023.
//

import Foundation

public protocol CoordinatorAction {}

/// Essential actions.
public enum Action: CoordinatorAction {
    case done(Any)
    case cancel(Any)
}
