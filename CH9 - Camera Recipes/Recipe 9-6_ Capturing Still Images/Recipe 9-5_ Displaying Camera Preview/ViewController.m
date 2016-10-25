//
//  ViewController.m
//  Recipe 9-6 Capturing Still Images with AVCaptureSession
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
    // Do any additional setup after loading the view, typically from a nib.
    
    self.captureSession = [[AVCaptureSession alloc] init];
    //Optional: self.captureSession.sessionPreset = AVCaptureSessionPresetMedium;
    
    AVCaptureDevice *device =
    [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (self.videoInput)
    {
        [self.captureSession addInput:self.videoInput];
    }
    else
    {
        NSLog(@"Input Error: %@", error);
    }
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *stillImageOutputSettings =
    [[NSDictionary alloc] initWithObjectsAndKeys:
     AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:stillImageOutputSettings];
    [self.captureSession addOutput:self.stillImageOutput];
    
    AVCaptureVideoPreviewLayer *previewLayer =
    [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    UIView *aView = self.view;
    previewLayer.frame =
    CGRectMake(0, 20, self.view.frame.size.width,
               self.view.frame.size.height-70);
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


- (IBAction)capture:(id)sender {
        [self captureStillImage];
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
@end
