//
//  SwiftUICoordinatorExampleApp.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 22/02/2023.
//

import SwiftUI

@main
struct SwiftUICoordinatorExampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {

        }
    }
}

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

    private let dependencyContainer = DependencyContainer.shared
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let window = (scene as? UIWindowScene)?.windows.first else {
            return
        }
        
        let coordinator = dependencyContainer.rootCoordinator
        /// Assign root coordinator's navigation controller
        window.rootViewController = coordinator.navigationController
        window.makeKeyAndVisible()

        try? coordinator.start()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            guard 
                let deepLink = try? dependencyContainer.deepLinkHandler.link(for: url),
                let params = try? dependencyContainer.deepLinkHandler.params(for: url, and: deepLink.params)
            else {
                return
            }
            
            dependencyContainer.rootCoordinator.handle(deepLink, with: params)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}
