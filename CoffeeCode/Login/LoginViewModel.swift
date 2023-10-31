import SwiftUI

class LoginViewModel: ObservableObject {
    private let authService: AuthService
    let onAuth: (() -> Void)?
    
    init(authService: AuthService, onAuth: (() -> Void)? = nil) {
        self.onAuth = onAuth
        self.authService = authService
    }
    
    @Published var phNo = ""
    
    @Published var code = ""
    
    // Getting country Phone Code
    
    // DataModel For Error View
    @Published var errorMsg = ""
    @Published var error = false
    
    // storing CODE for verification
    @Published var CODE = ""
    
    @Published var gotoVerify = false
    
    // User Logged Status
    @AppStorage("log_Status") var status = false
    
    // Loading View
    @Published var loading = false
    
    func getCountryCode() -> String {
        "7"
    }
    
    // sending Code To User
    func sendCode() {

        // enabling testing code
        // disable when you need to test with real device
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let number = "+\(getCountryCode())\(phNo)"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in
            if let error = err {
                self.errorMsg = error.localizedDescription
                withAnimation {
                    self.error.toggle()
                }
                return
            }
            
            self.CODE = CODE ?? ""
            self.gotoVerify = true
        }
    }
    
    func verifyCode() {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        
        loading = true
        
        Auth.auth().signIn(with: credential) { (result, err) in
            self.loading = false
            
            if let error = err {
                self.errorMsg = error.localizedDescription
                
                withAnimation {
                    self.error.toggle()
                }
                return
            }
            
            // else, user logged in successfully
            withAnimation {
                result?.user.getIDToken(completion: { token, error in
                    guard let token else {
                        assertionFailure("token is not found")
                        return
                    }
                    Task { [weak self] in
                        guard let self else {
                            return
                        }
                        await self.authService.login(token: token)
                        self.onAuth?()
                    }
                })
            }
        }
    }
    
    func requestCode() {
        sendCode()
        withAnimation {
            self.errorMsg = "Код отправлен на ваш телефон."
            self.error.toggle()
        }
    }
}

