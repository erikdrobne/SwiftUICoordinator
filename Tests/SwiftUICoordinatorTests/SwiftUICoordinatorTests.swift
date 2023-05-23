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
                XCTFail("Unexpected error type: \(error)")
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
}

class MockCoordinator: NSObject, Coordinator, Navigator {
    var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: NavigationController
    let startRoute: MockRoute
    
    init(parent: Coordinator?, startRoute: MockRoute) {
        self.parent = parent
        self.navigationController = NavigationController()
        self.startRoute = startRoute
        super.init()
    }
    
    func navigate(to route: NavigationRoute) {
        
    }
}

extension MockCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: MockRoute) -> some View {
        switch route {
        case .rectangle, .circle:
            MockView()
        default:
            EmptyView()
        }
    }
}

enum MockRoute: NavigationRoute {
    case circle
    case rectangle
    case square
    
    var title: String? {
        switch self {
        case .circle:
            return "Circle"
        case .rectangle:
            return "Rectangle"
        case .square:
            return "Square"
        }
    }

    var action: TransitionAction? {
        switch self {
        case .square:
            return nil
        default:
            return .push(animated: true)
        }
    }
}

struct MockView: View {
    var body: some View {
        Text("Mock View")
    }
}
