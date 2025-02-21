//
//  NavigatorError.swift
//  
//
//  Created by Erik Drobne on 30/04/2023.
//

@MainActor
public enum NavigatorError: Error {
    case cannotShow(NavigationRoute)
}
