//
//  MapAnnotation.m
//  FlightAppV2
//
//  Created by Edward Akoto on 12/6/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation

@synthesize title, subTitle, coordinate;

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
/*
 -(id) init{
       
        //coordinate.latitude = 37.4000000+arc4random() % (10)+1;
        //coordinate.longitude = -122.0290935+arc4random() % (10)+1;
        
        //self.title = [dict objectForKey:@"name"];
        //self.title = [dict objectForKey:@"address"];
    
    return self;
}
*/



@end
