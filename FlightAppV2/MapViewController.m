//
//  MapViewController.m
//  FlightApp
//
//  Created by Edward Akoto on 12/5/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"
#import "MapAnnotation.h"
#import "WeatherAnnotationView.h"
#import <QuartzCore/QuartzCore.h>


@interface MapViewController ()

@property (nonatomic, retain) MapAnnotation *calloutAnnotation;

@end

@implementation MapViewController

@synthesize arrivalDelay, departurePrediction,destinationPrediction, rainImage;
@synthesize calloutAnnotation = _calloutAnnotation;
@synthesize displayView, realTimeLabel, poweredBySAPLabel, flightInformationLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
              
    }
    return self;
}

- (void)viewDidLoad
{
    displayView.layer.cornerRadius = 5;
    displayView.layer.masksToBounds = YES;
    
    realTimeLabel.font = [UIFont italicSystemFontOfSize:20.0f];
    poweredBySAPLabel.font = [UIFont italicSystemFontOfSize:18.0f];
   


    CLLocationCoordinate2D locationDeparture;
    locationDeparture.latitude = 33.920570;
    locationDeparture.longitude = -111.9260460;


    CLLocationCoordinate2D locationArrival;
    locationArrival.longitude = -74.95576290;
    locationArrival.latitude = 40.13799190;
    
       
    MapAnnotation *annotation1 = [[MapAnnotation alloc] initWithCoordinate: locationDeparture];

    MapAnnotation *annotation2 = [[MapAnnotation alloc] initWithCoordinate: locationArrival];
    
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = (locationDeparture.latitude + locationArrival.latitude) /2.0f;
    region.center.longitude = (locationDeparture.longitude + locationArrival.longitude) /2.0f ;
    
    region.span.latitudeDelta = fabs(locationDeparture.latitude - locationArrival.latitude)*2;
    region.span.longitudeDelta = fabs(locationDeparture.longitude-locationArrival.longitude)*2;
    [mapView setRegion:region];
    
    annotation1.title = @"PHX";
    annotation1.weatherCode = @"sunny";
    annotation1.subTitle = @"Delay 5 hours";
    annotation2.title = @"PHL";
    annotation2.weatherCode = @"rain";
    annotation2.subTitle = @"Delay 6 hours";
    [mapView setRegion:region animated:YES];

        
    [mapView addAnnotation:annotation1];
    //[mapView selectAnnotation:annotation1 animated:NO];
    [annotation1 release];
    
    
    [mapView addAnnotation:annotation2];
    //[mapView selectAnnotation:annotation2 animated:NO];
    [annotation2 release];
    
//    
//    CLLocationCoordinate2D locationDeparture;
//    locationDeparture.latitude = 33.920570;
//    locationDeparture.longitude = -111.9260460;
//    
//    
//    CLLocationCoordinate2D locationArrival;
//    locationArrival.longitude = -74.95576290;
//    locationArrival.latitude = 40.13799190;
    
    
    NSInteger numberOfSteps = 2;
    CLLocationCoordinate2D coordinates[2];
    
    
    
    coordinates[0] = locationDeparture;
    coordinates[1] = locationArrival;
    
    
    
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
    [mapView addOverlay:polyline];
    
    [mapView setDelegate:self];
      

    [super viewDidLoad];   
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}


- (void)dealloc {
 
    [super dealloc];
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    self.calloutAnnotation = [[MapAnnotation alloc] init];
	NSLog(@"TEST did Select");
	[mapView addAnnotation:self.calloutAnnotation];
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
	NSLog(@"TEST did DeSelect");
    if (self.calloutAnnotation && view.annotation == self.calloutAnnotation) {
        
        [mapView removeAnnotation: self.calloutAnnotation];
	}
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    WeatherAnnotationView *pin = (WeatherAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[annotation title]];
    
    if (pin == nil) {
        pin = [[[WeatherAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[annotation title]] autorelease];
        MapAnnotation *travellerAnnotation = (MapAnnotation *)annotation;
        [pin setImage: travellerAnnotation.weatherCode];
        [pin setTitle: travellerAnnotation.title];
        [pin setSubTitle:travellerAnnotation.subTitle];
    }else {
        pin.annotation = annotation;
    }
    return pin;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id < MKOverlay >)overlay{
    
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.lineWidth = 10.0;
    polylineView.strokeColor = [UIColor orangeColor];
    [polylineView setFillColor:[UIColor orangeColor]];
    
    return [polylineView autorelease];
    
}
@end
