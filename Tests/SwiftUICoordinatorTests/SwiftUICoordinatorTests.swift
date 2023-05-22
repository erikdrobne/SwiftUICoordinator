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
        EmptyView()
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
        return .push(animated: true)
    }
}
