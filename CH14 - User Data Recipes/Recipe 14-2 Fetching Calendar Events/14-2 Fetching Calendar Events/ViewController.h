//
//  ViewController.h
//  14-2 Fetching Calendar Events
//
//  Created by joseph hoffman on 8/30/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) EKEventStore *eventStore;

@end
