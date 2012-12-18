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
@synthesize itineraryInputView, jsonArray;




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if(tableView == self.listTableView){
        
        return 40;
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
        
        UILabel *departureLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, 150, 30)];
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 5, 100, 30)];
        UILabel *departureTime = [[UILabel alloc] initWithFrame:CGRectMake(260, 5, 170, 30)];
       
        UILabel *arrivalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(430, 5, 170, 30)];
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(600, 5, 150, 30)];
        
       
        [departureLabel setText:[[self.jsonArray objectAtIndex:indexPath.row] valueForKey:@"airline"]];
                        
        [departureLabel setBackgroundColor:[UIColor clearColor]];
        
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Australia/Sydney"]];
   
        
        [departureTime setText:[formatter stringFromDate:now]];
        [departureTime setBackgroundColor:[UIColor clearColor]];
        
        
        [numberLabel setText:[[self.jsonArray objectAtIndex:indexPath.row] valueForKey:@"flightNumber"]];
        [numberLabel setBackgroundColor:[UIColor clearColor]];
        
        
        [arrivalTimeLabel setText:[[self.jsonArray objectAtIndex:indexPath.row] valueForKey:@"date"]];
        [arrivalTimeLabel setBackgroundColor:[UIColor clearColor]];
            
        [numberLabel setBackgroundColor:[UIColor clearColor]];
         
        
        if([[NSString stringWithFormat:@"%@", [[self.jsonArray objectAtIndex:indexPath.row] valueForKey:@"departDelay"]] isEqualToString:@"0"]){
             [statusLabel setText:@"On time"];
        }else{
            [statusLabel setText:[NSString stringWithFormat:@"Delay %@ mins", [[self.jsonArray objectAtIndex:indexPath.row] valueForKey:@"departDelay"]]];
        }
           
    
        [statusLabel setBackgroundColor:[UIColor clearColor]];
        [statusLabel setTextColor:[UIColor blueColor]];
        
        
        [cell addSubview:departureLabel];
        [cell addSubview:departureTime];
        [cell addSubview:numberLabel];
        [cell addSubview:statusLabel];
        [cell addSubview:arrivalTimeLabel];
    
    }
    
    
    return cell;
    
}

- (void)viewDidLoad
{
     NSLog(@"View Did Load Called ARRAY %@", self.jsonArray);
  
    self.loadDefaults;
    
     NSLog(@"Load Defaults has been called %@", self.jsonArray);
    
    self.airlineText.text = @"Delta";
    self.flightNumberText.text = @"DL123";
    self.departureAirportText.text = @"PHX";
    self.departureDateText.text = @"2012-12-15";
    self.destinationAirporteText.text = @"PHL";
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
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDate = [formatter stringFromDate:[NSDate dateWithTimeInterval:(24*60*60) sinceDate:[NSDate date]]];
    NSLog(formattedDate);
    NSString *airline = ([self.airlineText.text length]==0)?@"Delta": self.airlineText.text;
    NSString *flight = ([self.flightNumberText.text length] == 0)?@"DL234": self.flightNumberText.text;
    NSString *departDate = self.departureDateText.text;
    NSString *departAirport = ([self.departureAirportText.text length] == 0)?@"PHX":self.departureAirportText.text;
    NSString *arrivalAirport = ([self.destinationAirporteText.text length] == 0)?@"PHL":self.destinationAirporteText.text;
    
    NSString *strUrl = [NSString stringWithFormat: @"http://flight-prediction.herokuapp.com/predictions/%@/%@/%@/%@/%@", airline, flight, departDate ,departAirport, arrivalAirport];
    NSLog(@"Requested URL: %@", strUrl);
    NSURL *url = [NSURL URLWithString: strUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    
    
}

- (IBAction)loadDefaults
{
    
    
    NSString *strUrl = [NSString stringWithFormat: @"http://flight-prediction.herokuapp.com/flights"];
    NSURL *url = [NSURL URLWithString: strUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startSynchronous];

    
}
- (void)requestFinished:(ASIHTTPRequest *) request 
{
         
    if([request.url.absoluteString isEqualToString:@"http://flight-prediction.herokuapp.com/flights"]){
       
        self.jsonArray  = [[NSArray alloc] init];
             
        self.jsonArray = [[request responseString] JSONValue];
       
      
    
        
    }else{
       
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        
        NSString *responseString = [request responseString];
        
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        
        
        
        NSString *result = @" Response for ";
        result = [result stringByAppendingString:self.departureAirportText.text];
        
        result = [result stringByAppendingString:@" to "];
        
        result = [result stringByAppendingString:self.destinationAirporteText.text];
        
        
        responseString = [result stringByAppendingString:responseString];
        
        
        MapViewController *mapViewController = [[MapViewController alloc] initWithJsonData: jsonDictionary ];
        
        if(mapViewController.view){
            if(([[self.airlineText text] length] == 0) || ([[self.flightNumberText text] length] == 0) ){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing fields" message:@"Complete all fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                // optional - add more buttons:
                //        [alert addButtonWithTitle:@"Yes"];
                [alert show];
            }
            NSLog(@"Hello");
            
            [self.navigationController pushViewController:mapViewController animated:YES];
            
        }
        NSLog(@"test here");
        
    
        
    }
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
