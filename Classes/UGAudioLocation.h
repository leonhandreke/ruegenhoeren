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
    
    NSURL *fileLocation;
    
}

// To conform to MKAnnotation
-(NSString *) subtitle;

@property (assign) NSString *title;
@property (assign) NSString *description;
@property (assign) NSString *narrator;

@property (assign) CLLocationCoordinate2D coordinate;

@property (assign) NSURL *fileLocation;

@end
