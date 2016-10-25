//
//  ViewController.h
//  Recipe 9-2 Recording videos
//
//  Created by joseph hoffman on 8/21/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) NSString *pathToRecordedVideo;

- (IBAction)takePicture:(id)sender;

@end
