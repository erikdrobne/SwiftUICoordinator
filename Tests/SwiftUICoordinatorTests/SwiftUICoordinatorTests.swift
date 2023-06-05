import XCTest
import SwiftUI
@testable import SwiftUICoordinator

@MainActor final class SwiftUICoordinatorTests: XCTestCase {
    
    func testAddChildToCoordinator() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        let childCoordinator = MockCoordinator(parent: rootCoordinator, startRoute: .rectangle)
        
        rootCoordinator.add(child: childCoordinator)
        rootCoordinator.add(child: childCoordinator)
        
        XCTAssertEqual(rootCoordinator.childCoordinators.count, 1)
    }
    
    func testFinishChildCoordinator() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        let childCoordinator = MockCoordinator(parent: rootCoordinator, startRoute: .rectangle)
        
        rootCoordinator.add(child: childCoordinator)
        childCoordinator.finish()
        
        XCTAssertEqual(rootCoordinator.childCoordinators.count, 0)
    }
    
    func testShowRouteThrowsError() {
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
    
    func testShowRouteNoThrow() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        XCTAssertNoThrow(try rootCoordinator.start())
    }
    
    func testSetRoutesSuccess() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        rootCoordinator.set(routes: [.rectangle, .rectangle])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
    }
    
    func testAppendRoutesSuccess() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        rootCoordinator.append(routes: [.rectangle, .circle])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
    }
    
    func testPopToRootSuccess() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .circle)
        rootCoordinator.append(routes: [.rectangle, .circle])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
        rootCoordinator.popToRoot(animated: false)
        XCTAssertEqual(rootCoordinator.viewControllers.count, 1)
    }
    
    func testRegisterTransitionSuccess() {
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
}
