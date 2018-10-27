//
//  RockPaperScissorsViewController.m
//  Pruebas
//
//  Created by Julio Banda on 16/09/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

#import "RockPaperScissorsViewController.h"
#import "RPSTurn.h"
#import "RPSGame.h"

@interface RockPaperScissorsViewController ()

@property (nonatomic) RPSGame *game;

@end

@implementation RockPaperScissorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self throwDown: Rock];
    NSString *resultMessage = [self messageForGame:self.game];
    NSLog(@"%@", resultMessage);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:resultMessage preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction: ok];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void) throwDown: (Move) playersMove {
 
    RPSTurn *playersTurn = [[RPSTurn alloc] initWithMove: playersMove];
    RPSTurn *computersTurn = [[RPSTurn alloc] init];
    
    self.game = [[RPSGame alloc] initWithFirstTurn:playersTurn
                                        secondTurn:computersTurn];
    
}

- (NSString *) messageForGame: (RPSGame *) game {
    
    if (game.firstTurn.move == game.secondTurn.move) {
        return @"It's a tie";
    } else {
        NSString *winnerMessage = [[game winner] description];
        NSString *loserrMessage = [[game loser] description];
        NSString *resultString = @"";
        
        NSString *wholeString = [NSString stringWithFormat: @"%@ %@ %@ %@ %@", winnerMessage, @" defeats ", loserrMessage, @".", resultString];
        
        return wholeString;
    }
    
}

@end
