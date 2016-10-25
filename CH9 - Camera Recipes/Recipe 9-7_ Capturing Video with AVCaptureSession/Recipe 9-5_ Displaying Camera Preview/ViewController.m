//
//  ViewController.m
//  Recipe 9-7 Capturing Video with AVCaptureSession
//
//  Created by joseph hoffman on 8/22/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
 
        [super viewDidLoad];
        self.captureSession = [[AVCaptureSession alloc] init];
        //Optional: self.captureSession.sessionPreset = AVCaptureSessionPresetMedium;
        
        AVCaptureDevice *videoDevice =
        [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDevice *audioDevice =
        [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
        NSLog(@"%@",videoDevice.description);
    
        NSError *error = nil;
    
        self.videoInput =
        [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
        self.audioInput =
        [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:&error];
    

        if (self.videoInput)
        {
            
            self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
            NSDictionary *stillImageOutputSettings = [[NSDictionary alloc]
                                                      initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
            [self.stillImageOutput setOutputSettings:stillImageOutputSettings];
            
            self.movieOutput = [[AVCaptureMovieFileOutput alloc] init];
            
            // Setup capture session for taking pictures
            [self.captureSession addInput:self.videoInput];
            [self.captureSession addOutput:self.stillImageOutput];
        }
        else
        {
            NSLog(@"Video Input Error: %@", error);
        }
        if (!self.videoInput)
        {
            NSLog(@"Audio Input Error: %@", error);
        }
    

        

        
        AVCaptureVideoPreviewLayer *previewLayer =
        [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        UIView *aView = self.view;
        previewLayer.frame =
        CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-140);
        [aView.layer addSublayer:previewLayer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.captureSession startRunning];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.captureSession stopRunning];
}


- (IBAction)capture:(id)sender
{
    if(self.modeControl.selectedSegmentIndex == 0)
    {
        //picture mode
        [self captureStillImage];
        
    }
    else
    {
        //Video Mode
        if (self.movieOutput.isRecording == YES)
        {
            [self.captureButton setTitle:@"Capture" forState:UIControlStateNormal];
            [self.movieOutput stopRecording];
        }
        else
        {
            [self.captureButton setTitle:@"Stop" forState:UIControlStateNormal];
            [self.movieOutput startRecordingToOutputFileURL:[self tempFileURL]
                                          recordingDelegate:self];
        }
    }
}

- (IBAction)updateMode:(id)sender
{
    [self.captureSession stopRunning];
    if (self.modeControl.selectedSegmentIndex == 0)
    {
        // Still Image Mode
        if (self.movieOutput.isRecording == YES)
        {
            [self.movieOutput stopRecording];
        }
        [self.captureSession removeInput:self.audioInput];
        [self.captureSession removeOutput:self.movieOutput];
        [self.captureSession addOutput:self.stillImageOutput];
    }
    else
    {
        if([self.captureSession canAddInput:self.audioInput])
        {
            // Video Mode
            [self.captureSession removeOutput:self.stillImageOutput];
            [self.captureSession addInput:self.audioInput];
            [self.captureSession addOutput:self.movieOutput];
        
            // Set orientation of capture connections to portrait
            NSArray *array = [[self.captureSession.outputs objectAtIndex:0] connections];
            for (AVCaptureConnection *connection in array)
            {
                connection.videoOrientation = AVCaptureVideoOrientationPortrait;
            }
        }
        else
        {
            self.modeControl.selectedSegmentIndex = 0;
            NSLog(@"User turned off access to microphone");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't Access Audio" message:@"Verify microphone access is turned on in Settings->Privacy->Microphone" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
    }
    [self.captureButton setTitle:@"Capture" forState:UIControlStateNormal];
    
    [self.captureSession startRunning];
}

- (void) captureStillImage
{
    AVCaptureConnection *stillImageConnection =
    [self.stillImageOutput.connections objectAtIndex:0];
    if ([stillImageConnection isVideoOrientationSupported])
        [stillImageConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    [self.stillImageOutput
     captureStillImageAsynchronouslyFromConnection:stillImageConnection
     completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error)
     {
         if (imageDataSampleBuffer != NULL)
         {
             NSData *imageData = [AVCaptureStillImageOutput
                                  jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
             ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
             UIImage *image = [[UIImage alloc] initWithData:imageData];
             [library writeImageToSavedPhotosAlbum:[image CGImage]
                                       orientation:(ALAssetOrientation)[image imageOrientation]
                                   completionBlock:^(NSURL *assetURL, NSError *error)
              {
                  UIAlertView *alert;
                  if (!error)
                  {
                      alert = [[UIAlertView alloc] initWithTitle:@"Photo Saved"
                                                         message:@"The photo was successfully saved to your photos library"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
                  }
                  else
                  {
                      alert = [[UIAlertView alloc] initWithTitle:@"Error Saving Photo"
                                                         message:@"The photo was not saved to you photos library"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
                  }
                  
                  [alert show];
              }
              ];
         }
         else
         {
             NSLog(@"Error capturing still image: %@", error);
         }
     }
     ];
}

- (NSURL *) tempFileURL
{
    NSString *outputPath = [[NSString alloc] initWithFormat:@"%@%@",
                            NSTemporaryDirectory(), @"output.mov"];
    NSURL *outputURL = [[NSURL alloc] initFileURLWithPath:outputPath];
    NSFileManager *manager = [[NSFileManager alloc] init];
    if ([manager fileExistsAtPath:outputPath])
    {
        [manager removeItemAtPath:outputPath error:nil];
    }
    return outputURL;
}

#pragma mark - Delegate Methods

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput
didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
      fromConnections:(NSArray *)connections
                error:(NSError *)error
{
    BOOL recordedSuccessfully = YES;
    if ([error code] != noErr)
    {
        // A problem occurred: Find out if the recording was successful.
        id value = [[error userInfo]
                    objectForKey:AVErrorRecordingSuccessfullyFinishedKey];
        if (value)
            recordedSuccessfully = [value boolValue];
        // Logging the problem anyway:
        NSLog(@"A problem occurred while recording: %@", error);
    }
    if (recordedSuccessfully)
    {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        
        [library writeVideoAtPathToSavedPhotosAlbum:outputFileURL
                                    completionBlock:^(NSURL *assetURL, NSError *error)
         {
             UIAlertView *alert;
             if (!error)
             {
                 alert = [[UIAlertView alloc] initWithTitle:@"Video Saved"
                                                    message:@"The movie was successfully saved to you photos library"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
             }
             else
             {
                 alert = [[UIAlertView alloc] initWithTitle:@"Error Saving Video"
                                                    message:@"The movie was not saved to you photos library"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
             }
             
             [alert show];
         }
         ];
    }
}




@end
