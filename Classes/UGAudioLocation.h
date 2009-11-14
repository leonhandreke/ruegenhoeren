//
//  UGAudioLocation.h
//  ruegenhoeren
//
//  Created by Leon on 8/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "UGDownload.h"
#import "NSString+MD5.h"

@interface UGAudioLocation : NSObject <MKAnnotation> {

    NSString *uuid;
    
    NSString *title;
    
    NSString *subtitle;
    NSString *descriptionPage;
    NSString *narrator;
    NSString *topic;
    
    NSURL *coverImageRemoteLocation;
    
    CLLocationCoordinate2D coordinate;
    
    NSURL *audioFileRemoteLocation;
    
    //UGDownload *imageDownload;
    
}

- (UGAudioLocation *) initWithDictionary: (NSDictionary *) dictionary;
- (NSDictionary *) dictionary;

- (NSURL *) audioFileLocalLocation;
- (NSString *) coverImageLocalLocation;
- (void) downloadCoverImageIfNeeded;

@property (retain) NSString *uuid;
@property (retain) NSString *title;
@property (retain) NSString *subtitle;
@property (retain) NSString *descriptionPage;
@property (retain) NSString *narrator;
@property (retain) NSString *topic;
@property (retain) NSURL *coverImageRemoteLocation;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@property (retain) NSURL *audioFileRemoteLocation;

@end
