//
//  GraphicsRecipesView.m
//  Recipe 12-6 Clipping a Drawing to a Mask
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
    
    //call function to draw triangle
    [self drawTriangle:context];
    
    //call function to draw arc
    [self drawArc:context];
    
    //call function to draw text
    [self drawTextAtTopOfScreen:context];
    
    //call function to draw ellipse filled with a gradient
    [self drawEllipseWithGradient:context];
    

    
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
    
    //Set shadow and color of shadow
    CGContextSetShadowWithColor(context, CGSizeZero, 10.0f, [[UIColor blackColor] CGColor]);
    
    //Draw ellipse <- I know we’re drawing a circle, but a circle is just a special ellipse.
    CGRect ellipseRect = CGRectMake(60.0f, 150.0f, 200.0f, 200.0f);
    CGContextFillEllipseInRect(context, ellipseRect);
    CGContextRestoreGState(context);
    
}

-(void)drawTriangle:(CGContextRef)context
{
    
    CGContextSaveGState(context);
    
    //Set color of current context
    [[UIColor colorWithRed:0.80f
                     green:0.85f
                      blue:0.95f
                     alpha:1.0f] set];
    
    // Draw Triangle
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 140.0f, 380.0f);
    CGContextAddLineToPoint(context, 190.0f, 400.0f);
    CGContextAddLineToPoint(context, 140.0f, 420.0f);
    CGContextClosePath(context);
    CGContextSetGrayFillColor(context, 0.1f, 0.85f);
    CGContextSetGrayStrokeColor(context, 0.0, 0.0);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
}

-(void)drawArc:(CGContextRef)context
{
    
    CGContextSaveGState(context);
    
    //Set color of current context
    [[UIColor colorWithRed:0.30f
                     green:0.30f
                      blue:0.30f
                     alpha:1.0f] set];
    
    //Draw Arc
    CGContextAddArc(context, 160.0f, 250.0f, 70.0f, 0.0f, 3.14, 0);
    CGContextSetLineWidth(context, 50.0f);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);
}

-(void)drawTextAtTopOfScreen:(CGContextRef)context{
    
    CGContextSaveGState(context);
    
    //Create UIColor to pass into text attributes
    UIColor *textColor = [UIColor colorWithRed:0.80f
                     green:0.85f
                      blue:0.95f
                     alpha:1.0f];
    
    //Set shadow and color of shadow
    CGContextSetShadowWithColor(context, CGSizeZero, 10.0f, [[UIColor blackColor] CGColor]);
    
    //Set font
    UIFont *customFont = [UIFont fontWithName:@"OleoScriptSwashCaps-Bold" size:40.0f ];
    //UIFont *customFont = [UIFont systemFontOfSize:20.0f];
    NSString *titleText = @"iOS Recipes!";
    

    [titleText drawAtPoint:CGPointMake(55,5) withAttributes:@{NSFontAttributeName:customFont,
                                                              NSForegroundColorAttributeName:textColor}];
    CGContextRestoreGState(context);

    
}
-(void)drawGradient:(CGContextRef)context{
    
    //Define start and end colors
    CGFloat colors [8] = {
        0.0, 0.0, 1.0, 1.0, // Blue
        0.0, 1.0, 0.0, 1.0 }; //Green
    
    //Setup a color space and gradient space
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    
    //Define the gradient direction
    CGPoint startPoint = CGPointMake(160.0f,100.0f);
    CGPoint endPoint = CGPointMake(160.0f, 360.0f);
    
    //Create and Draw the gradient
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
}

-(void)drawEllipseWithGradient:(CGContextRef)context{
    
    CGContextSaveGState(context);
    
    //UIGraphicsBeginImageContextWith(self.frame.size);
    UIGraphicsBeginImageContextWithOptions((self.frame.size), NO, 0.0);
    
    CGContextRef newContext = UIGraphicsGetCurrentContext();
    
    // Translate and scale image to compnesate for Quartz's inverted coordinate system
    CGContextTranslateCTM(newContext,0.0,self.frame.size.height);
    CGContextScaleCTM(newContext, 1.0, -1.0);
    
    
    //Set color of current context
    [[UIColor blackColor] set];
    
    //Draw ellipse <- I know we’re drawing a circle, but a circle is just a special ellipse.
    CGRect ellipseRect = CGRectMake(110.0f, 200.0f, 100.0f, 100.0f);
    CGContextFillEllipseInRect(newContext, ellipseRect);
    
    CGImageRef mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    
    
    CGContextClipToMask(context, self.bounds, mask);
    
    [self drawGradient:context];
    
    CGContextRestoreGState(context);
    
    
}

@end
