//
//  ViewController.m
//  Recipe 13-1 View Animation Using UIKit
//
//  Created by joseph hoffman on 9/15/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //Create ball image and add it to the view
    UIImage *blueBallImage = [[UIImage alloc] init];
    blueBallImage = [UIImage imageNamed:@"Ball"];
    self.blueBall = [[UIImageView alloc] initWithImage:blueBallImage];
    self.blueBall.frame = CGRectMake(self.view.frame.size.width/2-5,
                                     20.0f,
                                     10.0f,
                                     10.0f);
    self.blueBall.alpha = 0.0f;
    
    [self.view addSubview:self.blueBall];
    

    [UIView animateWithDuration:3.0f
                     animations:^{
                         self.blueBall.frame = CGRectMake(self.view.frame.size.width/2-32.0f,
                                                          self.view.frame.size.height/2 -32.0f,
                                                          64.0f,
                                                          64.0f);
                         self.blueBall.alpha = 1.0f;
                         
    
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"Animation Finished");
                         [self startRotationOfBall];
                     }];
     

}

-(void)startRotationOfBall
{
    
    [UIView animateWithDuration:1.5f
                     animations:^{
                         self.blueBall.transform = CGAffineTransformMakeRotation(M_PI);
                     }
                     completion:^(BOOL finished) {
                         NSLog(@"Rotation Finished");
                     }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
