//
//  NavigatorTests.swift
//
//
//  Created by Erik Drobne on 24. 10. 23.
//

import XCTest
import Foundation
@testable import SwiftUICoordinator

@MainActor
final class NavigatorTests: XCTestCase {
    
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
    
    func test_showRouteNoThrow() {
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: NavigationController())
        XCTAssertNoThrow(try sut.start())
    }
    
    func test_setRoutes() {
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: NavigationController())
        sut.set(routes: [.rectangle, .rectangle])
        XCTAssertEqual(sut.viewControllers.count, 2)
    }
    
    func test_appendRoutes() {
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: NavigationController())
        sut.append(routes: [.rectangle, .circle])
        XCTAssertEqual(sut.viewControllers.count, 2)
    }
    
    func test_popToRoot() {
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: NavigationController())
        sut.append(routes: [.rectangle, .circle])
        XCTAssertEqual(sut.viewControllers.count, 2)
        sut.popToRoot(animated: false)
        XCTAssertEqual(sut.viewControllers.count, 1)
    }
}
