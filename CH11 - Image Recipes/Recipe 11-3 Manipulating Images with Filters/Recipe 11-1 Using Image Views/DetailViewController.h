//
//  DetailViewController.h
//  Recipe 11-3 Manipulating Images with Filters
//
//  Created by joseph hoffman on 8/29/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailViewControllerDelegateProtocol;

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate,
                                                    UIImagePickerControllerDelegate,
                                                    UINavigationControllerDelegate,
                                                    UIPopoverControllerDelegate>

@property (nonatomic, weak) id <DetailViewControllerDelegateProtocol> delegate;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) IBOutlet UIButton *selectImageButton;
@property (nonatomic, strong) IBOutlet UIButton *clearImageButton;

@property (strong, nonatomic) UIPopoverController *pop;

- (IBAction)selectImage:(id)sender;
- (IBAction)clearImage:(id)sender;

- (void)configureDetailsWithImage:(UIImage *)image label:(NSString *)label showsButtons:(BOOL)showsButton;

@end



@protocol DetailViewControllerDelegateProtocol <NSObject>

- (void)detailViewController:(DetailViewController *)controller didSelectImage:(UIImage *)image;
- (void)detailViewControllerDidClearImage:(DetailViewController *)controller;

@end