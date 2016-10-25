//
//  ViewController.h
//  Lucky
//
//  Created by joseph hoffman on 9/8/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameViewController.h"
#import <GameKit/GameKit.h>

@interface ViewController : UIViewController <GKGameCenterControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) GKLocalPlayer *player;
@property (strong, nonatomic) NSMutableDictionary *achievements;

- (IBAction)playEasyGame:(id)sender;
- (IBAction)playNormalGame:(id)sender;
- (IBAction)playHardGame:(id)sender;

- (IBAction)showGameCenter:(id)sender;

@end
