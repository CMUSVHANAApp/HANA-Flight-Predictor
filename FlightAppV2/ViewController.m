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

@synthesize listTableView, submitButton, airlineLabel, departureAirportLabel, departureDateLabel, destinationAirportLabel, poweredBySAPLabel, realTimePredictionLabel, itineraryInputView, jsonArray;


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.listTableView){
        return self.jsonArray.count;
    }else{
        return 1;
    }    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
  
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
      
  
    if(tableView == self.listTableView){
        
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        UIImageView *airlineImageView;
        NSString *airline = [[self.jsonArray objectAtIndex:indexPath.row] valueForKey:@"airline"];
        airlineImageView= [self getAirlineImageView:airline];

       
      
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 70, 30)];
        UILabel *departureTime = [[UILabel alloc] initWithFrame:CGRectMake(180, 5, 200, 30)];
       
        
        UILabel *arrivalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(380, 5, 220, 30)];
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(610, 5, 150, 30)];
        
        
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
        
        [cell addSubview:airlineImageView];
        [cell addSubview:departureTime];
        [cell addSubview:numberLabel];
        [cell addSubview:statusLabel];
        [cell addSubview:arrivalTimeLabel];
    
    }
    }
    
    return cell;
    
}

- (void)viewDidLoad
{
     
    [self loadDefaults];
   
    
    self.airlineText.text = @"Delta";
    self.flightNumberText.text = @"DL123";
    self.departureAirportText.text = @"PHX";
    
    CFGregorianDate currentDate = CFAbsoluteTimeGetGregorianDate(CFAbsoluteTimeGetCurrent(), CFTimeZoneCopySystem());
     self.departureDateText.text = [NSString stringWithFormat:@"%ld-%d-%d", currentDate.year, currentDate.month, currentDate.day];
    //NSLog(self.departureDateText.text);
       
    //self.departureDateText.text = @"2012-12-15";
    self.destinationAirporteText.text = @"PHL";
    [super viewDidLoad];
    
    itineraryInputView.layer.cornerRadius = 5;
    itineraryInputView.layer.masksToBounds = YES;
    
	
  //  realTimePredictionLabel.font = [UIFont italicSystemFontOfSize:18.0f];
  //  poweredBySAPLabel.font = [UIFont italicSystemFontOfSize:20.0f];
    
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
   
    
    NSString *airline = ([self.airlineText.text length]==0)?@"Delta": self.airlineText.text;
    NSString *flight = ([self.flightNumberText.text length] == 0)?@"DL234": self.flightNumberText.text;
    NSString *departDate = self.departureDateText.text;
    NSString *departAirport = ([self.departureAirportText.text length] == 0)?@"PHX":[self.departureAirportText.text uppercaseString];
    NSString *arrivalAirport = ([self.destinationAirporteText.text length] == 0)?@"PHL":[self.destinationAirporteText.text uppercaseString];
    
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
        NSLog(@" %@", responseString);
        NSMutableDictionary *jsonDictionary = [parser objectWithString:responseString error:nil];
        
        MapViewController *mapViewController = [[MapViewController alloc] initWithJsonData: jsonDictionary ];
        if(mapViewController.view){
            if(([[self.airlineText text] length] == 0) || ([[self.flightNumberText text] length] == 0) ){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing fields" message:@"Complete all fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                // optional - add more buttons:
                //        [alert addButtonWithTitle:@"Yes"];
                [alert show];
            }
            mapViewController.departDate.text = self.departureDateText.text;

            [self.navigationController pushViewController:mapViewController animated:YES];
            
        }
       
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

-(UIImageView *)getAirlineImageView:(NSString *) airline{
    UIImage *airlineImage;
    UIImageView *airlineImageView;
    
    if([airline isEqualToString:@"Delta Air Lines"]){
        airlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10,10, 80, 20)];
        airlineImage= [UIImage imageNamed:@"deltaairlines.jpg"];
        airlineImageView.image = airlineImage;
    }else if([airline isEqualToString:@"Southwest Airlines"]){
        // Work in progress, getting the right image for other airlines
        airlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10,0, 80, 43)];
        airlineImage = [UIImage imageNamed:@"Southwest-Airlines-logo.jpg"];
        airlineImageView.image = airlineImage;
    }else{
        // Work in progress, getting the right image for other airlines
        airlineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10,0, 50, 45)];
        airlineImage = [UIImage imageNamed:@"usairways.gif"];
        airlineImageView.image = airlineImage;
    }
    NSLog(@" %@", airline);
    return airlineImageView;
}

@end
