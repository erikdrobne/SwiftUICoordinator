//
//  AppCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 5. 10. 23.
//

import Foundation
import SwiftUICoordinator

final class AppCoordinator: RootCoordinator {

    func start(with coordinator: any Routing) {
        self.add(child: coordinator)
        try? coordinator.start()
    }

    func handle(_ action: CoordinatorAction) {
        fatalError("Unhadled coordinator action.")
    }
}

extension AppCoordinator: CoordinatorDeepLinkHandling {
    func handle(_ deepLink: SwiftUICoordinator.DeepLink, with params: [String: String]) {}
}
