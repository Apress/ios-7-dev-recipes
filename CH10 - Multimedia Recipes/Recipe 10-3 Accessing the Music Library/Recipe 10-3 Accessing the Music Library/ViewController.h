//
//  ViewController.h
//  Recipe 10-3 Accessing the Music Library
//
//  Created by joseph hoffman on 8/26/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController <MPMediaPickerControllerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet MPVolumeView *volumeView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) MPMediaItemCollection *myCollection;
@property (strong, nonatomic) MPMusicPlayerController *player;
@property (weak, nonatomic) IBOutlet UITextField *artistTextField;

- (IBAction)addItems:(id)sender;
- (IBAction)prevTapped:(id)sender;
- (IBAction)playTapped:(id)sender;
- (IBAction)nextTapped:(id)sender;
- (IBAction)queueMusicByArtist:(id)sender;



@end
