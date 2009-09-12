//
//  UGAudioLocation.m
//  ruegenhoeren
//
//  Created by Leon on 8/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGAudioLocation.h"


@implementation UGAudioLocation

@synthesize title, description, narrator, coordinate, imageFileLocation, audioFileLocation;

- (void) dealloc {
    [title release];
    [description release];
    [narrator release];
    [imageFileLocation release];
    [audioFileLocation release];
    [super dealloc];
}

-(NSString*) subtitle {
	return [self narrator];
}

@end
