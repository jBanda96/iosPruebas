import Foundation

public struct GoogleUser {
    public var email: String
    public var password: String
    public var token: String
}

public struct User {
    public let email: String
    public let password: String
}

public struct Token {
    public let value: String
}

public class GoogleAuthenticator {
    public func login(email: String, password: String, completion: @escaping (GoogleUser?, Error?) -> Void) {
        let token = "special-token-value"
        
        let user = GoogleUser(email: email, password: password, token: token)
        completion(user, nil)
    }
}


public protocol AuthenticationService {
    func login(email: String, password: String, success: @escaping (User, Token) -> Void, failure: @escaping (Error?) -> Void)
}

public class GoogleAuthenticatorAdapter: AuthenticationService {
    private var authenticator = GoogleAuthenticator()
    
    public func login(email: String, password: String, success: @escaping (User, Token) -> Void, failure: @escaping (Error?) -> Void) {
        
        authenticator.login(email: email, password: password) { (googleUser, error) in
            guard let googleUser  = googleUser else { failure(error); return }
            
            let user = User(email: googleUser.email, password: googleUser.password)
            let token = Token(value: googleUser.token)
            success(user, token)
        }
        
    }
}


var authService = GoogleAuthenticatorAdapter()
authService.login(email: "user@example.com", password: "password",
                  success: { (user, token) in
                    print("Auth succeeded: \(user.email), \(token.value)")
},
                  failure: { (error) in
                    print("Auth failed with error: \(error?.localizedDescription ?? "")")
})
