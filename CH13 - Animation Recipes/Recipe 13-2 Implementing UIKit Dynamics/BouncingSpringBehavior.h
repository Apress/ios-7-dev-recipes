//
//  BouncingSpringBehavior.h
//  Recipe 13-2 Implementing UIKit Dynamics
//
//  Created by joseph hoffman on 9/19/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BouncingSpringBehavior : UIDynamicBehavior

-(instancetype)initWithItems:(NSArray *)items withAnchorPoint:(NSString *)anchorPointString;


@end
