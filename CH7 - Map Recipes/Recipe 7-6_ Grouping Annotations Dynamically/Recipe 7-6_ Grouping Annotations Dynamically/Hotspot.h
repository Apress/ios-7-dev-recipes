//
//  Hotspot.h
//  Recipe 7-6: Grouping Annotations Dynamically
//
//  Created by joseph hoffman on 8/11/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Hotspot : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D _coordinate;
    NSString *_title;
    NSString *_subtitle;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) NSMutableArray *places;
@property (nonatomic, strong) MKPinAnnotationView *annotationView;

-(void)addPlace:(Hotspot *)hotspot;
-(int)placesCount;
-(void)cleanPlaces;


-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;

@end
