//
//  NetProtocol.h
//  Pruebas
//
//  Created by Julio Banda on 06/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@protocol NetProtocol <NSObject>
-(void) fetchData: (NSMutableArray *)array;
@end
