import XCTest
import SwiftUI
@testable import SwiftUICoordinator

final class SwiftUICoordinatorTests: XCTestCase {
    
    @MainActor func testAddChildToCoordinator() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        let childCoordinator = MockCoordinator(parent: rootCoordinator, startRoute: .rectangle)
        
        rootCoordinator.add(child: childCoordinator)
        rootCoordinator.add(child: childCoordinator)
        
        XCTAssertEqual(rootCoordinator.childCoordinators.count, 1)
    }
    
    @MainActor func testFinishChildCoordinator() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        let childCoordinator = MockCoordinator(parent: rootCoordinator, startRoute: .rectangle)
        
        rootCoordinator.add(child: childCoordinator)
        childCoordinator.finish()
        
        XCTAssertEqual(rootCoordinator.childCoordinators.count, 0)
    }
    
    @MainActor func testShowRouteThrowsError() {
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
    
    @MainActor func testShowRouteNoThrow() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        XCTAssertNoThrow(try rootCoordinator.start())
    }
    
    @MainActor func testSetRoutesSuccess() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        rootCoordinator.set(routes: [.rectangle, .rectangle])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
    }
    
    @MainActor func testAppendRoutesSuccess() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        rootCoordinator.append(routes: [.rectangle, .circle])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
    }
    
    @MainActor func testPopToRootSuccess() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        rootCoordinator.append(routes: [.rectangle, .circle])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
        rootCoordinator.popToRoot(animated: false)
        XCTAssertEqual(rootCoordinator.viewControllers.count, 1)
    }
    
    @MainActor func testRegisterTransitionSuccess() {
        let coordinator = MockCoordinator(parent: nil, startRoute: .circle)
        let transitions = [MockTransition()]
        
        coordinator.navigationController.register(transitions)
        
        for (index, item) in coordinator.navigationController.transitions.enumerated() {
            guard let mockTransition = item as? MockTransition else {
                XCTFail("Cannot cast to MockTransition.")
                return
            }
            
            XCTAssertEqual(mockTransition, transitions[index])
        }
    }
    
    @MainActor func testRoutePropertiesAreCorrect() {
        let route = MockRoute.circle
        XCTAssertEqual(route.title, "Circle")
    }
}
