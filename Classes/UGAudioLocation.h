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

    // The title is at the same time the unique identifier!
    NSString *title;
    
    NSString *subtitle;
    NSString *descriptionPage;
    NSString *narrator;
    NSString *topic;
    
    CLLocationCoordinate2D coordinate;

    NSString *audioFileName;
    
}

- (UGAudioLocation *) initWithDictionary: (NSDictionary *) dictionary;
- (NSDictionary *) dictionary;

// To conform to MKAnnotation
-(NSString *) subtitle;

- (NSURL *) audioFileLocation;

@property (copy) NSString *title;
@property (copy) NSString *subtitle;
@property (copy) NSString *descriptionPage;
@property (copy) NSString *narrator;
@property (copy) NSString *topic;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@property (copy) NSString *audioFileName;

@end
