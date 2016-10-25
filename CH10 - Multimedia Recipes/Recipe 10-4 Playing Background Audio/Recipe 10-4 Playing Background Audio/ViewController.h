//
//  ViewController.h
//  Recipe 10-4: Playing Background Audio
//
//  Created by joseph hoffman on 8/27/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <MPMediaPickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSMutableArray *playlist;
@property (nonatomic) NSInteger currentIndex;

@property (nonatomic, strong) AVAudioSession *session;

- (IBAction)queueFromLibrary:(id)sender;
- (IBAction)goToPrevTrack:(id)sender;
- (IBAction)togglePlay:(id)sender;
- (IBAction)goToNextTrack:(id)sender;
- (IBAction)clearPlaylist:(id)sender;

@end
