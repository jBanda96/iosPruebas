//
//  RPSTurn.h
//  Pruebas
//
//  Created by Julio Banda on 16/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Move){
    Rock,
    Papper,
    Scissors
};

@interface RPSTurn : NSObject

@property (nonatomic) Move move;

- (instancetype) initWithMove: (Move) move;

- (BOOL) defeats: (RPSTurn *) turn;

- (NSString *) description;

@end
