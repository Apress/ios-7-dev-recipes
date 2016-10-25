//
//  DTPageRenderer.h
//  Recipe 16-6 Formatted Printing with Page Renderers
//
//  Created by joseph hoffman on 9/8/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTPageRenderer : UIPrintPageRenderer

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;




@end
