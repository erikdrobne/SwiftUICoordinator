//
//  File.swift
//  
//
//  Created by Erik Drobne on 23/09/2023.
//

import Foundation

import Foundation
import XCTest
@testable import SwiftUICoordinator

@MainActor
final class NavigationControllerTests: XCTestCase {
    
    func testNavigationBarIsHiddenByDefault() {
        let navigationController = NavigationController()
        XCTAssertTrue(navigationController.isNavigationBarHidden)
    }
    
    func testNavigationBarIsNotHidden() {
        let navigationController = NavigationController(isNavigationBarHidden: false)
        XCTAssertFalse(navigationController.isNavigationBarHidden)
    }
}
