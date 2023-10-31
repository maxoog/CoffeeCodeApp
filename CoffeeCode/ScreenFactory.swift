// MARK: - screen factory как описана женей ёлчевым в
// https://www.youtube.com/watch?v=fTbiOzOrsRo

import SwiftUI
import Combine

let screenFactory = ScreenFactory()

final class ScreenFactory {
    let appFactory = AppFactory()
    
    func mainView() -> some View {
        MainView()
    }

    func loginView(onSuccess: (() -> Void)? = nil) -> some View {
        let viewModel = LoginViewModel(authService: appFactory.authService, onAuth: onAuth)
        
        return LoginView(viewModel: viewModel)
    }
}

fileprivate final class AppFactory {
    fileprivate let client = Client()
    
    lazy var authService = {
        return AuthService(client: client)
    }()
}


