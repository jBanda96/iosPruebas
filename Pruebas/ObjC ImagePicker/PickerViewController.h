//
//  PickerViewController.h
//  Pruebas
//
//  Created by Julio Banda on 19/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DidTakePhotoProtocol.h"
#import "Gif.h"

NS_ASSUME_NONNULL_BEGIN

@interface PickerViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic) Gif *gif;

@end

NS_ASSUME_NONNULL_END
