//
//  AppDelegate.m
//  Recipe 7-8:Registering a Routing App
//
//  Created by joseph hoffman on 8/11/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.


    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([MKDirectionsRequest isDirectionsRequestURL:url])
    {
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc]
                                        initWithContentsOfURL:url];
        
        MKMapItem *source = [request source];
        MKMapItem *destination = [request destination];

        NSString *sourceString;
        NSString *destinationString;
        
        if (source.isCurrentLocation)
            sourceString = @"Current Location";
        else
            sourceString = [NSString stringWithFormat:@"%f, %f",
                            source.placemark.location.coordinate.latitude,
                            source.placemark.location.coordinate.longitude];
        
        if (destination.isCurrentLocation)
            sourceString = @"Current Location";
        else
            destinationString = [NSString stringWithFormat:@"%f, %f",
                                 destination.placemark.location.coordinate.latitude,
                                 destination.placemark.location.coordinate.longitude];

        self.viewController= (ViewController*)self.window.rootViewController;
        self.viewController.routingLabel.text = [NSString stringWithFormat:@"Start at: %@\nStop at: %@",
         sourceString, destinationString];
        
     [self.viewController view];

        return YES;
    }
    
    return NO;
}

@end
