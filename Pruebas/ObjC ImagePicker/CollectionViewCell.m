//
//  CollectionViewCell.m
//  Pruebas
//
//  Created by Julio Banda on 21/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void) setUpCellWith: (NSString *) string {
    [self.label setText: string];
}

@end
