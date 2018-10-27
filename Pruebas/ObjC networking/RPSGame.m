//
//  RPSGame.m
//  Pruebas
//
//  Created by Julio Banda on 16/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import "RPSGame.h"

@implementation RPSGame

- (instancetype) initWithFirstTurn:(RPSTurn *)playerTurn secondTurn:(RPSTurn *)computerTurn {
    self = [super init];
    
    if (self) {
        _firstTurn = playerTurn;
        _secondTurn = computerTurn;
    }
    
    return self;
}

- (RPSTurn *) winner {
    return [self.firstTurn defeats: self.secondTurn] ? self.firstTurn : self.secondTurn;
}

- (RPSTurn *) loser {
    return [self.firstTurn defeats: self.secondTurn] ? self.secondTurn : self.firstTurn;
}

- (NSString *) resultString: (RPSGame *) game {
    return [game.firstTurn defeats:game.secondTurn] ? @"You Win" : @"You lose";
}

@end
