//
//  MapViewController.m
//  FlightApp
//
//  Created by Edward Akoto on 12/5/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//

#import "MapViewController.h"
#import "AppDelegate.h"
#import "MapAnnotation.h"
#import "WeatherAnnotationView.h"
#import <QuartzCore/QuartzCore.h>
#import "ASIHTTPRequest.h"
#import "SBJsonParser.h"

@interface MapViewController ()

@property (nonatomic, retain) MapAnnotation *calloutAnnotation;

@end

@implementation MapViewController

@synthesize arrivalDelay, departurePrediction,destinationPrediction, rainImage;
@synthesize calloutAnnotation = _calloutAnnotation;
@synthesize displayView, realTimeLabel, poweredBySAPLabel, flightInformationLabel;
@synthesize delay_summary;
@synthesize departDate;
@synthesize lblAtAirport;
@synthesize lblDepartTime;
@synthesize lblArrivalTime;





-(id)initWithJsonData:(NSMutableDictionary *) json {
    self = [super init];
    if(self){
        self.jsonDictionary = json;
    }
    return self;
}

- (void)viewDidLoad
{   
      
    displayView.layer.cornerRadius = 5;
    displayView.layer.masksToBounds = YES;
    
    realTimeLabel.font = [UIFont italicSystemFontOfSize:20.0f];
    poweredBySAPLabel.font = [UIFont italicSystemFontOfSize:18.0f];
   
    self.flightNumberLabel.text =[self.jsonDictionary valueForKey:@"flightNumber"];
    self.airlineLabel.text = [self.jsonDictionary valueForKey: @"airline"];
    self.lblAtAirport.text = [NSString stringWithFormat:@"%@ airport.",[[[self.jsonDictionary valueForKey:@"departAirport"] objectForKey:@"name"] uppercaseString]];
    
    weatherCode = 0;
    
    if([self.jsonDictionary valueForKey:@"departWeather"] != (id)[NSNull null]  ){
    
        //weatherCode = [[[self.jsonDictionary valueForKey:@"departWeather"] objectForKey:@"weatherCode"] integerValue] ;
       
    }
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //[dateFormat setDateFormat:@"d MM yyyy HH:mm:ss zzz"];
    [dateFormat setDateFormat:@"d MM yyyy HH:mm:ss zzz"];
       
    
    NSDate *departureTime = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[self.jsonDictionary valueForKey:@"date"]]];
    NSDateComponents *departureDateComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:departureTime];
    self.lblDepartTime.text = [NSString stringWithFormat:@"%.2d : %.2d",[departureDateComponents hour], [departureDateComponents minute]];
    
    
    
    NSDate *arrivalTime = [dateFormat dateFromString:[NSString stringWithFormat:@"%@",[self.jsonDictionary valueForKey:@"arrivalDate"]]];
    NSDateComponents *arrivalDateComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:arrivalTime];
    self.lblArrivalTime.text = [NSString stringWithFormat:@"%.2d : %.2d",[arrivalDateComponents hour], [arrivalDateComponents minute]];
    
    
    int departureDelay = [[self.jsonDictionary valueForKey:@"departDelay"] doubleValue];
    if(departureDelay==0){
        
        self.departurePrediction.text =@"On time";
        self.departurePrediction.textColor =[UIColor blueColor];
        self.delay_summary.text = [NSString stringWithFormat:@"The average delay time is %d min(s) when the weather is %@ at %@ airport.", departureDelay, [self getWeatherDescriptionFromCode:weatherCode], [[self.jsonDictionary valueForKey:@"departAirport"] objectForKey:@"name"]];
       
        
    }else if (departureDelay<20){
        
        self.departurePrediction.text = [NSString stringWithFormat:@"Delay %d min", departureDelay ];
        self.delay_summary.text = [NSString stringWithFormat:@"The average delay time is %d min(s) when the weather is %@ at %@ airport.", departureDelay, [self getWeatherDescriptionFromCode:weatherCode],  [[self.jsonDictionary valueForKey:@"departAirport"] objectForKey:@"name"]];
        self.departurePrediction.textColor =[UIColor redColor];
    }else{
        self.departurePrediction.text =[NSString stringWithFormat:@"Delay %d min", departureDelay];
       
        self.delay_summary.text = [NSString stringWithFormat:@"The average delay time is %d mins(s) when the weather is %@ at %@ airport.", departureDelay, [self getWeatherDescriptionFromCode:weatherCode], [[self.jsonDictionary valueForKey:@"departAirport"] objectForKey:@"name"]];

        self.departurePrediction.textColor =[UIColor redColor];
    }
    
    CLLocationCoordinate2D locationDeparture;
    locationDeparture.latitude = [[[[self.jsonDictionary valueForKey:@"departAirport"] valueForKey:@"geoLocation"] objectForKey: @"latitude"] doubleValue];
    locationDeparture.longitude = [[[[self.jsonDictionary valueForKey:@"departAirport"] valueForKey:@"geoLocation"] objectForKey: @"longitude"] doubleValue];
    MapAnnotation *annotation1 = [[MapAnnotation alloc] initWithCoordinate: locationDeparture];


    annotation1.title = [NSString stringWithFormat:@"%@ (D)", [[self.jsonDictionary valueForKey:@"departAirport"] objectForKey:@"name"]];
                         
    if([self.jsonDictionary valueForKey:@"departWeather"] != (id)[NSNull null]  ){
        annotation1.weatherCode = [[[self.jsonDictionary valueForKey:@"departWeather"] objectForKey:@"weatherCode"] integerValue] ;    
    }
    annotation1.subTitle = self.departurePrediction.text;
    NSLog(@"departure weather is %d", annotation1.weatherCode );
    
    [mapView addAnnotation:annotation1];
    [annotation1 release];


    int arrivalDelay = [[self.jsonDictionary valueForKey:@"arrivalDealy"] doubleValue];
    
    if(arrivalDelay<20){
        self.destinationPrediction.text =@"On time";
        self.destinationPrediction.textColor =[UIColor blueColor];
        
    }else{
        self.destinationPrediction.text =[NSString stringWithFormat:@"Delay %d minutes", arrivalDelay];
        self.destinationPrediction.textColor =[UIColor redColor];
    }
    self.airlineLabel.text = self.airlineText.text;
    
    CLLocationCoordinate2D locationArrival;
    locationArrival.longitude = [[[[self.jsonDictionary valueForKey:@"arrivalAirport"] valueForKey:@"geoLocation"] objectForKey: @"longitude"] doubleValue];
    locationArrival.latitude = [[[[self.jsonDictionary valueForKey:@"arrivalAirport"] valueForKey:@"geoLocation"] objectForKey: @"latitude"] doubleValue];
    MapAnnotation *annotation2 = [[MapAnnotation alloc] initWithCoordinate: locationArrival];


     annotation2.title = [NSString stringWithFormat:@"%@ (A)", [[self.jsonDictionary valueForKey:@"arrivalAirport"] objectForKey:@"name"]];
   
    
    
    if([self.jsonDictionary valueForKey:@"arrivalWeather"] != (id)[NSNull null] ){
        annotation2.weatherCode = [[[self.jsonDictionary valueForKey:@"arrivalWeather"] objectForKey:@"weatherCode"] integerValue] ;
    }
    annotation2.subTitle = self.destinationPrediction.text;
    [mapView addAnnotation:annotation2];
    [annotation2 release];

    
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = (locationDeparture.latitude + locationArrival.latitude) /2.0f;
    region.center.longitude = (locationDeparture.longitude + locationArrival.longitude) /2.0f ;
    
    region.span.latitudeDelta = fabs(locationDeparture.latitude - locationArrival.latitude) * 2;
    region.span.longitudeDelta = fabs(locationDeparture.longitude-locationArrival.longitude) * 2;
    [mapView setRegion:region animated:YES];
    
    NSInteger numberOfSteps = 3;
    CLLocationCoordinate2D coordinates[3];
    
    CLLocationCoordinate2D locationMiddle;
    locationMiddle.latitude = ((locationDeparture.latitude+locationArrival.latitude)-5)/2.0f;
    locationMiddle.longitude = ((locationDeparture.longitude+locationArrival.longitude)+7)/2.0f;
    
    coordinates[0] = locationDeparture;
    coordinates[1] = locationMiddle;
    coordinates[2] = locationArrival;
    

    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
    [mapView addOverlay:polyline];
    [mapView setMapType:1];
    [mapView setDelegate:self];
      
    NSLog(@"Delay dparture is %@", [self.jsonDictionary valueForKey:@"departDelay"]);
    NSLog(@"Delay arrival is %@", [self.jsonDictionary valueForKey:@"arrivalDelay"]);
    
    /** Recommendations **/
    NSArray *loop = [NSArray arrayWithObjects: @"Dining", @"Transportation", @"Accomodation", nil];
    for(int key_i=0; key_i< 3; key_i++){
        NSString *key = [loop objectAtIndex:key_i];
        NSMutableDictionary *recommendationArray = [[[self.jsonDictionary valueForKey: @"recommendations"] valueForKey: key] valueForKey: @"recommendations"];
        //NSMutableDictionary *biz;
        
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(70, 588+key_i*(20+3*25), 460, 10+ 3*25)];
        [container setBackgroundColor: [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.0f] ];
        [self.view addSubview:container];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 460, 38)];
        label.text = key;
        [label setTextColor: [UIColor colorWithRed:199/255.0 green:74/255.0 blue:148/255.0 alpha:1.0]];
        [label setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.0f] ];
        [container addSubview:label];
        [label autorelease];
        
        
        int i = 0 ;
        for (NSMutableDictionary *biz in recommendationArray) {
            if(i==3) break;
            UIColor *fontColor = Nil;
            if(i % 2== 0)
                fontColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
            else
                fontColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 35+ i*25, 450, 25)];
            [view setBackgroundColor: [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f] ];
            [container addSubview:view];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 200, 21)];
            label.text = [biz valueForKey:@"name"];
            
            if(key == @"Dining"){
                label.text = [NSString stringWithFormat: @"%@ - (%@)", [biz valueForKey:@"name"], [biz valueForKey:@"category"]];
            }
            label.font = [UIFont systemFontOfSize:14];
            label.adjustsFontSizeToFitWidth = NO;
            [label setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.0f]];
            [label setTextColor: fontColor];
            [view addSubview:label];
            

            label = [[UILabel alloc] initWithFrame:CGRectMake(215, 2, 80, 21)];
            label.text = [NSString stringWithFormat: @"%0.2f miles", [[biz valueForKey: @"distance"] doubleValue]];
            label.font = [UIFont systemFontOfSize:14];
            label.adjustsFontSizeToFitWidth = NO;
            [label setTextColor: fontColor];
            [label setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.0f]];
            [view addSubview:label];


            label = [[UILabel alloc] initWithFrame:CGRectMake(300, 2, 200, 21)];
            label.userInteractionEnabled = YES;
            UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToLink:)];
            [label addGestureRecognizer:gr];
            [gr release];
            label.text = [NSString stringWithFormat: @"%@", [[biz valueForKey:@"geoLocation"] valueForKey: @"address"]];
            label.font = [UIFont systemFontOfSize:14];
            label.adjustsFontSizeToFitWidth = NO;
           [label setTextColor: fontColor];
            [label setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.0f]];
            [view addSubview:label];

            label = [[UILabel alloc] initWithFrame:CGRectMake(500, 2, 100, 21)];
            label.text = [NSString stringWithFormat: @"%@", [biz valueForKey: @"phone"]];
            label.font = [UIFont systemFontOfSize:14];
            label.adjustsFontSizeToFitWidth = NO;
            [label setTextColor: fontColor];
            [label setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.0f]];
            [view addSubview:label];
            
            i++;
            // do something with uid and count
        }

        
    }
    [super viewDidLoad];
   
}
-(void) goToLink:(UILabel*)sender{
    NSLog(@"I am here");
    double latitude = [[[[self.jsonDictionary valueForKey:@"departAirport"] valueForKey:@"geoLocation"] objectForKey: @"latitude"] doubleValue];
    double longitude= [[[[self.jsonDictionary valueForKey:@"departAirport"] valueForKey:@"geoLocation"] objectForKey: @"longitude"] doubleValue];
;

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://maps.apple.com?q=%0.4f,%0.4f", latitude, longitude]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [super dealloc];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    WeatherAnnotationView *pin = (WeatherAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[annotation title]];
    
    if (pin == nil) {
        pin = [[[WeatherAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[annotation title]] autorelease];
    }else {
        pin.annotation = annotation;
    }
   
    return pin;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id < MKOverlay >)overlay{
    
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.lineWidth = 5.0;
    polylineView.strokeColor = [UIColor greenColor];
    [polylineView setFillColor:[UIColor greenColor]];
    
    return [polylineView autorelease];
    
}

-(NSString *)getWeatherDescriptionFromCode:(int) code{
    NSString *description;
    
    switch (code){
        case 113: // Clear/Sunny
            description = [NSString stringWithFormat:@"sunny"];
            break;
        case 116: case 119: //Partly Cloudy  // Cloudy
            description = [NSString stringWithFormat:@"cloudy"];
            break;
        case 122: //Overcast
            description = [NSString stringWithFormat:@"overcast"];
            break;
        case 143: case 248: case 260: //Mist //Fog //Freezing fog
            description = [NSString stringWithFormat:@"foggy"];
            break;
        case 176: case 263: case 266: case 281: case 284: case 293: case 296: case 311: case 323: case 326:
            description = [NSString stringWithFormat:@"lighly-rainy"];
            break;
        case 179: case 182: case 185: case 227: case 317: case 368: case 374:
            description = [NSString stringWithFormat:@"lightly snowy"];
            break;
        case 200: //Thundery outbreaks in nearby
            description = [NSString stringWithFormat:@"stormy"];
            break;
        case 230: case 320: case 329: case 332: case 335: case 338: case 350: case 371: case 377:
            description = [NSString stringWithFormat:@"snowy"];
            break;
        case 299: case 305: case 356: case 359: case 365: //Moderate rain at times // Heavy rain at times //Moderate or heavy rain showe
            description = [NSString stringWithFormat:@"showering"];
            break;
        case 302: case 308: case 314: //Moderate rain  //Heavy rain //Moderate or Heavy freezing rain
            description = [NSString stringWithFormat:@"rainy"];
            break;
        case 353: case 362: //Light rain shower //Light sleet showers
            description = [NSString stringWithFormat:@"lighly-showering"];
            break;
        case 386: case 389: case 392: case 395: //Patchy light rain in area with thunder  //Moderate or heavy rain in area with thunder //Patchy light snow in area with thunder //Moderate or heavy snow in area with thunder
            description = [NSString stringWithFormat:@"stormy"];
            break;
        default:
            description = [NSString stringWithFormat:@"rainy"];
            break;
    }
    
    return description;
}

@end
