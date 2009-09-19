//
//  UGAudioLocation.m
//  ruegenhoeren
//
//  Created by Leon on 8/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGAudioLocation.h"


@implementation UGAudioLocation

@synthesize title, description, narrator, topic, coordinate, imageFileLocation, audioFileName;

- (void) dealloc {
    [title release];
    [description release];
    [narrator release];
    [topic release];
    [imageFileLocation release];
    [audioFileName release];
    [super dealloc];
}

-(NSString*) subtitle {
	return [self narrator];
}

- (NSURL *) audioFileLocation {
    
    /*NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES); 
    NSString *filename = [paths objectAtIndex:0];*/
    NSString *filename = [[NSBundle mainBundle] pathForResource: audioFileName ofType: nil];  
    return [NSURL fileURLWithPath: filename];
}

@end
