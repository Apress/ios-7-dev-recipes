//
//  ViewController.h
//  14-3 Displaying Events in a Table View
//
//  Created by joseph hoffman on 8/30/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,EKEventEditViewDelegate>

@property (strong, nonatomic) EKEventStore *eventStore;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;
@property (nonatomic, strong) NSMutableDictionary *events;
@property (nonatomic, strong) NSArray *calendars;

@end
