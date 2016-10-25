//
//  MyDocument.m
//  Recipe 15-5 Storing UIDocuments in iCloud
//
//  Created by joseph hoffman on 9/5/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
    if (!self.text)
        self.text = @"";
    return [self.text dataUsingEncoding:NSUTF8StringEncoding];
}
-(BOOL) loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
    if ([contents length] > 0)
    {
        self.text = [[NSString alloc] initWithBytes:[contents bytes] length:[contents length] encoding:NSUTF8StringEncoding];
    }
    else
    {
        self.text = @"";
    }
    
    [self.delegate documentDidChange:self];
    
    return YES;
}


@end
