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


@property (strong, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) IBOutlet UITextField *airlineText;
@property (strong, nonatomic) IBOutlet UITextField *flightNumberText;
@property (strong, nonatomic) IBOutlet UITextField *departureAirportText;
@property (strong, nonatomic) IBOutlet UITextField *departureDateText;
@property (strong, nonatomic) IBOutlet UITextField *destinationAirportText;




@end
