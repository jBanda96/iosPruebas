
//: ### Network Operations
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct RandomAPI: Codable {
    let results: [Contact]
}

struct Contact: Codable {
    let gender: String
    let email: String
}

struct PokeAll: Codable {
    let count: Int
    let results: [Pokemons]
}

struct Pokemons: Codable {
    let name: String
}

struct Pokemon: Codable {
    let name: String
    let height: Int
    let weight: Int
}

enum Endpoint {
    case randomUser
    case allPokemon
    case byPokemon
    
    var path: String {
        switch self {
        case .randomUser:
            return "https://randomuser.me/api"
            
        case .allPokemon:
            return "https://pokeapi.co/api/v2/pokemon"
            
        case .byPokemon:
            return "https://pokeapi.co/api/v2/pokemon/pikachu"
        }
    }
    
}

func createGETRequest(url: URL) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    return request
}

func doGenericGETRequest<T: Codable>(to endpoint: Endpoint, ofType: T.Type?, completionHandler: @escaping (T?, Swift.Error?) -> Void) {
    
    guard let url               =   URL(string: endpoint.path) else { return }
    
    let request: URLRequest     =   createGETRequest(url: url)
    let session                 =   URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        if let error = error {
            completionHandler(nil, error)
            return
        }
        
        do {
            let jsonDecoder = JSONDecoder()
            
            let object = try jsonDecoder.decode(T.self, from: data!)
            completionHandler(object, nil)
        } catch {
            completionHandler(nil, error)
        }
        
        
    }
    
    session.resume()
}

doGenericGETRequest(to: .randomUser, ofType: RandomAPI.self) { (users, error) in
    print("\n\n---------------- Generic Request - Random User ----------------")
    
    print(error ?? "")
    print(users ?? "")
    
}

doGenericGETRequest(to: .byPokemon, ofType: Pokemon.self) { (pokemon, error) in
    print("\n\n---------------- Generic Request - Pokemon ----------------")
    
    print(pokemon ?? "")
    print(error ?? "")
}
