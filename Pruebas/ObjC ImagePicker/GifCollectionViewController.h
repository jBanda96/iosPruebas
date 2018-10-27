//
//  GifCollectionViewController.h
//  Pruebas
//
//  Created by Julio Banda on 21/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GifCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collection;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicator;
@end

NS_ASSUME_NONNULL_END
