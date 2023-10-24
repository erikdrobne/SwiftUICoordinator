import XCTest
import Foundation
@testable import SwiftUICoordinator

@MainActor 
final class CoordinatorTests: XCTestCase {
    
    func test_coordinatorInitialState() {
        let navigationController = NavigationController()
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: navigationController)
        XCTAssertNil(sut.parent)
        XCTAssertTrue(sut.childCoordinators.isEmpty)
    }
    
    func test_addChildCoordinator() {
        let navigationController = NavigationController()
        let sut = MockAppCoordinator(window: UIWindow(), navigationController: navigationController)
        let coordinator = MockCoordinator(parent: sut, startRoute: .rectangle, navigationController: navigationController)
        
        sut.start(with: coordinator)
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.coordinator === coordinator)
    }
    
    func test_addMultipleChildrenToCoordinator() {
        let navigationController = NavigationController()
        let sut = MockAppCoordinator(window: UIWindow(), navigationController: navigationController)
        let coordinator = MockCoordinator(parent: sut, startRoute: .rectangle, navigationController: navigationController)
        
        sut.start(with: coordinator)
        sut.add(child: MockCoordinator(parent: coordinator, startRoute: .circle, navigationController: navigationController))
        
        XCTAssertEqual(sut.childCoordinators.count, 2)
        XCTAssert(sut.childCoordinators.first?.coordinator === coordinator)
    }
    
    func test_removeChildCoordinator() {
        let navigationController = NavigationController()
        let sut = MockAppCoordinator(window: UIWindow(), navigationController: navigationController)
        let coordinator = MockCoordinator(parent: sut, startRoute: .rectangle, navigationController: navigationController)
        
        sut.start(with: coordinator)
        sut.remove(coordinator: coordinator)
        
        XCTAssertTrue(sut.childCoordinators.isEmpty)
    }
    
    func test_coordinatorDoesNotRetainChildCoordinators() {
        let navigationController = NavigationController()
        let parentCoordinator = MockAppCoordinator(window: UIWindow(), navigationController: navigationController)
        var childCoordinator: Coordinator? = MockCoordinator(parent: parentCoordinator, startRoute: .rectangle, navigationController: navigationController)
        parentCoordinator.add(child: childCoordinator!)
        
        XCTAssertNotNil(parentCoordinator.childCoordinators.first?.coordinator)
        childCoordinator = nil
        XCTAssertNil(parentCoordinator.childCoordinators.first?.coordinator)
    }

    
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
