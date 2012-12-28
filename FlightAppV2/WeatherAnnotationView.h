//
//  WeatherAnnotationView.h
//  FlightAppV2
//
//  Created by Lee TingYen on 12/12/12.
//  Copyright (c) 2012 Edward Akoto. All rights reserved.
//

#import <MapKit/MapKit.h>
@interface WeatherAnnotationView : MKPinAnnotationView
{
    @private
    NSString *title_;
    UIView *contentView_;
    UILabel *titleLabel_;
    UILabel *subtitleLabel_;
    UILabel *descriptionLabel_;
    UIImageView *imageView_;
    

}
@property (nonatomic, retain) NSString *title;
@property (readwrite, assign) int weatherCode;
@property (nonatomic, retain) NSString *subTitle;
@property (nonatomic, retain) NSString *descriptionLabel;
@end

