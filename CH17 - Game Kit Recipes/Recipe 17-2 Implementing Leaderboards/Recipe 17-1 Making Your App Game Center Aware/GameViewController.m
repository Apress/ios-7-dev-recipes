//
//  GameViewController.m
//  Lucky
//
//  Created by joseph hoffman on 9/9/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (id)initWithLevel:(int)level
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _level = level;
        _score = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    switch (_level)
    {
        case 0:
            self.title = @"Easy Game";
            break;
        case 1:
            self.title = @"Normal Game";
            break;
        case 2:
            self.title = @"Hard Game";
            break;
            
        default:
            break;
    }
    
    [self updateScoreLabel];
    [self setupButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)gameButtonSelected:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        // Safe, continue game
        _score += 1;
        [self updateScoreLabel];
        [self setupButtons];
    }
    else
    {
        // Game Over
        NSString *message = [NSString stringWithFormat:@"Your score was %i.", _score];
        UIAlertView *gameOverAlert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                                message:message delegate:self cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
        [gameOverAlert show];
    }
}

#pragma mark - helper methods
- (void)updateScoreLabel
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", _score];
}

- (void)setupButtons
{
    switch (_level) {
        case 0:
            [self setupButtonsForEasyGame];
            break;
        case 1:
            [self setupButtonsForNormalGame];
            break;
        case 2:
            [self setupButtonsForHardGame];
            break;
            
        default:
            break;
    }
}

- (void)setupButtonsForEasyGame
{
    [self resetButtonTags];
    int killerButtonIndex = rand() % 4;
    [self buttonForIndex:killerButtonIndex].tag = 1;
}

- (void)setupButtonsForNormalGame
{
    [self resetButtonTags];
    int killerButtonIndex1 = rand() % 4;
    int killerButtonIndex2;
    do {
        killerButtonIndex2 = rand() % 4;
    } while (killerButtonIndex1 == killerButtonIndex2);
    
    [self buttonForIndex:killerButtonIndex1].tag = 1;
    [self buttonForIndex:killerButtonIndex2].tag = 1;
}

- (void)setupButtonsForHardGame
{
    int safeButtonIndex = rand() % 4;
    for (int i=0; i < 4; i++) {
        if (i == safeButtonIndex) {
            [self buttonForIndex:i].tag = 0;
        }
        else
        {
            [self buttonForIndex:i].tag = 1;
        }
    }
}


- (void)resetButtonTags
{
    for (int i = 0; i < 4; i++)
    {
        UIButton *button = [self buttonForIndex:i];
        button.tag = 0;
    }
}

- (UIButton *)buttonForIndex:(int)index
{
    switch (index)
    {
        case 0:
            return self.button1;
        case 1:
            return self.button2;
        case 2:
            return self.button3;
        case 3:
            return self.button4;
        default:
            return nil;
    }
}

- (void)reportScore:(int64_t)score forLeaderboard: (NSString*)leaderboardID
{
    GKScore *gameCenterScore = [[GKScore alloc] initWithLeaderboardIdentifier:leaderboardID];
    gameCenterScore.value = score;
    gameCenterScore.context = 0;
    
    NSArray *scoresArray = [[NSArray alloc] initWithObjects:gameCenterScore, nil];
    
    [GKScore reportScores:scoresArray withCompletionHandler:^(NSError *error)
     {
         if (error)
         {
             NSLog(@"Error reporting score: %@", error);
         }
     }];
}

- (NSString *)leaderboardID
{
    switch (_level) {
        case 0:
            return @"Lucky.easy";
        case 1:
            return @"Lucky.normal";
        case 2:
            return @"Lucky.hard";
        default:
            return @"";
    }
}
#pragma mark - delegate methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
    if ([GKLocalPlayer localPlayer].isAuthenticated)
    {
        [self reportScore:_score forLeaderboard:[self leaderboardID]];
    }
}


@end
