//
//  StrettchyHeaderViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 3/25/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class StrettchyHeaderViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")

        if let flowLayout = self.collectionView?.collectionViewLayout as? StretchyHeaderLayout {
            
            let width = (self.view.frame.width - 16)
            
            flowLayout.itemSize                 =       CGSize(width: width, height: 44)
            flowLayout.minimumLineSpacing       =       8
            flowLayout.minimumInteritemSpacing  =       8
            flowLayout.headerReferenceSize      =       CGSize(width: width, height: 400)
            flowLayout.sectionInset             =       UIEdgeInsetsMake(8, 0, 24, 0)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        item.backgroundColor = .purple
        
        return item
    }

}
