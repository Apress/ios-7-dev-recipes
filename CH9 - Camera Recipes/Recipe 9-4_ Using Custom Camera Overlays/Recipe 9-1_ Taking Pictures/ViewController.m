//
//  ViewController.m
//  Recipe 9-4 Using Custom Camera Overlays
//
//  Created by joseph hoffman on 8/21/13.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (IBAction)takePicture:(id)sender {
    // Make sure camera is available
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Camera Unavailable"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (self.imagePicker == nil)
    {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.mediaTypes = [UIImagePickerController
                                       availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        // self.imagePicker.allowsEditing = YES;
        self.imagePicker.showsCameraControls = NO;
        self.imagePicker.cameraOverlayView =
        [self customViewForImagePicker:self.imagePicker];
    }
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
}

- (IBAction)editVideo:(id)sender
{
    if (self.pathToRecordedVideo)
    {
        UIVideoEditorController *editor = [[UIVideoEditorController alloc] init];
        editor.videoPath = self.pathToRecordedVideo;
        editor.delegate = self;
        [self presentViewController:editor animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"No Video Recorded Yet"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

#pragma mark - delegate methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    if (CFStringCompare((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        NSString *moviePath = (NSString *)[[info objectForKey: UIImagePickerControllerMediaURL] path];
        self.pathToRecordedVideo = moviePath;
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath))
        {
            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
        }
    }
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum (image, nil, nil , nil);
    self.imageView.image = image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)videoEditorController:(UIVideoEditorController *)editor didSaveEditedVideoToPath:(NSString *)editedVideoPath
{
    self.pathToRecordedVideo = editedVideoPath;
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (editedVideoPath))
    {
        UISaveVideoAtPathToSavedPhotosAlbum (editedVideoPath, nil, nil, nil);
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)videoEditorControllerDidCancel:(UIVideoEditorController *)editor
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(UIView *)customViewForImagePicker:(UIImagePickerController *)imagePicker;
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 280, 480)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *flashButton =
    [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 120, 44)];
    flashButton.backgroundColor = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5];
    [flashButton setTitle:@"Flash Auto" forState:UIControlStateNormal];
    [flashButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    flashButton.layer.cornerRadius = 10.0;
    
    UIButton *changeCameraButton =
    [[UIButton alloc] initWithFrame:CGRectMake(190, 10, 120, 44)];
    changeCameraButton.backgroundColor =
    [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5];
    [changeCameraButton setTitle:@"Rear Camera" forState:UIControlStateNormal];
    [changeCameraButton setTitleColor:[UIColor whiteColor]
                             forState:UIControlStateNormal];
    changeCameraButton.layer.cornerRadius = 10.0;
    
    UIButton *takePictureButton =
    [[UIButton alloc] initWithFrame:CGRectMake(100, 432, 120, 44)];
    takePictureButton.backgroundColor =
    [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.5];
    [takePictureButton setTitle:@"Click!" forState:UIControlStateNormal];
    [takePictureButton setTitleColor:[UIColor whiteColor]
                            forState:UIControlStateNormal];
    takePictureButton.layer.cornerRadius = 10.0;
    
    [flashButton addTarget:self action:@selector(toggleFlash:)
          forControlEvents:UIControlEventTouchUpInside];
    [changeCameraButton addTarget:self action:@selector(toggleCamera:)
                 forControlEvents:UIControlEventTouchUpInside];
    [takePictureButton addTarget:imagePicker action:@selector(takePicture)
                forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:flashButton];
    [view addSubview:changeCameraButton];
    [view addSubview:takePictureButton];
    
    return view;
}

-(void)toggleFlash:(UIButton *)sender
{
    if (self.imagePicker.cameraFlashMode == UIImagePickerControllerCameraFlashModeOff)
    {
        self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        [sender setTitle:@"Flash On" forState:UIControlStateNormal];
    }
    else
    {
        self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        [sender setTitle:@"Flash Off" forState:UIControlStateNormal];
    }
}

-(void)toggleCamera:(UIButton *)sender
{
    if (self.imagePicker.cameraDevice == UIImagePickerControllerCameraDeviceRear)
    {
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        [sender setTitle:@"Front Camera" forState:UIControlStateNormal];
    }
    else
    {
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        [sender setTitle:@"Rear Camera" forState:UIControlStateNormal];
    }
}


@end
