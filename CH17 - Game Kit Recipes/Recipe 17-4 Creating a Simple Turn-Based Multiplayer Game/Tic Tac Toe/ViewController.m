//
//  ViewController.m
//  Tic Tac Toe
//
//  Created by joseph hoffman on 9/10/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self enableSquareButtons:NO];

    self.statusLabel.text = @"Press Play to start a game";
    
    self.player1 = nil;
    self.player2 = nil;

    [self authenticateLocalPlayer];
    [[GKLocalPlayer localPlayer] registerListener:self];
}

#pragma mark - custom setter methods

- (void)setMatch:(GKTurnBasedMatch *)match
{
    _match = match;
    
    [self loadPlayers];
    [self loadMatchData];
}

- (void)setPlayer1:(GKPlayer *)player1
{
    _player1 = player1;
    if (_player1)
    {
        self.player1Label.text = _player1.displayName;
    }
    else
    {
        self.player1Label.text = @"<vacant>";
    }
}

- (void)setPlayer2:(GKPlayer *)player2
{
    _player2 = player2;
    if (_player2)
    {
        self.player2Label.text = _player2.displayName;
    }
    else
    {
        self.player2Label.text = @"<vacant>";
    }
}

/*

- (void)setLocalPlayer:(GKLocalPlayer *)localPlayer
{
    _localPlayer = localPlayer;
    if (_localPlayer)
    {
        //[GKTurnBasedEventHandler sharedTurnBasedEventHandler].delegate = self;
        [[GKLocalPlayer localPlayer] registerListener:self];
    }
    else
    {
        //[GKTurnBasedEventHandler sharedTurnBasedEventHandler].delegate = nil;
        [[GKLocalPlayer localPlayer] registerListener:nil];
    }
}

*/

#pragma mark - game logic

- (IBAction)playGame:(id)sender
{
    if (self.localPlayer.isAuthenticated)
    {
        GKMatchRequest *request = [[GKMatchRequest alloc] init];
        request.minPlayers = 2;
        request.maxPlayers = 2;
        
        GKTurnBasedMatchmakerViewController *matchMakerViewController =
        [[GKTurnBasedMatchmakerViewController alloc] initWithMatchRequest:request];
        matchMakerViewController.turnBasedMatchmakerDelegate = self;
        [self presentViewController:matchMakerViewController animated:YES
                         completion:nil];
    }
    else
    {
        UIAlertView *notLoggedInAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                   message:@"You must be logged into Game Center to play this game!"
                                                                  delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [notLoggedInAlert show];
    }
}

- (void)loadPlayers
{
    GKTurnBasedParticipant *participant1 = [self.match.participants objectAtIndex:0];
    GKTurnBasedParticipant *participant2 = [self.match.participants objectAtIndex:1];
    
    NSMutableArray *playerIDs = [[NSMutableArray alloc] initWithCapacity:2];
    if (participant1.playerID &&
        ![participant1.playerID isEqualToString:self.player1.playerID])
    {
        [playerIDs addObject:participant1.playerID];
    }
    if (participant2.playerID  &&
        ![participant2.playerID isEqualToString:self.player2.playerID])
    {
        [playerIDs addObject:participant2.playerID];
    }
    
    if (playerIDs.count == 0)
        return; // No players to load
    
    [GKPlayer loadPlayersForIdentifiers:playerIDs withCompletionHandler:
     ^(NSArray *players, NSError *error)
     {
         if (players)
         {
             GKPlayer *player1;
             GKPlayer *player2;
             for (GKPlayer *player in players)
             {
                 if ([player.playerID isEqualToString:participant1.playerID])
                 {
                     player1 = player;
                 }
                 else if ([player.playerID isEqualToString:participant2.playerID])
                 {
                     player2 = player;
                 }
             }
             dispatch_async(dispatch_get_main_queue(),^{
                 self.player1 = player1;
                 self.player2 = player2;
             });
         }
         if (error)
         {
             NSLog(@"Error loading players: %@", error);
         }

     }];

}

