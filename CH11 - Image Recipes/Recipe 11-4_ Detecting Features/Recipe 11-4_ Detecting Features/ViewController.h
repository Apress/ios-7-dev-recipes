//
//  ViewController.h
//  Recipe 11-4: Detecting Features
//
//  Created by joseph hoffman on 9/12/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UIButton *findFaceButton;

- (IBAction)findFace:(id)sender;
@end
