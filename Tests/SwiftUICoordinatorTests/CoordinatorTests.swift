import XCTest
import Foundation
@testable import SwiftUICoordinator

final class CoordinatorTests: XCTestCase {
    @MainActor
    func test_coordinatorInitialState() {
        let navigationController = NavigationController()
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: navigationController)
        XCTAssertNil(sut.parent)
        XCTAssertTrue(sut.childCoordinators.isEmpty)
    }

    @MainActor
    func test_addChildCoordinator() {
        let navigationController = NavigationController()
        let sut = MockAppCoordinator(window: UIWindow(), navigationController: navigationController)
        let coordinator = MockCoordinator(
            parent: sut,
            startRoute: .rectangle,
            navigationController: navigationController
        )

        sut.start(with: coordinator)
        XCTAssertEqual(sut.childCoordinators.count, 1)
        XCTAssert(sut.childCoordinators.first?.coordinator === coordinator)
    }

    @MainActor
    func test_addMultipleChildrenToCoordinator() {
        let navigationController = NavigationController()
        let sut = MockAppCoordinator(window: UIWindow(), navigationController: navigationController)
        let coordinator = MockCoordinator(
            parent: sut,
            startRoute: .rectangle,
            navigationController: navigationController
        )

        sut.start(with: coordinator)
        sut.add(
            child: MockCoordinator(
                parent: coordinator,
                startRoute: .circle,
                navigationController: navigationController
            )
        )

        XCTAssertEqual(sut.childCoordinators.count, 2)
        XCTAssert(sut.childCoordinators.first?.coordinator === coordinator)
    }

    @MainActor
    func test_removeChildCoordinator() {
        let navigationController = NavigationController()
        let sut = MockAppCoordinator(window: UIWindow(), navigationController: navigationController)
        let coordinator = MockCoordinator(
            parent: sut,
            startRoute: .rectangle,
            navigationController: navigationController
        )

        sut.start(with: coordinator)
        sut.remove(coordinator: coordinator)

        XCTAssertTrue(sut.childCoordinators.isEmpty)
    }

    @MainActor
    func test_coordinatorDoesNotRetainChildCoordinators() {
        let navigationController = NavigationController()
        let sut = MockAppCoordinator(window: UIWindow(), navigationController: navigationController)
        var childCoordinator: Coordinator? = MockCoordinator(
            parent: sut,
            startRoute: .rectangle,
            navigationController: navigationController
        )

        sut.add(child: childCoordinator!)
        XCTAssertNotNil(sut.childCoordinators.first?.coordinator)
        childCoordinator = nil
        XCTAssertNil(sut.childCoordinators.first?.coordinator)
    }
}
