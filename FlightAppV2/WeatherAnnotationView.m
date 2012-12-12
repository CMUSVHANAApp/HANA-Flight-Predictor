//
//  WeatherAnnotationView.m
//  FlightAppV2
//
//  Created by Lee TingYen on 12/12/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//

#import "WeatherAnnotationView.h"
#import <QuartzCore/QuartzCore.h>

@implementation WeatherAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        self.backgroundColor = [UIColor clearColor];
        self.canShowCallout = NO;
        contentView_ = [[UIView alloc] initWithFrame: CGRectMake(-100.0f, -50.0f, 150.0f, 65.0f)];
        contentView_.layer.cornerRadius = 5;
        contentView_.layer.masksToBounds = YES;
        contentView_.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];
        [self addSubview: contentView_];

        UIImageView *pinView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"pin.png"]];
        [pinView setFrame: CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
        [self addSubview: pinView];

        
        titleLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(65.0f, 10.0f, 80.0f, 20.0f)];
        titleLabel_.textColor = [UIColor colorWithRed:1.0f green:1.0f blue:0.0f alpha:1.0f];
        titleLabel_.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
        [contentView_ addSubview:titleLabel_];
        
        subtitleLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(65.0f, 30.0f, 80.0f, 20.0f)];
        subtitleLabel_.textColor = [UIColor colorWithRed:0.7f green:0.7f blue:.70f alpha:1.0f];
        subtitleLabel_.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
        [contentView_ addSubview:subtitleLabel_];
        
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
- (void) setImage:(NSString *)image {
    if(image == @"sunny"){
        imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"weather_few_clouds.png"]];
    }
    else{
        imageView_ = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"weather_128.png"]];
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
