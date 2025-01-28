//
//  File.swift
//  
//
//  Created by Erik Drobne on 10. 10. 23.
//

import Foundation
import SwiftUICoordinator

final class MockAppCoordinator: RootCoordinator {

    func start(with coordinator: any Routing) {
        self.add(child: coordinator)
        try? coordinator.start()
    }

    override func handle(_ action: CoordinatorAction) {
        fatalError("Unhadled coordinator action.")
    }
}
