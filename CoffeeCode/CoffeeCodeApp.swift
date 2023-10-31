//
//  CoffeeCodeApp.swift
//  CoffeeCode
//
//  Created by Maksim Zenkov on 27.10.2023.
//

import SwiftUI

@main
struct CoffeeCodeApp: App {
    @ObservedObject var authService = screenFactory.appFactory.authService
    
    var body: some Scene {
        WindowGroup {
            if authService.isAuthorized {
                screenFactory.mainView()
            } else {
                screenFactory.loginView()
            }
        }
    }
}
