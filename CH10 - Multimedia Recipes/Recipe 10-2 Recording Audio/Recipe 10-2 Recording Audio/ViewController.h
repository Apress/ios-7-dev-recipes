//
//  ViewController.h
//  Recipe 10-2 Recording Audio
//
//  Created by joseph hoffman on 8/26/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate,AVAudioRecorderDelegate>
{
    @private
    BOOL _newRecordingAvailable;
}

@property (weak, nonatomic) IBOutlet UILabel *averageLabel;
@property (weak, nonatomic) IBOutlet UILabel *peakLabel;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) AVAudioSession *session;
@property (strong, nonatomic) NSString *recordedFilePath;

- (IBAction)toggleRecording:(id)sender;
- (IBAction)togglePlaying:(id)sender;

@end
