//
//  MapViewController.h
//  FlightApp
//
//  Created by Edward Akoto on 12/5/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//

#import "ViewController.h"

@interface MapViewController : ViewController{
 
    
}



@property (retain, readwrite) IBOutlet UILabel *arrivalDelay;
@property (strong, nonatomic) IBOutlet UILabel *departurePrediction;
@property (strong, nonatomic) IBOutlet UILabel *destinationPrediction;

@end
