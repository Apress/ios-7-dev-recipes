//
//  MyLogActivity.m
//  Recipe 8-1: Sharing content with the Activity VIew
//
//  Created by joseph hoffman on 8/14/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "MyLogActivity.h"

@implementation MyLogActivity


-(NSString *)activityType
{
    return @"MyLogActivity";
}

-(NSString *)activityTitle
{
    return @"Log";
}

-(UIImage *)activityImage
{
    // Replace the file name with the one of the file you imported into your project
    return [UIImage imageNamed:@"nscup.png"];
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (NSObject *item in activityItems)
    {
        if (![item isKindOfClass:[NSString class]] && ![item isKindOfClass:[NSURL class]])
        {
            return NO;
        }
    }
    return YES;
}

-(void)prepareWithActivityItems:(NSArray *)activityItems
{
    self.logMessage = @"";
    for (NSObject *item in activityItems)
    {
        self.logMessage = [NSString stringWithFormat:@"%@\n%@",
                           self.logMessage, item];
    }
}

-(void)performActivity
{
    NSLog(@"%@", self.logMessage);
    [self activityDidFinish:YES];
}




@end
