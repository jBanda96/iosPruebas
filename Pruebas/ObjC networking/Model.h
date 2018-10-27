//
//  Model.h
//  Pruebas
//
//  Created by Julio Banda on 06/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

-(id) initWithInfo:(NSDictionary *)info;

@property(nonatomic, weak) NSNumber *idd;
@property(nonatomic, copy) NSString *myDescription;

@end
