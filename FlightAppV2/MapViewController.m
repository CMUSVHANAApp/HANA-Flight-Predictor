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

@end

@implementation MapViewController

@synthesize arrivalDelay, departurePrediction,destinationPrediction, rainImage;

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
    [super viewDidLoad];
    
    MapAnnotation *annotation1 = [[MapAnnotation alloc] init];
    
    MapAnnotation *annotation2 = [[MapAnnotation alloc] init];
    
    MKCoordinateRegion region;
 
    
    double latA = annotation1.coordinate.latitude;
    double latB = annotation2.coordinate.latitude;
    
    double longA = annotation1.coordinate.longitude;
    double longB = annotation2.coordinate.longitude;
    
    region.center.latitude = (latA+latB)/2.0;
    region.center.longitude = (longA+longB)/2.0;
    
    region.span.latitudeDelta = (latA-latB)*2;
    region.span.longitudeDelta = (longA-longB)*2;
  
    annotation1.title = @"Departure city";
    annotation2.title = @"Destination city";
        
    [mapView addAnnotation:annotation1];
    [annotation1 release];
    
    
    [mapView addAnnotation:annotation2];
    [annotation2 release];

   
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
 
    [super dealloc];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    MKAnnotationView *pin = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[annotation title]];
    
    if (pin == nil) {
        pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[annotation title]] autorelease];
    }else {
        pin.annotation = annotation;
    }
    
    int weatherType = arc4random() % (10)+1;
    
    if((weatherType %2) == 0){
        pin.image = [UIImage imageNamed:@"weather_few_clouds.png"];
  
    }else{
         pin.image = [UIImage imageNamed:@"weather_128.png"];
    }
      
    
    //pin.pinColor = MKPinAnnotationColorGreen;
    
  
    
    pin.canShowCallout = FALSE;
    return pin;
}


@end
