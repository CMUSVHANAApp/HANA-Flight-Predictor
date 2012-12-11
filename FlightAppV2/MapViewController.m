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

@interface MapViewController ()

@property (nonatomic, retain) MapAnnotation *calloutAnnotation;

@end

@implementation MapViewController

@synthesize arrivalDelay, departurePrediction,destinationPrediction, rainImage;
@synthesize calloutAnnotation = _calloutAnnotation;

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


    CLLocationCoordinate2D locationDeparture;
    locationDeparture.latitude = 33.920570;
    locationDeparture.longitude = -111.9260460;


    CLLocationCoordinate2D locationArrival;
    locationArrival.longitude = -74.95576290;
    locationArrival.latitude = 40.13799190;
    
    
    MapAnnotation *annotation1 = [[MapAnnotation alloc] initWithCoordinate: locationDeparture];

    MapAnnotation *annotation2 = [[MapAnnotation alloc] initWithCoordinate: locationArrival];
    
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = (locationDeparture.latitude + locationArrival.latitude) /2 ;
    region.center.longitude = (locationDeparture.longitude + locationArrival.longitude) /2;
    
    region.span.latitudeDelta = fabs(locationDeparture.latitude - locationArrival.latitude)*2;
    region.span.longitudeDelta = fabs(locationDeparture.longitude-locationArrival.longitude)*2;
  
    annotation1.title = @"Phoenix";
    annotation1.weatherCode = @"sunny";
    annotation1.subTitle = @"Sunny";
    annotation2.title = @"Philadelphia";
    annotation2.weatherCode = @"rain";
    annotation2.subTitle = @"Rain";
    [mapView setRegion:region animated:YES];

        
    [mapView addAnnotation:annotation1];
    [mapView selectAnnotation:annotation1 animated:YES];
    [annotation1 release];
    
    
    [mapView addAnnotation:annotation2];
    [mapView selectAnnotation:annotation2 animated:YES];
    [annotation2 release];
    


    
    [mapView setRegion:region];
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
	
	[mapView addAnnotation:self.calloutAnnotation];
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
	if (self.calloutAnnotation && view.annotation == self.calloutAnnotation) {
		[mapView removeAnnotation: self.calloutAnnotation];
	}
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    MKAnnotationView *pin = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[annotation title]];
    
    if (pin == nil) {
        pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[annotation title]] autorelease];
        MapAnnotation *travellerAnnotation = (MapAnnotation *)annotation;
        if(travellerAnnotation.weatherCode == @"sunny"){
            UIImageView *imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"weather_few_clouds.png"]];
            pin.leftCalloutAccessoryView = imageView;
        }
        else{
            UIImageView *imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"weather_128.png"]];
            pin.leftCalloutAccessoryView = imageView;
        }
    }else {
        pin.annotation = annotation;
    }
    pin.canShowCallout = TRUE;
    return pin;
}
@end
