//
//  File.swift
//  
//
//  Created by Erik Drobne on 23/09/2023.
//

import Foundation
import XCTest
@testable import SwiftUICoordinator

final class NavigationControllerTests: XCTestCase {

    @MainActor
    func test_navigationBarIsHiddenByDefault() {
        let sut = NavigationController()
        XCTAssertTrue(sut.isNavigationBarHidden)
    }

    @MainActor
    func test_navigationBarIsNotHidden() {
        let sut = NavigationController(isNavigationBarHidden: false)
        XCTAssertFalse(sut.isNavigationBarHidden)
    }
}
