//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=CErrxmo4ZWgSY0wH8AbSiRp37EvKXSx82qw7Q6PQ")!

let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let data = data {
        let string = String(data: data, encoding: .utf8)
        print(string!)
    }
}

task.resume()

let queries = ["api_key":"CErrxmo4ZWgSY0wH8AbSiRp37EvKXSx82qw7Q6PQ"]
queries.compactMap({ (key, value) -> URLQueryItem in
    return URLQueryItem(name: key, value: value)
})
