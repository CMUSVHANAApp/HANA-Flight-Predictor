//
//  MapViewController.h
//  FlightApp
//
//  Created by Edward Akoto on 12/5/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapViewController : ViewController <MKMapViewDelegate>{
  IBOutlet MKMapView *mapView;
    
}
@property (retain, nonatomic) IBOutlet UILabel *flightInformationLabel;
@property (retain, nonatomic) IBOutlet UILabel *poweredBySAPLabel;


@property (retain, nonatomic) IBOutlet UILabel *realTimeLabel;


@property (retain, readwrite) IBOutlet UILabel *arrivalDelay;
@property (strong, nonatomic) IBOutlet UILabel *departurePrediction;
@property (strong, nonatomic) IBOutlet UILabel *destinationPrediction;
@property (retain, nonatomic) IBOutlet UILabel *airlineLabel;
@property (retain, nonatomic) IBOutlet UILabel *flightNumberLabel;
@property (retain, nonatomic) IBOutlet UIView *displayView;


@property (retain, nonatomic) IBOutlet UIImageView *rainImage;

-(IBAction)drawRoute;

@end
