//
//  AppDetails.m
//  Recipe 2-1 to 2-2 About Us
//

#import "AppDetails.h"

@implementation AppDetails


-(id)initWithName:(NSString *)name description:(NSString *)descr
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.description = descr;
    }
    return self;
}

@end
