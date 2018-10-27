//
//  NetUtils.h
//  Pruebas
//
//  Created by Julio Banda on 06/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetProtocol.h"

@interface NetUtils : NSObject

@property(nonatomic, weak) id <NetProtocol> protocol;

-(void) prepareForFetching;

@end
