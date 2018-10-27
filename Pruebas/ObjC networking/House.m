//
//  House.m
//  Pruebas
//
//  Created by Julio Banda on 16/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import "House.h"

@interface House()
    @property (nonatomic, readwrite) int numberOfBedrooms;
@end

@implementation House

- (instancetype) initWithAddress: (NSString *) address {
    self = [super init];
    
    if (self) {
        _address = [address copy];
        _numberOfBedrooms = 2;
        _hasHotTube = NO;
    }
    
    return self;
}

@end
