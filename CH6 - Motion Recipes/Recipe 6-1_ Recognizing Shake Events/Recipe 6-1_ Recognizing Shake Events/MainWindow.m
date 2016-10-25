//
//  MainWindow.m
//  Recipe 6-1: Recognizing Shake Events
//
//  Created by joseph hoffman on 8/8/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "MainWindow.h"

@implementation MainWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - delegate

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_SHAKE"
                                                            object:self];
    }
}

@end
