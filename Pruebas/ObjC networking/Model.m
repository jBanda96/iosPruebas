//
//  Model.m
//  Pruebas
//
//  Created by Julio Banda on 06/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import "Model.h"

@implementation Model

@synthesize myDescription, idd;

-(id) initWithInfo:(NSDictionary *)info {
    myDescription = [info objectForKey:@"title"];
    idd = [info objectForKey:@"id"];
    
    return self;
}

@end
