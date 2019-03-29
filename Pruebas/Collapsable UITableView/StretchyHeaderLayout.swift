//
//  StretchyHeaderLayout.swift
//  Pruebas
//
//  Created by Julio Banda on 3/25/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach {
            print($0.description)
            if $0.representedElementKind == UICollectionElementKindSectionHeader {
                
                guard let collectionView = collectionView else { return }
                
                let width           =   collectionView.frame.width
                let contentOffsetY  =   collectionView.contentOffset.y
                
                print(contentOffsetY)
                if contentOffsetY > 280 {
                    $0.frame = CGRect(x: 0.0, y: contentOffsetY, width: width, height: 120)
                    return
                }
                
                let height = $0.frame.height - contentOffsetY
                
                $0.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
                
            }
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
