//
//  ViewController.m
//  Recipe 10-3 Accessing the Music Library
//
//  Created by joseph hoffman on 8/26/13.
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
    self.infoLabel.text = @"...";
	
    self.player = [MPMusicPlayerController applicationMusicPlayer];
    
    [self setNotifications];
    
    [self.player beginGeneratingPlaybackNotifications];
    
    [self.player setShuffleMode:MPMusicShuffleModeOff];
    self.player.repeatMode = MPMusicRepeatModeNone;
    
    self.volumeView.backgroundColor = [UIColor clearColor];
    MPVolumeView *myVolumeView =
    [[MPVolumeView alloc] initWithFrame: self.volumeView.bounds];
    [self.volumeView addSubview: myVolumeView];

    
    self.artistTextField.delegate = self;
    self.artistTextField.enablesReturnKeyAutomatically = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - action methods

- (IBAction)addItems:(id)sender
{
    
    MPMediaPickerController *picker =
    [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    picker.delegate = self;
    picker.allowsPickingMultipleItems = YES;
    picker.prompt = NSLocalizedString (@"Add songs to play",
                                       "Prompt in media item picker");
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)prevTapped:(id)sender
{
    if ([self.player currentPlaybackTime] > 5.0)
    {
        [self.player skipToBeginning];
    }
    else
    {
        [self.player skipToPreviousItem];
    }
    
}

- (IBAction)playTapped:(id)sender
{
    if ((self.myCollection != nil) &&
        (self.player.playbackState != MPMusicPlaybackStatePlaying))
    {
        [self.player play];
        [self.playButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else if (self.player.playbackState == MPMusicPlaybackStatePlaying)
    {
        [self.player pause];
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    
}

- (IBAction)nextTapped:(id)sender
{
    [self.player skipToNextItem];
    
}



- (IBAction)queueMusicByArtist:(id)sender
{
    NSString *artist = self.artistTextField.text;
    if (artist != nil && ![artist isEqual: @""])
    {
        MPMediaPropertyPredicate *artistPredicate =
        [MPMediaPropertyPredicate
         predicateWithValue:artist
         forProperty:MPMediaItemPropertyArtist
         comparisonType:MPMediaPredicateComparisonContains];
        MPMediaQuery *query = [[MPMediaQuery alloc] init];
        [query addFilterPredicate:artistPredicate];
        
        NSArray *result = [query items];
        if ([result count] > 0)
        {
            [self updateQueueWithMediaItemCollection:
             [MPMediaItemCollection collectionWithItems:result]];
        }
        else
            self.infoLabel.text = @"Artist Not Found.";
    }
}

#pragma mark - helper methods

-(void)setNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter
     addObserver: self
     selector:    @selector(handleNowPlayingItemChanged:)
     name:        MPMusicPlayerControllerNowPlayingItemDidChangeNotification
     object:      self.player];
    
    [notificationCenter
     addObserver: self
     selector:    @selector(handlePlaybackStateChanged:)
     name:        MPMusicPlayerControllerPlaybackStateDidChangeNotification
     object:      self.player];
    

}



- (void) handlePlaybackStateChanged: (id) notification
{
    MPMusicPlaybackState playbackState = [self.player playbackState];
    
    if (playbackState == MPMusicPlaybackStateStopped)
    {
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    else if (playbackState == MPMusicPlaybackStatePaused)
    {
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    else if (playbackState == MPMusicPlaybackStatePlaying)
    {
        [self.playButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

- (void) handleNowPlayingItemChanged: (id) notification
{
    MPMediaItem *currentItemPlaying = [self.player nowPlayingItem];
    if (currentItemPlaying)
    {
        NSString *info = [NSString stringWithFormat:@"%@ - %@",
                          [currentItemPlaying valueForProperty:MPMediaItemPropertyTitle],
                          [currentItemPlaying valueForProperty:MPMediaItemPropertyArtist]];
        self.infoLabel.text = info;
    }
    else
    {
        self.infoLabel.text = @"...";
    }
}

-(void)updateQueueWithMediaItemCollection:(MPMediaItemCollection *)collection
{
    if (collection)
    {
        if (self.myCollection == nil)
        {
            self.myCollection = collection;
            [self.player setQueueWithItemCollection: self.myCollection];
            [self.player play];
        }
        else
        {
            BOOL wasPlaying = NO;
            if (self.player.playbackState == MPMusicPlaybackStatePlaying)
            {
                wasPlaying = YES;
            }
            
            MPMediaItem *nowPlayingItem        = self.player.nowPlayingItem;
            NSTimeInterval currentPlaybackTime = self.player.currentPlaybackTime;
            
            NSMutableArray *combinedMediaItems =
            [[self.myCollection items] mutableCopy];
            NSArray *newMediaItems = [collection items];
            [combinedMediaItems addObjectsFromArray: newMediaItems];
            
            self.myCollection =
            [MPMediaItemCollection collectionWithItems:combinedMediaItems];
            
            [self.player setQueueWithItemCollection:self.myCollection];
            
            self.player.nowPlayingItem      = nowPlayingItem;
            self.player.currentPlaybackTime = currentPlaybackTime;
            
            if (wasPlaying)
            {
                [self.player play];
            }
        }
    }
}

#pragma mark - delegate methods

-(void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [self updateQueueWithMediaItemCollection:mediaItemCollection];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self queueMusicByArtist:self];
    return NO;
}



@end
