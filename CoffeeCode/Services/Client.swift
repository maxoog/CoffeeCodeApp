import Combine
import Alamofire
import Foundation
import Core

class Client {
    lazy var session: Session = {
        return Session(interceptor: RequestInterceptor(token: authToken))
    }()
    
    private let tokenStorage = SecureStorage()
    
    lazy var isAuthorizedPublisher: CurrentValueSubject<Bool, Never> = {
        return .init(isAuthorized)
    }()
    
    @Token
    var authToken: String? {
        didSet {
            isAuthorizedPublisher.send(authToken != nil)
        }
    }
    
    var isAuthorized: Bool {
        authToken != nil
    }
}

final class RequestInterceptor: Alamofire.RequestInterceptor {
    private let token: String?
    
    init(token: String?) {
        self.token = token
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest

        if let token = token {
            urlRequest.setValue(token, forHTTPHeaderField: "access-token")
        }

        completion(.success(urlRequest))
    }
}



