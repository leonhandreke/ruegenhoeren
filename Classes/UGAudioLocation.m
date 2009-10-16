//
//  UGAudioLocation.m
//  ruegenhoeren
//
//  Created by Leon on 8/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGAudioLocation.h"


@implementation UGAudioLocation

@synthesize uuid, title, subtitle, descriptionPage, narrator, topic, coordinate, audioFileRemoteLocation;

- (UGAudioLocation *) initWithDictionary: (NSDictionary *) dictionary {
    if (self = [self init]) {
        [self setUuid: [dictionary valueForKey: @"uuid"]];
        [self setTitle: [dictionary valueForKey: @"title"]];
        [self setSubtitle: [dictionary valueForKey: @"subtitle"]];
        [self setDescriptionPage: [dictionary valueForKey: @"descriptionPage"]];
        [self setNarrator: [dictionary valueForKey: @"narrator"]];
        [self setTopic: [dictionary valueForKey: @"topic"]];
        [self setAudioFileRemoteLocation: [NSURL URLWithString: [dictionary valueForKey: @"audioFileRemoteLocation"]]];
        CLLocationCoordinate2D newCoordinate = {[(NSNumber *)[dictionary valueForKey: @"latitude"] doubleValue], [(NSNumber *)[dictionary valueForKey: @"longitude"] doubleValue]};
        [self setCoordinate: newCoordinate];
    }
    return self;
}

- (void) dealloc {
    [uuid release];
    [title release];
    [subtitle release];
    [descriptionPage release];
    [narrator release];
    [topic release];
    [audioFileRemoteLocation release];
    [super dealloc];
}

- (NSString *) description {
    return [NSString stringWithFormat: @"%@: %@", [self title], [self subtitle]];
}

- (NSURL *) audioFileLocalLocation {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *filename = [paths objectAtIndex:0];
    filename = [filename stringByAppendingPathComponent: [NSString stringWithFormat: @"%@.mp3", [self uuid]]];
    //NSString *filename = [[NSBundle mainBundle] pathForResource: audioFileName ofType: nil];  
    return [NSURL fileURLWithPath: filename];
}

- (NSDictionary *) dictionary {
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc] init];
    
    [resultDictionary setValue: uuid forKey: @"uuid"];
    [resultDictionary setValue: title forKey: @"title"];
    [resultDictionary setValue: subtitle forKey: @"subtitle"];
    [resultDictionary setValue: descriptionPage forKey: @"descriptionPage"];
    [resultDictionary setValue: narrator forKey: @"narrator"];
    [resultDictionary setValue: topic forKey: @"topic"];
    [resultDictionary setValue: [audioFileRemoteLocation absoluteString] forKey: @"audioFileRemoteLocation"];
    [resultDictionary setValue: [NSNumber numberWithDouble: coordinate.latitude ] forKey: @"latitude"];
    [resultDictionary setValue: [NSNumber numberWithDouble: coordinate.longitude ] forKey: @"longitude"];
    
    return [resultDictionary autorelease];
}
@end
