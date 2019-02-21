//
//  NetworkingRWViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 2/18/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class NetworkingRWViewController: UIViewController, URLSessionDataDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let json = """
            {
                "hello": "world"
            }
        """
        
        let url = URL(string: "https://httpbin.org/post")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = json.data(using: .utf8)
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.current)
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            
            if let data = data, let stringData = String(data: data, encoding: .utf8) {
                print(stringData)
            }
            
        }.resume()
        
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let progess = round(Float(totalBytesSent) / Float(totalBytesExpectedToSend)) * 100
        print(progess)
    }

}
