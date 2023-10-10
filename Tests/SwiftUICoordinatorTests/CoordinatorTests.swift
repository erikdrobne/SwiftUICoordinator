import XCTest
import Foundation
@testable import SwiftUICoordinator

@MainActor 
final class CoordinatorTests: XCTestCase {
    
    func test_AddChildToCoordinator() {
        let appCoordinator = MockAppCoordinator(window: UIWindow(), navigationController: NavigationController())
        let coordinator = MockCoordinator(parent: appCoordinator, startRoute: .rectangle)
        
        appCoordinator.start(with: coordinator)
        XCTAssertEqual(appCoordinator.childCoordinators.count, 1)
    }
    
    func test_AddMultipleChildrenToCoordinator() {
        let appCoordinator = MockAppCoordinator(window: UIWindow(), navigationController: NavigationController())
        let coordinator = MockCoordinator(parent: appCoordinator, startRoute: .rectangle)
        
        appCoordinator.start(with: coordinator)
        appCoordinator.add(child: MockCoordinator(parent: coordinator, startRoute: .circle))
        
        XCTAssertEqual(appCoordinator.childCoordinators.count, 2)
    }
    
    func test_RemoveChildCoordinator() {
        let appCoordinator = MockAppCoordinator(window: UIWindow(), navigationController: NavigationController())
        let coordinator = MockCoordinator(parent: appCoordinator, startRoute: .rectangle)
        
        appCoordinator.start(with: coordinator)
        appCoordinator.remove(coordinator: coordinator)
        
        XCTAssertEqual(appCoordinator.childCoordinators.count, 0)
    }
    
    func test_ShowRouteThrowsError() {
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
    
    func test_ShowRouteNoThrow() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        XCTAssertNoThrow(try rootCoordinator.start())
    }
    
    func test_SetRoutes() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        rootCoordinator.set(routes: [.rectangle, .rectangle])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
    }
    
    func test_AppendRoutes() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        rootCoordinator.append(routes: [.rectangle, .circle])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
    }
    
    func test_PopToRoot() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        rootCoordinator.append(routes: [.rectangle, .circle])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
        rootCoordinator.popToRoot(animated: false)
        XCTAssertEqual(rootCoordinator.viewControllers.count, 1)
    }
    
    func test_RegisterTransition() {
        let coordinator = MockCoordinator(parent: nil, startRoute: .circle)
        let transitions = [MockTransition()]
        
        coordinator.navigationController.register(transitions)
        
        guard let mockTransition = coordinator.navigationController.transitions[0].transition as? MockTransition else {
            XCTFail("Cannot cast to MockTransition.")
            return
        }
        
        XCTAssertEqual(mockTransition, transitions[0])
    }
    
    func test_unregisterTransition() {
        let coordinator = MockCoordinator(parent: nil, startRoute: .circle)
        let transitions = [MockTransition(), MockTransition()]
        coordinator.navigationController.register(transitions)
        XCTAssertEqual(coordinator.navigationController.transitions.count, 2)
        
        coordinator.navigationController.unregister(MockTransition.self)
        XCTAssertEqual(coordinator.navigationController.transitions.count, 0)
    }
    
    func test_NavigationBarIsHidden() {
        let coordinator = MockCoordinator(parent: nil, startRoute: .circle)
        coordinator.append(routes: [MockRoute.rectangle, MockRoute.circle])
        XCTAssertTrue(coordinator.navigationController.isNavigationBarHidden)
    }
    
    func test_NavigationBarIsNotHidden() {
        let coordinator = MockCoordinator(parent: nil, startRoute: .circle)
        coordinator.append(routes: [MockRoute.circle, MockRoute.rectangle])
        XCTAssertFalse(coordinator.navigationController.isNavigationBarHidden)
    }
}
