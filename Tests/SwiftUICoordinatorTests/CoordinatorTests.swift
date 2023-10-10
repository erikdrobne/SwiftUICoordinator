import XCTest
import Foundation
@testable import SwiftUICoordinator

@MainActor 
final class CoordinatorTests: XCTestCase {
    
    func test_addChildToCoordinator() {
        let sut = MockAppCoordinator(window: UIWindow(), navigationController: NavigationController())
        let coordinator = MockCoordinator(parent: sut, startRoute: .rectangle)
        
        sut.start(with: coordinator)
        XCTAssertEqual(sut.childCoordinators.count, 1)
    }
    
    func test_addMultipleChildrenToCoordinator() {
        let sut = MockAppCoordinator(window: UIWindow(), navigationController: NavigationController())
        let coordinator = MockCoordinator(parent: sut, startRoute: .rectangle)
        
        sut.start(with: coordinator)
        sut.add(child: MockCoordinator(parent: coordinator, startRoute: .circle))
        
        XCTAssertEqual(sut.childCoordinators.count, 2)
    }
    
    func test_removeChildCoordinator() {
        let sut = MockAppCoordinator(window: UIWindow(), navigationController: NavigationController())
        let coordinator = MockCoordinator(parent: sut, startRoute: .rectangle)
        
        sut.start(with: coordinator)
        sut.remove(coordinator: coordinator)
        
        XCTAssertEqual(sut.childCoordinators.count, 0)
    }
    
    func test_showRouteThrowsError() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        XCTAssertNoThrow(try rootCoordinator.start())
        
        XCTAssertThrowsError(try rootCoordinator.show(route: .square)) { error in
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
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        XCTAssertNoThrow(try rootCoordinator.start())
    }
    
    func test_setRoutes() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        rootCoordinator.set(routes: [.rectangle, .rectangle])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
    }
    
    func test_appendRoutes() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        rootCoordinator.append(routes: [.rectangle, .circle])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
    }
    
    func test_popToRoot() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        rootCoordinator.append(routes: [.rectangle, .circle])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
        rootCoordinator.popToRoot(animated: false)
        XCTAssertEqual(rootCoordinator.viewControllers.count, 1)
    }
    
    func test_navigationBarIsHidden() {
        let coordinator = MockCoordinator(parent: nil, startRoute: .circle)
        coordinator.append(routes: [MockRoute.rectangle, MockRoute.circle])
        XCTAssertTrue(coordinator.navigationController.isNavigationBarHidden)
    }
    
    func test_navigationBarIsNotHidden() {
        let coordinator = MockCoordinator(parent: nil, startRoute: .circle)
        coordinator.append(routes: [MockRoute.circle, MockRoute.rectangle])
        XCTAssertFalse(coordinator.navigationController.isNavigationBarHidden)
    }
}
