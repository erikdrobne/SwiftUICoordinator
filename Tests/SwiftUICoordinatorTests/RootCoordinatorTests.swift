//
//  RootCoordinatorTests.swift
//  
//
//  Created by Erik Drobne on 10. 10. 23.
//

import XCTest
@testable import SwiftUICoordinator

@MainActor
final class RootCoordinatorTests: XCTestCase {

    func test_rootViewController() {
        let navigationController = NavigationController()
        let window = UIWindow()
        let sut = MockAppCoordinator(window: window, navigationController: navigationController)
        
        XCTAssertEqual(sut.window, window)
        XCTAssertTrue(sut.window.isKeyWindow)
        XCTAssertFalse(sut.window.isHidden)
        XCTAssertEqual(sut.window.rootViewController, navigationController)
    }
}
