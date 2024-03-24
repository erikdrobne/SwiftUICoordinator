//
//  NavigatorTests.swift
//
//
//  Created by Erik Drobne on 24. 10. 23.
//

import XCTest
import Foundation
@testable import SwiftUICoordinator

final class NavigatorTests: XCTestCase {
        
    @MainActor
    func test_showRouteThrowsError() {
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: NavigationController())
        XCTAssertNoThrow(try sut.start())
        
        XCTAssertThrowsError(try sut.show(route: .square)) { error in
            guard let error = error as? NavigatorError else {
                XCTFail("Cannot cast to NavigatorError: \(error)")
                return
            }
            
            switch error {
            case .cannotShow(let route as MockRoute):
                XCTAssertEqual(route, .square)
            default:
                XCTFail("Unexpected error type: \(error)")
            }
        }
    }
    
    @MainActor
    func test_showRouteNoThrow() {
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: NavigationController())
        XCTAssertNoThrow(try sut.start())
    }
    
    @MainActor
    func test_setRoutes() {
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: NavigationController())
        sut.set(routes: [.rectangle, .rectangle])
        XCTAssertEqual(sut.viewControllers.count, 2)
    }
    
    @MainActor
    func test_appendRoutes() {
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: NavigationController())
        sut.append(routes: [.rectangle, .circle])
        XCTAssertEqual(sut.viewControllers.count, 2)
    }
    
    @MainActor
    func test_popToRoot() {
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: NavigationController())
        sut.append(routes: [.rectangle, .circle])
        XCTAssertEqual(sut.viewControllers.count, 2)
        sut.popToRoot(animated: false)
        XCTAssertEqual(sut.viewControllers.count, 1)
    }
}
