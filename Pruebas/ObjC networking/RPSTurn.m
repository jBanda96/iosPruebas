//
//  RPSTurn.m
//  Pruebas
//
//  Created by Julio Banda on 16/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import "RPSTurn.h"

@implementation RPSTurn

- (instancetype) init {
    self = [super init];
    
    if (self) {
        _move = [self generateMove];
    }
    
    return self;
}

- (instancetype) initWithMove:(Move)move {
    self = [super init];
    
    if (self) {
        _move = move;
    }
    
    return self;
}

- (Move) generateMove {
    NSInteger randomNumber = arc4random_uniform(3);
    return randomNumber;
}

- (BOOL) defeats: (RPSTurn *) turn {
    
    NSLog(@"%li vs %li", self.move, turn.move);
    
    if((self.move == Papper && turn.move == Rock) ||
       (self.move == Scissors && turn.move == Papper) ||
       (self.move == Rock && turn.move == Scissors)) {
        return true;
    } else {
        return false;
    }
}

- (NSString *) description {
    switch (self.move) {
        case Rock:
            return @"Rock";
            break;
        
        case Papper:
            return @"Paper";
            break;
            
        case Scissors:
            return @"Scissors";
            break;
            
        default:
            return @"Invalid";
            break;
    }
}

@end
