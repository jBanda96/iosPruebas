//
//  CollectionViewCell.h
//  Pruebas
//
//  Created by Julio Banda on 21/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UILabel *label;

- (void) setUpCellWith: (NSString *) string;

@end

NS_ASSUME_NONNULL_END
