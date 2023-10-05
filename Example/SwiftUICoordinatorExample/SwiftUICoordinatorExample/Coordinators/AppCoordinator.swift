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
        
        do {
            try coordinator.start()
        } catch {
            print("Start error: \(error.localizedDescription)")
        }
    }
    
    override func handle(_ action: CoordinatorAction) {
        fatalError("Unhadled coordinator action.")
    }
}
