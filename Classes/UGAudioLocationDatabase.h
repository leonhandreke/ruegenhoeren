//
//  UGAudioLocationDatabase.h
//  ruegenhoeren
//
//  Created by Leon on 8/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UGAudioLocation.h"

@interface UGAudioLocationDatabase : NSObject {

    NSMutableArray *audioLocations;
}

- (void) addAudioLocation: (UGAudioLocation *) audioLocation;


@property (readonly) NSMutableArray *audioLocations;

@end
