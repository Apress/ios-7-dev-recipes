//
//  ViewController.m
//  Lucky
//
//  Created by joseph hoffman on 9/8/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.achievements = [[NSMutableDictionary alloc] init];
    self.player = nil;
    [self authenticatePlayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark  - custom setters

- (void)setPlayer:(GKLocalPlayer *)player
{
    if (_player == player)
        return;
    
    [self.achievements removeAllObjects];
    
    _player = player;
    NSString *playerName;
    if (_player)
    {
        playerName = _player.alias;
        [self loadAchievements];
    }
    else
    {
        playerName = @"Anonymous Player";
    }
    self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome %@", playerName];
}

- (IBAction)playEasyGame:(id)sender
{
    [self playGameWithLevel:0];
}

- (IBAction)playNormalGame:(id)sender
{
    [self playGameWithLevel:1];
}

- (IBAction)playHardGame:(id)sender
{
    [self playGameWithLevel:2];
}

- (IBAction)showGameCenter:(id)sender
{
    GKGameCenterViewController *gameCenterController =
    [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        [self presentViewController:gameCenterController animated:YES completion:nil];
    }
}
#pragma mark - helper methods

- (void)playGameWithLevel:(int)level
{
    GameViewController *gameViewController =
    [[GameViewController alloc] initWithLevel:level achievements:self.achievements];
    [self.navigationController pushViewController:gameViewController animated:YES];
}

- (void)authenticatePlayer
{
    __weak GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler =
    ^(UIViewController *authenticateViewController, NSError *error)
    {
        if (authenticateViewController != nil)
        {
            [self presentViewController:authenticateViewController animated:YES
                             completion:nil];
        }
        else if (localPlayer.isAuthenticated)
        {
            self.player = localPlayer;
        }
        else
        {
            // Disable Game Center
            self.player = nil;
        }
    };
}

- (void)loadAchievements
{
    [GKAchievement loadAchievementsWithCompletionHandler:
     ^(NSArray *achievements, NSError *error)
     {
         if (error == nil)
         {
             for (GKAchievement* achievement in achievements)
                 [self.achievements setObject: achievement
                                       forKey: achievement.identifier];
         }
         else
         {
             NSLog(@"Error loading achievements: %@", error);
         }
     }];
}

#pragma mark - delegate methods

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
