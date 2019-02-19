//
//  NetworkingRWViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 2/18/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class NetworkingRWViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        
        let session = URLSession(configuration: configuration)
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        let task = session.dataTask(with: url) {data, response, error in
            
            if error != nil {
                print("An error has occured \(error?.localizedDescription ?? "Error")")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return }
            guard let data = data, let textData = String(data: data, encoding: .utf8) else { return }
            
            print(textData)
        }
        
        task.resume()
        
    }

}
