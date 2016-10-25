//
//  ViewController.h
//  Tic Tac Toe
//
//  Created by joseph hoffman on 9/10/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface ViewController : UIViewController <GKTurnBasedMatchmakerViewControllerDelegate,GKLocalPlayerListener>
{


}

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *row1Col1Button;
@property (weak, nonatomic) IBOutlet UIButton *row1Col2Button;
@property (weak, nonatomic) IBOutlet UIButton *row1Col3Button;
@property (weak, nonatomic) IBOutlet UIButton *row2Col1Button;
@property (weak, nonatomic) IBOutlet UIButton *row2Col2Button;
@property (weak, nonatomic) IBOutlet UIButton *row2Col3Button;
@property (weak, nonatomic) IBOutlet UIButton *row3Col1Button;
@property (weak, nonatomic) IBOutlet UIButton *row3Col2Button;
@property (weak, nonatomic) IBOutlet UIButton *row3Col3Button;
@property (weak, nonatomic) IBOutlet UILabel *player1Label;
@property (weak, nonatomic) IBOutlet UILabel *player2Label;

@property (strong, nonatomic) GKLocalPlayer *localPlayer;
@property (strong, nonatomic) GKTurnBasedMatch *match;
@property (strong, nonatomic) GKPlayer *player1;
@property (strong, nonatomic) GKPlayer *player2;

- (IBAction)selectButton:(id)sender;
- (IBAction)playGame:(id)sender;

@end
