//
//  ViewController.m
//  Recipe 2-3: Coding Autolayout
//
//  Created by joseph hoffman on 7/5/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.addButton = [self addButtonWithTitle:@"Add" action:@selector(addImageView)];
    self.removeButton = [self addButtonWithTitle:@"Remove" action:@selector(removeImageView)];
    self.clearButton = [self addButtonWithTitle:@"Clear" action:@selector(clearImageViews)];
    
    NSDictionary *viewsDictionary =
    [[NSDictionary alloc] initWithObjectsAndKeys:
     self.addButton, @"addButton",
     self.removeButton, @"removeButton",
     self.clearButton, @"clearButton", nil];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[addButton]-[removeButton]-[clearButton]"
                               options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-[addButton]"
                               options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-[removeButton]"
                               options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-[clearButton]"
                               options:0 metrics:nil views:viewsDictionary]];
    
    self.imageViews = [[NSMutableArray alloc]initWithCapacity:10];
    self.imageViewConstraints = [[NSMutableArray alloc]initWithCapacity:10];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIButton *)addButtonWithTitle:(NSString *)title action:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    return button;
}
- (void)addImageView
{
    UIImage *image = [UIImage imageNamed:@"sweflag"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imageViews addObject:imageView];
    
    [self rebuildImageViewsConstraints];
}

- (void)removeImageView
{
    if (self.imageViews.count > 0)
    {
        [self.imageViews.lastObject removeFromSuperview];
        [self.imageViews removeLastObject];
        [self rebuildImageViewsConstraints];
    }
}

- (void)clearImageViews
{
    if (self.imageViews.count > 0)
    {
        for (int i=self.imageViews.count - 1; i >= 0; i--)
        {
            UIImageView *imageView = [self.imageViews objectAtIndex:i];
            [imageView removeFromSuperview];
            [self.imageViews removeObjectAtIndex:i];
        }
        
        [self rebuildImageViewsConstraints];
    }
}
- (void)rebuildImageViewsConstraints
{
    [self.view removeConstraints:self.imageViewConstraints];
    [self.imageViewConstraints removeAllObjects];
    
    if (self.imageViews.count == 0)
        return;
    
    UIImageView *firstImageView = [self.imageViews objectAtIndex:0];
    
    // Pin first view to the top left corner
    NSDictionary *viewsDictionary =
    [[NSDictionary alloc] initWithObjectsAndKeys:
     self.addButton, @"firstButton",
     firstImageView, @"firstImageView", nil];
    
    [self.imageViewConstraints addObjectsFromArray:[NSLayoutConstraint
                                                    constraintsWithVisualFormat:@"H:|-[firstImageView(50)]"
                                                    options:0 metrics:nil views:viewsDictionary]];
    
    [self.imageViewConstraints addObjectsFromArray:[NSLayoutConstraint
                                                    constraintsWithVisualFormat:@"V:[firstButton]-[firstImageView(50)]"
                                                    options:0 metrics:nil views:viewsDictionary]];
    
    if (self.imageViews.count > 1)
    {
        UIImageView *previousImageView = firstImageView;
        
        for (int i=1; i < self.imageViews.count; i++)
        {
            UIImageView *imageView = [self.imageViews objectAtIndex:i];
            
            [self.imageViewConstraints addObject:[NSLayoutConstraint
                                                  constraintWithItem:imageView attribute:NSLayoutAttributeLeading
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:previousImageView attribute:NSLayoutAttributeLeading
                                                  multiplier:1 constant:10]];
            
            [self.imageViewConstraints addObject:[NSLayoutConstraint
                                                  constraintWithItem:imageView attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:previousImageView attribute:NSLayoutAttributeTop
                                                  multiplier:1 constant:10]];
            
            [self.imageViewConstraints addObject:[NSLayoutConstraint
                                                  constraintWithItem:imageView attribute:NSLayoutAttributeWidth
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:previousImageView attribute:NSLayoutAttributeWidth
                                                  multiplier:1.1 constant:0]];
            
            [self.imageViewConstraints addObject:[NSLayoutConstraint 
                                                  constraintWithItem:imageView attribute:NSLayoutAttributeHeight 
                                                  relatedBy:NSLayoutRelationEqual 
                                                  toItem:previousImageView attribute:NSLayoutAttributeHeight 
                                                  multiplier:1.1 constant:0]];
            
            previousImageView = imageView;
        }
        
    }
    
    [self.view addConstraints:self.imageViewConstraints];
}






@end
