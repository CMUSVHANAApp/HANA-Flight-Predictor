//
//  ViewController.h
//  FlightApp
//
//  Created by Edward Akoto on 12/2/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    
  
    
        
    
}

@property (strong, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)grabURLInBackground:(id)sender;
- (IBAction)loadDefaults;

@property (nonatomic, retain) NSArray *jsonArray;


@property (retain, nonatomic) IBOutlet UITextField *airlineText;
@property (retain, nonatomic) IBOutlet UITextField *flightNumberText;
@property (retain, nonatomic) IBOutlet UITextField *departureAirportText;
@property (retain, nonatomic) IBOutlet UITextField *departureDateText;

@property (retain, nonatomic) IBOutlet UITextField *destinationAirporteText;
@property (retain, nonatomic) IBOutlet UILabel *realTimePredictionLabel;

@property (retain, nonatomic) IBOutlet UILabel *poweredBySAPLabel;

@property (strong, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) IBOutlet UILabel *airlineLabel;
@property (strong, nonatomic) IBOutlet UILabel *flightNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *departureAirportLabel;
@property (strong, nonatomic) IBOutlet UILabel *departureDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *destinationAirportLabel;

@property (retain, nonatomic) IBOutlet UIView *itineraryInputView;

-(UIImageView *)getAirlineImageView:(NSString *) airline;

@end
