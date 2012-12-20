//
//  MapAnnotation.h
//  FlightAppV2
//
//  Created by Edward Akoto on 12/6/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface MapAnnotation : NSObject <MKAnnotation>{
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    int weatherCode;
    
    
}
//- (MKMapRect)boundingMapRect;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (readwrite, assign) int weatherCode;
@end
