//
//  ViewController.m
//  FlightApp
//
//  Created by Edward Akoto on 12/2/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//



#import "ViewController.h"
#import "ASIHTTPRequest.h"
#import "MapViewController.h"
#import "SBJson.h"
#import <QuartzCore/QuartzCore.h>





@interface ViewController ()

@end

@implementation ViewController

@synthesize listTableView, submitButton, airlineLabel, departureAirportLabel, departureDateLabel, destinationAirportLabel, poweredBySAPLabel, realTimePredictionLabel;
@synthesize itineraryInputView;




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == self.listTableView){
        
        return 1;
    }else{
        return 2;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
       
    }
    
    
    
    // Configure the cell...
    if(tableView == self.listTableView){
        
        
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if ([indexPath section] == 0) {
            UILabel *departureLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 150, 30)];
            UILabel *destinationLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 5, 150, 30)];
            UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(450, 5, 150, 30)];
            UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(600, 5, 150, 30)];
            //
            
            if([indexPath row] == 0){
                departureLabel.text = @"SFO";
                [departureLabel setBackgroundColor:[UIColor clearColor]];
                
                destinationLabel.text = @"KQ";
                [destinationLabel setBackgroundColor:[UIColor clearColor]];
                
                numberLabel.text = @"FX150";
                [numberLabel setBackgroundColor:[UIColor clearColor]];
              
                statusLabel.text = @"On time ";
                [statusLabel setBackgroundColor:[UIColor clearColor]];
                [statusLabel setTextColor:[UIColor blueColor]];
                
            }
            
            
            [cell addSubview:departureLabel];
            [cell addSubview:destinationLabel];
            [cell addSubview:numberLabel];
            [cell addSubview:statusLabel];
            
          

            
        }
        
   
    
    
}


return cell;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    itineraryInputView.layer.cornerRadius = 5;
    itineraryInputView.layer.masksToBounds = YES;

	
    realTimePredictionLabel.font = [UIFont italicSystemFontOfSize:18.0f];
    poweredBySAPLabel.font = [UIFont italicSystemFontOfSize:20.0f];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)grabURLInBackground:(id)sender
{
       
    
    NSURL *url = [NSURL URLWithString:@"http://flight-prediction.herokuapp.com/predictions/DL123"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
  SBJsonParser *parser = [[SBJsonParser alloc] init];
    
   NSString *responseString = [request responseString];
    
    NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
    
        
    
    
    NSString *result = @" Response for ";
    result = [result stringByAppendingString:self.departureAirportText.text];
    
    result = [result stringByAppendingString:@" to "];
    
    result = [result stringByAppendingString:self.destinationAirporteText.text];
    
    
    responseString = [result stringByAppendingString:responseString];
    
 
    MapViewController *mapViewController = [[MapViewController alloc] init];
    
    if(mapViewController.view){
       
        NSLog(@"Delay dparture is %@", [jsonDictionary valueForKey:@"departDelay"]);
        NSLog(@"Delay arrival is %@", [jsonDictionary valueForKey:@"arrivalDealy"]);
        int departureDelay = [[jsonDictionary valueForKey:@"departDelay"] doubleValue];
        
        if(departureDelay<20){
            mapViewController.departurePrediction.text =@"PHL";
            mapViewController.departurePrediction.textColor =[UIColor blueColor];
            
        }else{
            mapViewController.departurePrediction.text =[NSString stringWithFormat:@"Delay %d minutes", departureDelay];
             mapViewController.departurePrediction.textColor =[UIColor redColor];
        }

        
        int destinationDelay = [[jsonDictionary valueForKey:@"arrivalDealy"] doubleValue];
        
        
        mapViewController.destinationPrediction.text =@"PHX";
        mapViewController.destinationPrediction.textColor =[UIColor blueColor];
 
        mapViewController.airlineLabel.text = self.airlineText.text;
        
        
        mapViewController.flightNumberLabel.text =self.flightNumberText.text;    }

   
    if(([[self.airlineText text] length] == 0) || ([[self.flightNumberText text] length] == 0) ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing fields" message:@"Complete all fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        // optional - add more buttons:
//        [alert addButtonWithTitle:@"Yes"];
        [alert show];
    }else{
       [self.navigationController pushViewController:mapViewController animated:YES]; 
    }    

//    [self.navigationController pushViewController:mapViewController animated:YES];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
//    NSError *error = [request error];
    
    NSString *alertViewText = [[NSString alloc] initWithFormat:@"Error"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:alertViewText delegate:(nil) cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    
    [alert show];
}




- (void)dealloc {
    [_airlineText release];
    [_flightNumberText release];
    [_departureAirportText release];
    [_departureDateText release];
    [_destinationAirporteText release];
  
    [super dealloc];
}

@end
