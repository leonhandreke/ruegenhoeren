//
//  UGAudioLocation.h
//  ruegenhoeren
//
//  Created by Leon on 8/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface UGAudioLocation : NSObject <MKAnnotation> {

    NSString *title;
    NSString *subtitle;
    NSString *description;
    NSString *narrator;
    NSString *topic;
    
    CLLocationCoordinate2D coordinate;
    
    NSURL *imageFileLocation;
    NSString *audioFileName;
    
}

// To conform to MKAnnotation
-(NSString *) subtitle;

- (NSURL *) audioFileLocation;

@property (copy) NSString *title;
@property (copy) NSString *subtitle;
@property (copy) NSString *description;
@property (copy) NSString *narrator;
@property (copy) NSString *topic;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@property (copy) NSURL *imageFileLocation;
@property (copy) NSString *audioFileName;

@end
