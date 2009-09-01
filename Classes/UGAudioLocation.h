//
//  UGAudioLocation.h
//  ruegenhoeren
//
//  Created by Leon on 8/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UGAudioLocation : NSObject {

    NSString *title;
    NSString *description;
    NSString *narrator;
    
    CLLocationCoordinate2D location;
    
    NSURL *fileLocation;
    
}


@property (assign) NSString *title;
@property (assign) NSString *description;
@property (assign) NSString *narrator;

@property (assign) CLLocationCoordinate2D location;

@property (assign) NSURL *fileLocation;

@end
