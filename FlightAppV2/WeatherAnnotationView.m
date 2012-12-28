//
//  WeatherAnnotationView.m
//  FlightAppV2
//
//  Created by Lee TingYen on 12/12/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//

#import "WeatherAnnotationView.h"
#import "MapAnnotation.h"
#import <QuartzCore/QuartzCore.h>

@implementation WeatherAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.canShowCallout = NO;
        self.image = nil;
        
        UIImageView *pinView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"pin.png"]];
        [pinView setFrame: CGRectMake(-8.0f, 9.0f, 30.0f, 30.0f)];
        [self addSubview: pinView];
        
        contentView_ = [[UIView alloc] initWithFrame: CGRectMake(-100.0f, -50.0f, 150.0f, 65.0f)];
        contentView_.layer.cornerRadius = 5;
        contentView_.layer.masksToBounds = YES;
        contentView_.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];
        [self addSubview: contentView_];

        
        titleLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(65.0f, 10.0f, 80.0f, 20.0f)];
        titleLabel_.textColor = [UIColor colorWithRed:1.0f green:1.0f blue:0.0f alpha:1.0f];
        titleLabel_.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
        [contentView_ addSubview:titleLabel_];
        
        subtitleLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(65.0f, 30.0f, 80.0f, 20.0f)];
        subtitleLabel_.textColor = [UIColor colorWithRed:0.7f green:0.7f blue:.70f alpha:1.0f];
        subtitleLabel_.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
        
        descriptionLabel_ = [UILabel alloc];
        
        [contentView_ addSubview:subtitleLabel_];
        
        MapAnnotation *ann = annotation;
        
        [self setTitle: annotation.title];
        [self setWeatherCode: ann.weatherCode];
        [self setTitle: annotation.title];
        [self setSubTitle:ann.subTitle];
        
        
        
                
        
    }
    return self;
}
-(void) setSubTitle:(NSString *)subTitle{
    subtitleLabel_.text = subTitle;
    subtitleLabel_.adjustsFontSizeToFitWidth = YES;
}
-(void) setTitle:(NSString *)title{
    titleLabel_.text = title;

}

- (void) setWeatherCode:(int)weatherCode {
    switch (weatherCode){
        case 113: // Clear/Sunny
            imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Sunny-48.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Sunny"];
            break;
        case 116: case 119: //Partly Cloudy  // Cloudy
            imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Cloudy-48.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Cloudy"];
            break;
        case 122: //Overcast
            imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Overcast-48.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Overcast"];
            break;
        case 143: case 248: case 260: //Mist //Fog //Freezing fog	
            imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"fog-48.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Fog"];
            break;
        case 176: case 263: case 266: case 281: case 284: case 293: case 296: case 311: case 323: case 326:
            //Patchy rain nearby //Patchy light drizzle //Light drizzle //Freezing drizzle //Heavy freezing drizzle //Patchy light rain //Light rain //Light freezing rain //Patchy light snow //Light snow
            imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"light-rain-48.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Light rain"];
            break;
        case 179: case 182: case 185: case 227: case 317: case 368: case 374:
            //Patchy snow nearby  //Patchy sleet nearby //Patchy freezing drizzle nearby //Blowing snow //Light sleet //Light snow showers //Light showers of ice pellets
            imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"light-snow-48.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Light snow"];
            break;
        case 200: //Thundery outbreaks in nearby
            imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"thunder-48.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Thunder"];
            break;
        case 230: case 320: case 329: case 332: case 335: case 338: case 350: case 371: case 377:
            //Blizzard //Moderate or heavy sleet //Patchy moderate snow //Moderate snow //Patchy heavy snow //Heavy snow //Ice pellets //Moderate or heavy snow showers //Moderate or heavy showers of ice pellets
            imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"snow-48.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Snow"];
            break;
        case 299: case 305: case 356: case 359: case 365: //Moderate rain at times // Heavy rain at times //Moderate or heavy rain shower //Torrential rain shower //Moderate or heavy sleet showers//
            imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"showers-48.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Showers"];
            break;
        case 302: case 308: case 314: //Moderate rain  //Heavy rain //Moderate or Heavy freezing rain
            imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"rain-48.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Rain"];
            break;
        case 353: case 362: //Light rain shower //Light sleet showers
            imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Light-Showers-48.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Light showers"];
            break;
        case 386: case 389: case 392: case 395: //Patchy light rain in area with thunder  //Moderate or heavy rain in area with thunder //Patchy light snow in area with thunder //Moderate or heavy snow in area with thunder
            imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Thunderstorms-48.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Thunder storms"];
            break;
        default:
           imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"rain-48.png"]];
            // imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"question.png"]];
            descriptionLabel_ = [NSString stringWithFormat:@"Rain"];
            break;
    }
    [imageView_ setFrame:CGRectMake(5.0f, 5.0f, 55.0f, 55.0f)];
    [contentView_ addSubview:imageView_];
}
- (void)dealloc
{
    [title_ release], title_ = nil;
    [titleLabel_ release], titleLabel_ = nil;

    [subtitleLabel_ release], subtitleLabel_ = nil;

    [contentView_ release], contentView_ = nil;
    [imageView_ release], imageView_ = nil;
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    //titleLabel_.text = self.title;
    NSLog(@"test draw Rect");
}

*/

@end
