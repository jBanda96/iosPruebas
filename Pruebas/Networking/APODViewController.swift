//
//  APODViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 25/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class APODViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        explanationLabel.text = ""
        copyrightLabel.text = ""
        
        PhotoInfo.createRequestToNAsaApi { (fetchedInfo) in
            DispatchQueue.main.async {
                self.updateUI(with: fetchedInfo)
            }
        }
    }
    
    private func updateUI(with photoInfo: PhotoInfo?) {
        if let photoInfo = photoInfo {
            
            let imageURL = URL(string: photoInfo.url)
            let dataImage = try! Data(contentsOf: imageURL!)
            
            image.image = UIImage(data: dataImage)
            
            self.title = photoInfo.title
            self.explanationLabel.text = photoInfo.explanation
            
            if let copyright = photoInfo.copyright {
                self.copyrightLabel.text = copyright
            } else {
                copyrightLabel.isHidden = true
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

}

struct PhotoInfo: Codable {
    
    let title: String
    let explanation: String
    let url: String
    let copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case explanation
        case url
        case copyright
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.explanation = try valueContainer.decode(String.self, forKey: CodingKeys.explanation)
        self.url = try valueContainer.decode(String.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
    }
    
    static func createRequestToNAsaApi(completion: @escaping (PhotoInfo?) -> Void) {
        if let url = URL(string: "https://api.nasa.gov/planetary/apod")?.withQueries(["api_key":"CErrxmo4ZWgSY0wH8AbSiRp37EvKXSx82qw7Q6PQ"]) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                if let data = data, let photo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                    completion(photo)
                } else {
                    completion(nil)
                }
            }
            task.resume()
        }
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL?{
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap({ (key, value) -> URLQueryItem in
            return URLQueryItem(name: key, value: value)
        })
        
        return components?.url
    }
}
