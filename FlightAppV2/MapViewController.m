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

@synthesize arrivalDelay, departurePrediction,destinationPrediction;

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
    
    MKCoordinateRegion region;
    region.center.latitude = 37.3305262;
    region.center.longitude = -122.0290935;
    region.span.latitudeDelta = 0.1;
    region.span.longitudeDelta = 0.1;
    [mapView setRegion:region animated:YES];
    
    MapAnnotation *annotation = [[MapAnnotation alloc] init];
    annotation.title = @"From here";
    annotation.subTitle =@"Weather";
    annotation.coordinate = region.center;
    
    
    [mapView addAnnotation:annotation];
   
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
   
    [super dealloc];
}
@end
