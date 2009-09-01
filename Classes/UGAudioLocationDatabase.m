//
//  UGAudioLocationDatabase.m
//  ruegenhoeren
//
//  Created by Leon on 8/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGAudioLocationDatabase.h"


@implementation UGAudioLocationDatabase

@synthesize audioLocations;


static UGAudioLocationDatabase *mainAudioLocationDatabase = nil;

+ (UGAudioLocationDatabase *) sharedAudioLocationDatabase
{
	if(mainAudioLocationDatabase == nil) {
		mainAudioLocationDatabase = [[UGAudioLocationDatabase alloc] init];
	}
	return mainAudioLocationDatabase;	
}
    

- (UGAudioLocationDatabase*) init {
    if (self = [super init]) {
        UGAudioLocation *woorkeAudioLocation = [[UGAudioLocation alloc] init];
        [woorkeAudioLocation setTitle: @"Hügelgräberfeld \"Woorker Berge\""];
		CLLocationCoordinate2D woorkeLocation = {54.447286617183636, 13.410186767578125};
        [woorkeAudioLocation setCoordinate: woorkeLocation];
		
		[self addAudioLocation: woorkeAudioLocation];
        
    }
    
    return self;
}

- (void) addAudioLocation: (UGAudioLocation *) audioLocation {
    [audioLocations addObject: audioLocation];
}

@end
