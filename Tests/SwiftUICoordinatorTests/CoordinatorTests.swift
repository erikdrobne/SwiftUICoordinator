import Testing
@testable import SwiftUICoordinator

@MainActor
@Suite("Coordinator Tests") struct CoordinatorTests {
    
    @Test func testParentHasNoChildCoordinatorsInitially() {
        // Arrange
        let navigationController = NavigationController()
        let parentCoordinator: MockCoordinator = .init(
            startRoute: .circle,
            navigationController: navigationController
        )
        
        // Act / Assert
        #expect(
            parentCoordinator.childCoordinators.isEmpty,
            "Parent coordinator should initially have no child coordinators."
        )
    }

    @Test func testAddChildCoordinator() {
        // Arrange
        let navigationController = NavigationController()
        let parentCoordinator: MockCoordinator = .init(
            startRoute: .circle,
            navigationController: navigationController
        )
        let initialCount = parentCoordinator.childCoordinators.count
        
        // Act
        let childCoordinator = MockCoordinator(
            startRoute: .square,
            navigationController: navigationController
        )
        parentCoordinator.add(child: childCoordinator)
        
        // Assert
        #expect(
            parentCoordinator.childCoordinators.count == initialCount + 1,
            "Child coordinator should be added."
        )
        #expect(
            parentCoordinator.childCoordinators.contains { $0 === childCoordinator },
            "Child coordinator should be in the list.")
    }
    
    @Test func testAddSameChildCoordinatorTwice() {
        // Arrange
        let navigationController = NavigationController()
        let parentCoordinator: MockCoordinator = .init(
            startRoute: .circle,
            navigationController: navigationController
        )
        let childCoordinator = MockCoordinator(
            startRoute: .square,
            navigationController: navigationController
        )
        
        // Act
        parentCoordinator.add(child: childCoordinator)
        parentCoordinator.add(child: childCoordinator)
        
        // Assert
        #expect(
            parentCoordinator.childCoordinators.count == 1,
            "Same child coordinator should not be added twice."
        )
    }
    
    @Test func testRemoveChildCoordinator() {
        // Arrange
        let navigationController = NavigationController()
        let parentCoordinator: MockCoordinator = .init(
            startRoute: .circle,
            navigationController: navigationController
        )
        let childCoordinator = MockCoordinator(
            startRoute: .square,
            navigationController: navigationController
        )
        
        // Act
        parentCoordinator.remove(coordinator: childCoordinator)
        
        // Assert
        #expect(
            parentCoordinator.childCoordinators.count == 0,
            "Child coordinator should be removed."
        )
        #expect(
            parentCoordinator.childCoordinators.contains { $0 === childCoordinator } == false,
            "Child coordinator should not be in the list."
        )
    }
}
