//
//  ViewController.m
//  Recipe 9-10 Capturing Machine Readable Codes
//
//  Created by joseph hoffman on 8/25/13.
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
    
    self.metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:self.metadataOutput];
    
    [self.metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeQRCode];
    
    
    AVCaptureVideoPreviewLayer *previewLayer =
    [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    UIView *aView = self.view;
    previewLayer.frame =
    CGRectMake(0, 20, self.view.frame.size.width,
               self.view.frame.size.height-100);
    [aView.layer addSublayer:previewLayer];
    

}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.captureSession stopRunning];
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


#pragma mark - delegate methods

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    for (AVMetadataMachineReadableCodeObject *object in metadataObjects) {

        
        self.codeLabel.text = [NSString stringWithFormat:@" Type - %@: Value - %@",object.type,object.stringValue];
    }
    

    
}

@end
