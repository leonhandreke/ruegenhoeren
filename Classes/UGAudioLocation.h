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

    NSString *uuid;
    
    NSString *title;
    
    NSString *subtitle;
    NSString *descriptionPage;
    NSString *narrator;
    NSString *topic;
    
    CLLocationCoordinate2D coordinate;
    
    NSURL *audioFileRemoteLocation;
    
}

- (UGAudioLocation *) initWithDictionary: (NSDictionary *) dictionary;
- (NSDictionary *) dictionary;

- (NSURL *) audioFileLocalLocation;

@property (copy) NSString *uuid;
@property (copy) NSString *title;
@property (copy) NSString *subtitle;
@property (copy) NSString *descriptionPage;
@property (copy) NSString *narrator;
@property (copy) NSString *topic;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@property (copy) NSURL *audioFileRemoteLocation;

@end
