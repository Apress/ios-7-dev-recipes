//
//  DetailedViewController.h
//  Recipe 7-3:Creating Custom Annotations
//
//  Created by joseph hoffman on 8/10/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAnnotation.h"

@interface DetailedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactInformationLabel;

@property (strong, nonatomic) MyAnnotation *annotation;

-(id)initWithAnnotation:(MyAnnotation *)annotation;
@end
