//
//  StrategyViewController.swift
//  Pruebas
//
//  Created by Banda Castillo Julio on 3/29/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

enum APIResponse {
    case success(rating: String, review: String)
    case error
}

// MARK: Strategy Protocol
private protocol MovieRatingStrategy: class {
    var ratingServiceName: String { get }
    
    func fetchRating(for movie: String,
                     response: @escaping ((APIResponse) -> Void) )
}



// MARK: Families
class RottenTomatoesClient: MovieRatingStrategy {
    var ratingServiceName: String {
        return "Rotten Tomatoes"
    }
    
   func fetchRating(for movie: String, response: (APIResponse) -> Void) {
        response(.success(rating: "78",
                      review: "With a fresh perspective, some new friends, and loads of fast-paced action, Birds of Prey captures the colorfully anarchic spirit of Margot Robbie's Harley Quinn."))
   }
}

class OMDbClient: MovieRatingStrategy {
    
    // API KEY: 57ae7717
    var ratingServiceName: String {
        return "OMDb"
    }
    
    func fetchRating(for movie: String, response: @escaping ((APIResponse) -> Void)) {
        Networking.requestOMDb(for: movie, response: response)
    }
}

class ChickenCoopClient: MovieRatingStrategy {
    var ratingServiceName: String {
        return "Chicken Coop"
    }
    
    func fetchRating(for movie: String, response: @escaping ((APIResponse) -> Void)) {
        Networking.requestChickenCoop(for: movie, response: response)
    }
}


// MARK: Main View Controller
class StrategyViewController: UIViewController {
    
    @IBOutlet weak var searchMovieTextField: UITextField!
    
    @IBOutlet weak var strategyNameLabel: UILabel!
    @IBOutlet weak var strategyRatingLabel: UILabel!
    @IBOutlet weak var strategyReviewLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var strategy: MovieRatingStrategy!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strategy = OMDbClient()

        strategyNameLabel.text = strategy.ratingServiceName
    }
    
    @IBAction func didSelectStrategy(_ control: UISegmentedControl) {
        switch control.selectedSegmentIndex {
        case 0:
            strategy = RottenTomatoesClient()
        case 1:
            strategy = OMDbClient()
            
        case 2:
            strategy = ChickenCoopClient()
        default:
            return
        }
        
        strategyNameLabel.text = strategy.ratingServiceName
    }
    
}

extension StrategyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let movie = textField.text {
            
            self.activityIndicator.startAnimating()
            strategy.fetchRating(for: movie) { [weak self] response in
                
                defer {
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopAnimating()
                    }
                }
                
                switch response {
                case .error:
                    return
                    
                case .success(let rating, let review):
                    DispatchQueue.main.async {
                        self?.strategyRatingLabel.text = rating
                        self?.strategyReviewLabel.text = review
                    }
                }
            }
        }
        return true
    }
}




// MARK: Networking
class Networking {
    
    private enum API {
        case OMDb
        case ChickenCoop
    }
    
    private init() {}
    
    class func requestOMDb(for movie: String, response: @escaping ((APIResponse) -> Void)) {
        guard let url = getURL(to: .OMDb, with: ["t": movie]) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let _ = error {
                response(.error)
                return
            }
            
            if let data = data {
                
                 do {
                    let omdb = try JSONDecoder().decode(OMDb.self, from: data)
                    if let rating = omdb.imdbRating, let review = omdb.plot {
                        response(.success(rating: rating, review: review))
                    } else {
                        response(.error)
                    }
                    
                } catch {
                    response(.error)
                }
                
            } else {
                response(.error)
            }
            
        }.resume()
    }
    
    class func requestChickenCoop(for game: String, response: @escaping ((APIResponse) -> Void)) {
        guard let url = getURL(to: .ChickenCoop, with: ["title": game]) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let _ = error {
                response(.error)
                return
            }
            
            if let data = data {
                
                 do {
                    let chicken = try JSONDecoder().decode(ChickenCoop.self, from: data)
                    let random = Int(arc4random_uniform(4) + 7)
                    
                    response(.success(rating: String(random), review: chicken.result.first!.title))
                    
                } catch {
                    response(.error)
                }
                
            } else {
                response(.error)
            }
            
        }.resume()
    }
    
    private class func getURL(to api: API, with parameters: [String: String]? = nil) -> URL? {
        switch api {
        case .OMDb:
            var urlComponents   =   URLComponents(string: "http://www.omdbapi.com")
            var queryItems      =   [URLQueryItem(name: "apikey", value: "57ae7717")]
            
            parameters?.forEach {
                queryItems.append(URLQueryItem(name: $0.key, value: $0.value))
            }
            
            urlComponents?.queryItems = queryItems
            
            print("Requesting to: \(String(describing: urlComponents?.url))")
            return urlComponents?.url
            
        case .ChickenCoop:
            var urlComponents   =   URLComponents(string: "https://chicken-coop.fr/rest/games")
            var queryItems      =   [URLQueryItem]()
            
            parameters?.forEach {
                queryItems.append(URLQueryItem(name: $0.key, value: $0.value))
            }
            
            urlComponents?.queryItems = queryItems
            
            print("Requesting to: \(String(describing: urlComponents?.url))")
            return urlComponents?.url
        }
    }
    
}


// MARK: Reponse Data Classes
private struct OMDb: Codable {
    let title:      String?
    let plot:       String?
    let imdbRating: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case plot = "Plot"
        case imdbRating
    }
    
}

private struct ChickenCoop: Codable {
    let result: [ChickenGame]
}

private struct ChickenGame: Codable {
    let title: String
    let platform: String
}
