//
//  ErrorHandler.h
//  Recipe 1-9  Default Error Handling
//
//  Created by joseph hoffman on 6/26/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorHandler : NSObject <UIAlertViewDelegate>

@property (strong, nonatomic)NSError *error;
@property (nonatomic)BOOL fatalError;

-(id)initWithError:(NSError *)error fatal:(BOOL)fatalError;

+(void)handleError:(NSError *)error fatal:(BOOL)fatalError;


@end
