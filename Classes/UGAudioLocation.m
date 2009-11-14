//
//  UGAudioLocation.m
//  ruegenhoeren
//
//  Created by Leon on 8/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGAudioLocation.h"


@implementation UGAudioLocation

@synthesize uuid, title, subtitle, descriptionPage, narrator, topic, coverImageRemoteLocation, coordinate, audioFileRemoteLocation;

- (UGAudioLocation *) initWithDictionary: (NSDictionary *) dictionary {
    if (self = [self init]) {
        [self setUuid: [dictionary valueForKey: @"uuid"]];
        [self setTitle: [dictionary valueForKey: @"title"]];
        [self setSubtitle: [dictionary valueForKey: @"subtitle"]];
        [self setDescriptionPage: [dictionary valueForKey: @"descriptionPage"]];
        [self setNarrator: [dictionary valueForKey: @"narrator"]];
        [self setTopic: [dictionary valueForKey: @"topic"]];
        [self setAudioFileRemoteLocation: [[NSURL alloc] initWithString: [[dictionary valueForKey: @"audioFileRemoteLocation"] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]];
        [self setCoverImageRemoteLocation: [[NSURL alloc] initWithString: [[dictionary valueForKey: @"coverImageRemoteLocation"] stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding]]];
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
    [coverImageRemoteLocation release];
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

- (NSString *) coverImageLocalLocation {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES); 
    NSString *filename = [paths objectAtIndex:0];
    filename = [filename stringByAppendingPathComponent: [NSString stringWithFormat: @"%@.jpg", [[[[self coverImageRemoteLocation] path] lastPathComponent] md5Hash]]];
    //NSString *filename = [[NSBundle mainBundle] pathForResource: audioFileName ofType: nil];  
    return filename;
}

- (void) downloadCoverImageIfNeeded {
    if (![[NSFileManager defaultManager] fileExistsAtPath: [self coverImageLocalLocation]]) {
        //NSLog(@"download cover image: %@", [self coverImageRemoteLocation]);
        [[NSFileManager defaultManager] createDirectoryAtPath: [self coverImageLocalLocation] attributes: nil];
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL: coverImageRemoteLocation];
        UGDownload *imageDownload = [[UGDownload alloc] initWithRequest: imageRequest destination: [self coverImageLocalLocation] delegate: self];
        [imageDownload start];
    }
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

- (void)downloadDidFinish: (UGDownload *) aDownload {
    [aDownload release];
}
@end