- (void)resetButtonTitles
{
    [self.row1Col1Button setTitle:@"" forState:UIControlStateNormal];
    [self.row1Col2Button setTitle:@"" forState:UIControlStateNormal];
    [self.row1Col3Button setTitle:@"" forState:UIControlStateNormal];
    [self.row2Col1Button setTitle:@"" forState:UIControlStateNormal];
    [self.row2Col2Button setTitle:@"" forState:UIControlStateNormal];
    [self.row2Col3Button setTitle:@"" forState:UIControlStateNormal];
    [self.row3Col1Button setTitle:@"" forState:UIControlStateNormal];
    [self.row3Col2Button setTitle:@"" forState:UIControlStateNormal];
    [self.row3Col3Button setTitle:@"" forState:UIControlStateNormal];
}

- (void)enableSquareButtons:(BOOL)enable
{
    self.row1Col1Button.enabled = enable;
    self.row1Col2Button.enabled = enable;
    self.row1Col3Button.enabled = enable;
    self.row2Col1Button.enabled = enable;
    self.row2Col2Button.enabled = enable;
    self.row2Col3Button.enabled = enable;
    self.row3Col1Button.enabled = enable;
    self.row3Col2Button.enabled = enable;
    self.row3Col3Button.enabled = enable;
}

- (IBAction)selectButton:(UIButton *)sender
{
    if (sender.currentTitle.length != 0)
    {
        UIAlertView *squareOccupiedAlert = [[UIAlertView alloc]
                                            initWithTitle:@"Invalid Move" message:@"You can only pick empty squares"
                                            delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [squareOccupiedAlert show];
        return;
    }
    
    [sender setTitle:[self localPlayerMark] forState:UIControlStateNormal];
    [self checkCurrentState];
}


- (void)checkCurrentState
{
    if ([self equalMarksForButton1:self.row1Col1Button button2:self.row1Col2Button
                           button3:self.row1Col3Button])
    {
        [self gameEndedWithWinner:self.row1Col1Button.currentTitle];
    }
    else if ([self equalMarksForButton1:self.row2Col1Button button2:self.row2Col2Button
                                button3:self.row2Col3Button])
    {
        [self gameEndedWithWinner:self.row2Col1Button.currentTitle];
    }
    else if ([self equalMarksForButton1:self.row3Col1Button button2:self.row3Col2Button
                                button3:self.row3Col3Button])
    {
        [self gameEndedWithWinner:self.row3Col1Button.currentTitle];
    }
    else if ([self equalMarksForButton1:self.row1Col1Button button2:self.row2Col1Button
                                button3:self.row3Col1Button])
    {
        [self gameEndedWithWinner:self.row1Col1Button.currentTitle];
    }
    else if ([self equalMarksForButton1:self.row1Col2Button button2:self.row2Col2Button
                                button3:self.row3Col2Button])
    {
        [self gameEndedWithWinner:self.row1Col2Button.currentTitle];
    }
    else if ([self equalMarksForButton1:self.row1Col3Button button2:self.row2Col3Button
                                button3:self.row3Col3Button])
    {
        [self gameEndedWithWinner:self.row1Col3Button.currentTitle];
    }
    else if ([self equalMarksForButton1:self.row1Col1Button button2:self.row2Col2Button
                                button3:self.row3Col3Button])
    {
        [self gameEndedWithWinner:self.row1Col1Button.currentTitle];
    }
    else if ([self equalMarksForButton1:self.row1Col3Button button2:self.row2Col2Button
                                button3:self.row3Col1Button])
    {
        [self gameEndedWithWinner:self.row1Col3Button.currentTitle];
    }
    else if ([self noEmptySquaresLeft])
    {
        [self gameEndedInTie];
    }
    else
    {
        [self advanceTurn];
    }
}

- (BOOL)equalMarksForButton1:(UIButton *)button1 button2:(UIButton *)button2 button3:(UIButton *)button3
{
    return button1.currentTitle.length > 0 &&
    [button1.currentTitle isEqualToString:button2.currentTitle] &&
    [button1.currentTitle isEqualToString:button3.currentTitle];
}

- (void)gameEndedWithWinner:(NSString *)mark
{
    NSString *message = [NSString stringWithFormat:@"%@ won!", mark];
    UIAlertView *gameOverAlert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                            message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [gameOverAlert show];
    
    //_currentMark = @"";
    self.statusLabel.text = message;
    
    self.match.message = self.statusLabel.text;
    
    GKTurnBasedParticipant *participant1 = [self.match.participants objectAtIndex:0];
    GKTurnBasedParticipant *participant2 = [self.match.participants objectAtIndex:1];
    participant1.matchOutcome = GKTurnBasedMatchOutcomeTied;
    participant2.matchOutcome = GKTurnBasedMatchOutcomeTied;
    
    if ([participant1.playerID isEqualToString:self.localPlayer.playerID])
    {
        participant1.matchOutcome = GKTurnBasedMatchOutcomeWon;
        participant2.matchOutcome = GKTurnBasedMatchOutcomeLost;
    }
    else
    {
        participant2.matchOutcome = GKTurnBasedMatchOutcomeWon;
        participant1.matchOutcome = GKTurnBasedMatchOutcomeLost;
    }
    
    NSData *matchData = [self encodeMatchData];
    [self.match endMatchInTurnWithMatchData:matchData completionHandler:
     ^(NSError *error)
     {
         if (error)
         {
             NSLog(@"Error ending match: %@", error);
         }
         //
     }];
    [self enableSquareButtons:NO];
}

- (BOOL)noEmptySquaresLeft
{
    if (self.row1Col1Button.currentTitle.length == 0)
        return NO;
    if (self.row1Col2Button.currentTitle.length == 0)
        return NO;
    if (self.row1Col3Button.currentTitle.length == 0)
        return NO;
    if (self.row2Col1Button.currentTitle.length == 0)
        return NO;
    if (self.row2Col2Button.currentTitle.length == 0)
        return NO;
    if (self.row2Col3Button.currentTitle.length == 0)
        return NO;
    if (self.row3Col1Button.currentTitle.length == 0)
        return NO;
    if (self.row3Col2Button.currentTitle.length == 0)
        return NO;
    if (self.row3Col3Button.currentTitle.length == 0)
        return NO;
    return YES;
}

- (void)gameEndedInTie
{
    NSString *message = @"Game ended in a tie!";
    UIAlertView *gameOverAlert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                            message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [gameOverAlert show];
    
    //_currentMark = @"";
    self.statusLabel.text = message;
    self.match.message = self.statusLabel.text;
    NSData *matchData = [self encodeMatchData];
    GKTurnBasedParticipant *participant1 = [self.match.participants objectAtIndex:0];
    GKTurnBasedParticipant *participant2 = [self.match.participants objectAtIndex:1];
    participant1.matchOutcome = GKTurnBasedMatchOutcomeTied;
    participant2.matchOutcome = GKTurnBasedMatchOutcomeTied;
    [self.match endMatchInTurnWithMatchData:matchData completionHandler:
     ^(NSError *error)
     {
         if (error)
         {
             NSLog(@"Error ending match: %@", error);
         }
         //
     }];
    [self enableSquareButtons:NO];
}

- (void)advanceTurn
{
    [self enableSquareButtons:NO];
    self.statusLabel.text =
    [NSString stringWithFormat:@"%@'s turn", [self opponentMark]];
    self.match.message = self.statusLabel.text;
    NSData *matchData = [self encodeMatchData];
    [self.match endTurnWithNextParticipants:@[[self opponentParticipant]]
                                turnTimeout:GKTurnTimeoutDefault matchData:matchData completionHandler:
     ^(NSError *error)
     {
         if (error)
         {
             NSLog(@"Error advancing turn: %@", error);
         }
     }];
}

- (void)authenticateLocalPlayer
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
            self.localPlayer = localPlayer;
        }
        else
        {
            // Disable Game Center
            self.localPlayer = nil;
        }
    };
}

