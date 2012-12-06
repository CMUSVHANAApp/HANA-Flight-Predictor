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
@property (strong, nonatomic) IBOutlet UITableView *formTableView;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UITableView *displayTableView;

-(IBAction)buttonPressed:(id)sender;

@end
