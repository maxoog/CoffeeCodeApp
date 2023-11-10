// MARK: - screen factory как описана женей ёлчевым в
// https://www.youtube.com/watch?v=fTbiOzOrsRo

import SwiftUI
import Combine

let screenFactory = ScreenFactory()

final class ScreenFactory {
    let appFactory = AppFactory()
    
    func mainView() -> some View {
        MainView(authService: appFactory.authService)
    }

    func loginView(onSuccess: (() -> Void)? = nil) -> some View {
        let viewModel = LoginViewModel(authService: appFactory.authService, onAuth: onSuccess)
        
        return LoginView(viewModel: viewModel)
    }
    
    func scannerView() -> some View {
        return InvoiceScannerView()
    }
}

final class AppFactory {
    fileprivate let client = Client()
    
    lazy var authService = {
        return AuthService(client: client)
    }()
}