#pragma mark - math data methods

- (NSData *)encodeMatchData
{
    NSArray *stateArray = @[@1 /* version */,
                            self.row1Col1Button.currentTitle, self.row1Col2Button.currentTitle,
                            self.row1Col3Button.currentTitle,
                            self.row2Col1Button.currentTitle, self.row2Col2Button.currentTitle,
                            self.row2Col3Button.currentTitle,
                            self.row3Col1Button.currentTitle, self.row3Col2Button.currentTitle,
                            self.row3Col3Button.currentTitle
                            ];
    return [NSKeyedArchiver archivedDataWithRootObject:stateArray];
}

- (void)decodeMatchData:(NSData *)matchData
{
    NSArray *stateArray = [NSKeyedUnarchiver unarchiveObjectWithData:matchData];
    
    [self.row1Col1Button setTitle:[stateArray objectAtIndex:1]
                         forState:UIControlStateNormal];
    [self.row1Col2Button setTitle:[stateArray objectAtIndex:2]
                         forState:UIControlStateNormal];
    [self.row1Col3Button setTitle:[stateArray objectAtIndex:3]
                         forState:UIControlStateNormal];
    [self.row2Col1Button setTitle:[stateArray objectAtIndex:4]
                         forState:UIControlStateNormal];
    [self.row2Col2Button setTitle:[stateArray objectAtIndex:5]
                         forState:UIControlStateNormal];
    [self.row2Col3Button setTitle:[stateArray objectAtIndex:6]
                         forState:UIControlStateNormal];
    [self.row3Col1Button setTitle:[stateArray objectAtIndex:7]
                         forState:UIControlStateNormal];
    [self.row3Col2Button setTitle:[stateArray objectAtIndex:8]
                         forState:UIControlStateNormal];
    [self.row3Col3Button setTitle:[stateArray objectAtIndex:9] 
                         forState:UIControlStateNormal];
}

