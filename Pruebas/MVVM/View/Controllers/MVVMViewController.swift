//
//  MVVMViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/4/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit
import WebKit

class CountryCell: UICollectionViewCell, WKUIDelegate {
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var country: Country?
    
    func populate(country: Country?) {
        self.country = country
        
        self.flag.image = nil
        indicator.startAnimating()
        
        if let country = country {
            DispatchQueue.global(qos: .userInitiated).async {
                let urlFlag = URL(string: "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png")!
//                let imageFromData = try! Data(contentsOf: urlFlag)
                
                URLSession.shared.dataTask(with: urlFlag) { (data, response, error) in
                    
                    if let data = data, data.count > 0 {
                        DispatchQueue.main.async {
                            self.indicator.stopAnimating()
                            self.flag.image = nil
                            self.flag.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
            self.name.text = getName()
            self.capital.text = getCapital()
            self.population.text = getPopulation()
        }
        
    }
    
    private func getName() -> String? {
        return country?.name
    }
    
    private func getCapital() -> String? {
        return country?.capital
    }
    
    private func getPopulation() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        
        return formatter.string(from: country!.population! as NSNumber)
    }
}

class MVVMViewController: UIViewController, CollectionViewRefreshProtocol, UICollectionViewDelegateFlowLayout {
    
    static let reuseIdentifier = "collectionCell"
    
    @IBOutlet weak var collection: UICollectionView!
    var delegate: RandomPeopleDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate
        delegate = RandomPeopleDelegate(size: self.view.frame.size)
        self.collection.delegate = delegate
        
        // Data source and refresher
        let dataSource = RandomPeopleDataSource(refresher: self)
        self.collection.dataSource = dataSource
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collection.reloadData()
        }
    }
    
}

public class RandomPeopleDataSource: NSObject, Network, UICollectionViewDataSource {
    
    var session: Session?
    var countries: [Country]?
    
    var refresher: CollectionViewRefreshProtocol?
    
    init(refresher: CollectionViewRefreshProtocol) {
        super.init()
        self.session = Session(delegate: self)
        self.refresher = refresher
    }
    
    public func didStart() {
        print("Session did start")
    }
    
    public func didEnd() {
        self.refresher?.reloadData()
    }
    
    public func success(data: Any) {
        self.countries = data as? [Country]
    }
    
    public func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.countries?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MVVMViewController.reuseIdentifier, for: indexPath) as! CountryCell
        cell.populate(country: countries?[indexPath.row])
        return cell
    }
    
}

public class RandomPeopleDelegate: NSObject, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    
    let size: CGSize
    let numberOfColumns: CGFloat = 2
    let gap: CGFloat = 10
    
    init(size: CGSize) {
        self.size = size
        super.init()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Seleccionado")
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((size.width - numberOfColumns * 10) / numberOfColumns)
        return CGSize(width: width, height: width)
    }
}

public struct Session {
    
    let session = URLSession.shared
    var delegate: Network?
    
    init(delegate: Network) {
        self.delegate = delegate
        
        if let unwrappedDelegate = self.delegate, let url = URL(string: "https://restcountries.eu/rest/v2/all") {
            unwrappedDelegate.didStart()
            self.mainDataTask(with: createRequest(url: url))?.resume()
        }
    }
    
    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    private func mainDataTask(with url: URLRequest) -> URLSessionDataTask? {
        return self.session.dataTask(with: url) { (data, response, error) in
            
            if let data = data, data.count > 0 {
                
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    self.delegate?.success(data: countries)
                } catch {
                    self.delegate?.failure(error: error)
                }
                
            } else if let error = error {
                self.delegate?.failure(error: error)
            }
            
            self.delegate?.didEnd()
        }
    }
    
}

public protocol Network {
    func didStart()
    func didEnd()
    func success(data: Any)
    func failure(error: Error)
}

public protocol CollectionViewRefreshProtocol {
    func reloadData()
}

public struct Country: Codable {
    let name: String?
    let capital: String?
    let population: Int?
    let region: String?
    let alpha2Code: String
}
