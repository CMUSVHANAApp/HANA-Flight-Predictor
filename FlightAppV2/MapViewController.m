//
//  MapViewController.m
//  FlightApp
//
//  Created by Edward Akoto on 12/5/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"

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
    // Do any additional setup after loading the view from its nib.
    
//    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    
//    self.arrivalDelay.text = appDelegate.arrivalDelay.text;
   //self.departurePrediction.text = @"Modified";
    
   
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