- (void)loadMatchData
{
    [_match loadMatchDataWithCompletionHandler:^(NSData *matchData, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(),^{
             if (matchData.length > 0)
             {
                 [self decodeMatchData:matchData];
             }
             else
             {
                 [self resetButtonTitles];
             }
             NSString *currentMark;
             if ([self localPlayerIsCurrentPlayer])
             {
                 [self enableSquareButtons:YES];
                 currentMark = [self localPlayerMark];
             }
             else
             {
                 [self enableSquareButtons:NO];
                 currentMark = [self opponentMark];
             }
             self.statusLabel.text =
             [NSString stringWithFormat:@"%@'s turn", currentMark];
         });
     }];
}

- (BOOL)localPlayerIsCurrentPlayer
{
    return [self.localPlayer.playerID
            isEqualToString:self.match.currentParticipant.playerID];
}

- (NSString *)localPlayerMark
{
    if ([self.localPlayer.playerID isEqualToString:self.player1.playerID])
    {
        return @"X";
    }
    else
    {
        return @"O";
    }
}

- (NSString *)opponentMark
{
    if ([[self localPlayerMark] isEqualToString:@"X"])
    {
        return @"O";
    }
    else
    {
        return @"X";
    }
}

- (GKTurnBasedParticipant *)opponentParticipant
{
    GKTurnBasedParticipant *candidate = [self.match.participants objectAtIndex:0];
    if ([self.localPlayer.playerID isEqualToString:candidate.playerID])
    {
        return [self.match.participants objectAtIndex:1];
    }
    else
    {
        return candidate;
    }
}
- (void)handleMatchEnded:(GKTurnBasedMatch *)match
{
    if ([self.match.matchID isEqualToString:match.matchID])
    {
        [self.match loadMatchDataWithCompletionHandler:
         ^(NSData *matchData, NSError *error)
         {
             dispatch_async(dispatch_get_main_queue(),^{
                 if (matchData.length > 0)
                 {
                     [self decodeMatchData:matchData];
                 }
                 self.statusLabel.text = match.message;
             });
         }];
    }
}




#pragma mark - Matchmaker delegates

- (void)turnBasedMatchmakerViewControllerWasCancelled:
(GKTurnBasedMatchmakerViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)turnBasedMatchmakerViewController:
(GKTurnBasedMatchmakerViewController *)viewController didFailWithError:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Error while matchmaking: %@", error);
}
- (void)turnBasedMatchmakerViewController:
(GKTurnBasedMatchmakerViewController *)viewController didFindMatch:(GKTurnBasedMatch *)match
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.match = match;
}

- (void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController playerQuitForMatch:(GKTurnBasedMatch *)match
{
    if ([self.match.matchID isEqualToString:match.matchID])
    {
        [self gameEndedWithWinner:[self localPlayerMark]];
    }
}

#pragma mark - turn based delegates




-(void)player:(GKPlayer *)player receivedTurnEventForMatch:(GKTurnBasedMatch *)match didBecomeActive:(BOOL)didBecomeActive
{
    
    self.match = match;

}

-(void)player:(GKPlayer *)player matchEnded:(GKTurnBasedMatch *)match
{
    
    
    self.match = match;
}




@end
