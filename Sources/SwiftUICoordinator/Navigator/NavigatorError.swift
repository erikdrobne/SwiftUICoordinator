//
//  NavigatorError.swift
//  
//
//  Created by Erik Drobne on 30/04/2023.
//

public enum NavigatorError: Error {
    case startRouteMissing
    case cannotShow(NavigationRoute)
}
