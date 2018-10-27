//
//  RPSGame.h
//  Pruebas
//
//  Created by Julio Banda on 16/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPSTurn.h"

@interface RPSGame : NSObject

@property (nonatomic) RPSTurn *firstTurn;
@property (nonatomic) RPSTurn *secondTurn;

- (instancetype) initWithFirstTurn: (RPSTurn *) playerTurn
                        secondTurn: (RPSTurn *) computerTurn;

- (RPSTurn *) winner;
- (RPSTurn *) loser;

- (NSString *) resultString: (RPSGame *) game;

@end
