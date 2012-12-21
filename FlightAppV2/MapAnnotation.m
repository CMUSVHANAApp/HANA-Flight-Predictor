//
//  MapAnnotation.m
//  FlightAppV2
//
//  Created by Edward Akoto on 12/6/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation

@synthesize title, subTitle, coordinate, weatherCode;

-(void) dealloc{
    [title release];
    [subTitle release];
    [super dealloc];
}
-(id) initWithCoordinate: (CLLocationCoordinate2D) the_coordinate
{
    if (self = [super init])
    {
        coordinate = the_coordinate;
    }
    return self;
}
-(NSString*) getWeatherCode{
    return self.weatherCode;
}
@end
