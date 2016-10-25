//
//  ViewController.m
//  Recipe 10-2 Recording Audio
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
    
    self.session = [AVAudioSession sharedInstance];
    [self.session setActive:YES error:nil];
    
    NSError *error;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    

    self.recordedFilePath = [[NSString alloc] initWithFormat:@"%@%@",
                             NSTemporaryDirectory(), @"recording.wav"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:self.recordedFilePath];

    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:nil error:&error];
    if (error)
    {
        NSLog(@"Error initializing recorder: %@", error);
    }
    self.recorder.meteringEnabled = YES;
    self.recorder.delegate = self;
    [self.recorder prepareToRecord];
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self
                                   selector:@selector(updateLabels) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)toggleRecording:(id)sender
{
    
    if ([self.recorder isRecording])
    {
        [self.recorder stop];
        [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
    }
    else
    {
        [self.session requestRecordPermission:^(BOOL granted) {
            
            if(granted)
            {
            [self.recorder record];
            [self.recordButton setTitle:@"Stop" forState:UIControlStateNormal];
            }
            else
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recording Permission Denied" message:@"Verify microphone access is turned on in Settings->Privacy->Microphone" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];

    }
}

- (IBAction)togglePlaying:(id)sender
{
    if (self.player.playing)
    {
        [self.player pause];
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    else if (_newRecordingAvailable)
    {
        NSURL *url = [[NSURL alloc] initFileURLWithPath:self.recordedFilePath];
        NSError *error;
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if (!error)
        {
            self.player.delegate = self;
            [self.player play];
        }
        else
        {
            NSLog(@"Error initializing player: %@", error);
        }
        [self.playButton setTitle:@"Pause" forState:UIControlStateNormal];
        _newRecordingAvailable = NO;
    }
    else if (self.player)
    {
        [self.player play];
        [self.playButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

#pragma mark - private methods

-(void)updateLabels
{
    [self.recorder updateMeters];
    self.averageLabel.text =
    [NSString stringWithFormat:@"%f", [self.recorder averagePowerForChannel:0]];
    self.peakLabel.text =
    [NSString stringWithFormat:@"%f", [self.recorder peakPowerForChannel:0]];
}

#pragma mark - delegate methods

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    _newRecordingAvailable = flag;
    [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
    NSLog(@"Did finish recording: %hhd",_newRecordingAvailable);
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    if (flags == AVAudioSessionInterruptionOptionShouldResume)
    {
        [player play];
    }
}

- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags
{
    if (flags == AVAudioSessionInterruptionOptionShouldResume)
    {
        [recorder record];
    }
}


@end
