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





@interface ViewController ()

@end

@implementation ViewController

@synthesize listTableView, submitButton, airlineLabel, departureAirportLabel, departureDateLabel, destinationAirportLabel;




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
    self.airlineText.text = @"Delta";
    self.flightNumberText.text = @"DL123";
    self.departureAirportText.text = @"PHX";
    self.departureDateText.text = @"2012-12-15";
    self.destinationAirporteText.text = @"PHL";
    [super viewDidLoad];
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
    NSString *departDate =([self.departureDateText.text length] == 0)?formattedDate:self.departureAirportText.text;
    NSString *departAirport = ([self.departureAirportText.text length] == 0)?@"PHX":self.departureAirportText.text;
    NSString *arrivalAirport = ([self.destinationAirporteText.text length] == 0)?@"PHL":self.destinationAirporteText.text;
    
    NSString *strUrl = [NSString stringWithFormat: @"http://flight-prediction.herokuapp.com/predictions/%@/%@/%@/%@/%@", airline, flight, departDate ,departAirport, arrivalAirport];
    NSLog(@"Requested URL: %@", strUrl);
    NSURL *url = [NSURL URLWithString: strUrl];
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
    
 
    MapViewController *mapViewController = [[MapViewController alloc] initWithJsonData: jsonDictionary ];
    
    if(mapViewController.view){
            
    }

   
    if(([[self.airlineText text] length] == 0) || ([[self.flightNumberText text] length] == 0) ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing fields" message:@"Complete all fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        // optional - add more buttons:
//        [alert addButtonWithTitle:@"Yes"];
        [alert show];
    }else{
       [self.navigationController pushViewController:mapViewController animated:YES]; 
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
