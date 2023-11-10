//
//  SceneDelegate.swift
//  FilmsList
//
//  Created by Maksim Zenkov on 26.10.2023.
//

import UIKit
import CoreUI
import SwiftUI
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private var cancellable: AnyCancellable?

    var window: UIWindow?
    
    let authService = screenFactory.appFactory.authService

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
        
        updateRootViewController(isAuthorized: authService.isAuthorized)
        
        cancellable = authService.isAuthorizedPublisher.dropFirst().sink { isAuthorized in
            self.updateRootViewController(isAuthorized: isAuthorized)
        }
    }
    
    private func updateRootViewController(isAuthorized: Bool) {
        guard let window else {
            fatalError("Main window not found!")
        }
        
        let initialView: AnyView
        
        if isAuthorized {
            initialView = AnyView(screenFactory.mainView())
        } else {
            initialView = AnyView(screenFactory.loginView())
        }
        
        let initialViewController = NavigationController(
            rootViewController: HostingController(rootView: initialView)
        )
        
        window.rootViewController = initialViewController
    }
}


