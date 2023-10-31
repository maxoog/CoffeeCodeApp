import Combine
import Alamofire
import FirebaseAuth

class AuthService: NSObject, ObservableObject {
    private let client: Client
    
    var isAuthorized: Bool {
        return client.isAuthorized
    }
    
    lazy var isAuthorizedPublisher: AnyPublisher = {
        return client.isAuthorizedPublisher.eraseToAnyPublisher()
    }()
    
    init(client: Client) {
        self.client = client
    }
    
    @MainActor
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            assertionFailure("всё очень очень очень хуёво")
        }
        client.authToken = nil
        objectWillChange.send()
    }
    
    @MainActor
    func login(token: String) async {
        self.client.authToken = token
        objectWillChange.send()
    }
}

