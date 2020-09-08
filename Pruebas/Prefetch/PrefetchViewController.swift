//
//  PrefetchViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 25/08/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

// MARK: - Lifecycle
class PrefetchViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellIdentifier = "randomUserCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
}

//MARK: - DataSource
extension PrefetchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? RandomUserCell else {
            fatalError("Expected. Check the configuration in Main.storyboard.")
        }
        cell.name.text = "Julio"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        <#code#>
    }
}

//MARK: - Prefetching
extension PrefetchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetching")
    }
}

extension PrefetchViewController: UICollectionViewDelegateFlowLayout { }

//MARK: - Functions
extension PrefetchViewController {
    func registerCells() {
        self.collectionView.register(UINib(nibName: "RandomUserCell", bundle: Bundle(for: RandomUserCell.self)), forCellWithReuseIdentifier: self.cellIdentifier)
        self.collectionView.register(UINib(nibName: "SectionHeader", bundle: Bundle(for: SectionHeader.self)), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionHeader")
//        self.collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionHeader")
    }
}
