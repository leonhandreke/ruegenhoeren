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
    NSString *description;
    NSString *narrator;

    
    CLLocationCoordinate2D coordinate;
    
    NSURL *imageFileLocation;
    NSURL *fileLocation;
    
}

// To conform to MKAnnotation
-(NSString *) subtitle;

@property (retain) NSString *title;
@property (retain) NSString *description;
@property (retain) NSString *narrator;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@property (retain) NSURL *imageFileLocation;
@property (retain) NSURL *fileLocation;

@end
