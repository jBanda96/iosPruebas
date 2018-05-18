//
//  Connections.swift
//  Pruebas
//
//  Created by Julio Banda on 13/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation

class Connections {
    
    class func downloadPerPage(num: Int, completion: @escaping (Responser) -> ()) {
        
        let url = URL(string: "https://randomuser.me/api/?page=\(num)&results=10&seed=julioykrys")
        let session = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            completion(try! JSONDecoder().decode(Responser.self, from: data!))
            
        }
        
        session.resume()
        
    }
    
}
