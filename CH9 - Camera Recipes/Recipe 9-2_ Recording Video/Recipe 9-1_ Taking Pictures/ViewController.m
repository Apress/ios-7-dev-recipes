//
//  ViewController.m
//  Recipe 9-2 Recording videos
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
        self.imagePicker.allowsEditing = YES;
    }
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
}

- (IBAction)editVideo:(id)sender {
}

#pragma mark - delegate methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    if (CFStringCompare((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        NSString *moviePath = (NSString *)[[info objectForKey: UIImagePickerControllerMediaURL] path];
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath))
        {
            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
        }
    }
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    UIImageWriteToSavedPhotosAlbum (image, nil, nil , nil);
    self.imageView.image = image;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
