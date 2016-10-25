//
//  GraphicsRecipesView.m
//  Recipe 12-1 Drawing Simple Shapes
//
//  Created by joseph hoffman on 8/29/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "GraphicsRecipesView.h"

@implementation GraphicsRecipesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Call function to draw rectangle
    [self drawRectangleAtTopOfScreen:context];
    
    //call function to draw circle
    [self drawEllipse:context];
    
}

-(void)drawRectangleAtTopOfScreen:(CGContextRef)context
{
    
    CGContextSaveGState(context);
    //Set color of current context
    [[UIColor lightGrayColor] set];
    
    //Draw rectangle
    CGRect drawingRect = CGRectMake(0.0, 0.0f, 320.0f, 60.0f);
    CGContextFillRect(context, drawingRect);
    CGContextRestoreGState(context);
    
}

-(void)drawEllipse:(CGContextRef)context
{
    
    CGContextSaveGState(context);
    
    //Set color of current context
    [[UIColor whiteColor] set];
    
    //Draw ellipse <- I know we’re drawing a circle, but a circle is just a special ellipse.
    CGRect ellipseRect = CGRectMake(60.0f, 150.0f, 200.0f, 200.0f);
    CGContextFillEllipseInRect(context, ellipseRect);
    CGContextRestoreGState(context);
    
}


@end
