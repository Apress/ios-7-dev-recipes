//
//  MyDocument.h
//  Recipe 15-5 Storing UIDocuments in iCloud
//
//  Created by joseph hoffman on 9/5/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyDocument;

@protocol MyDocumentDelegate <NSObject>
- (void)documentDidChange:(MyDocument*)document;
@end

@interface MyDocument : UIDocument

@property (strong, nonatomic) NSString *text;
@property (weak, nonatomic) id<MyDocumentDelegate> delegate;

@end
