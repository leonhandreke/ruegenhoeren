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
        // Try to load from the resource bundle first
        NSDictionary *loadedAudioLocationsDictionary = [NSDictionary dictionaryWithContentsOfFile: [self defaultCacheFileLocation]];
        if (loadedAudioLocationsDictionary != nil) {
            mainAudioLocationDatabase = [[UGAudioLocationDatabase alloc] initWithDictionary: loadedAudioLocationsDictionary];
        }
        else {
            mainAudioLocationDatabase = [[UGAudioLocationDatabase alloc] init];
        }		
    }
    return mainAudioLocationDatabase;	
}


- (UGAudioLocationDatabase*) init {
    if (self = [super init]) {
        audioLocations = [[NSMutableArray alloc] init];        
    }
    return self;
}

- (UGAudioLocationDatabase*) initWithDictionary: (NSDictionary *) dictionary {
    if (self = [super init]) {
        audioLocations = [[NSMutableArray alloc] init];
        
        NSEnumerator *dictionaryEnumetator = [[dictionary allValues] objectEnumerator];
        NSDictionary *currentDictionary;
        
        while (currentDictionary = [dictionaryEnumetator nextObject]) {
            UGAudioLocation *newAudioLocation = [[UGAudioLocation alloc] initWithDictionary: currentDictionary];
            [audioLocations addObject: newAudioLocation];
            [newAudioLocation downloadCoverImageIfNeeded];
        }
        
        
    }
    return self;
}


- (NSArray *) audioLocationsForTopic: (NSString *) topic {
    
    NSMutableArray *matchingAudioLocations = [[NSMutableArray alloc] init];
    
    NSEnumerator *audioLocationsEnumerator = [audioLocations objectEnumerator];
    UGAudioLocation *currentAudioLocation;
    
    while (currentAudioLocation = [audioLocationsEnumerator nextObject]) {
        if([[currentAudioLocation topic] isEqualToString: topic]) {
            [matchingAudioLocations addObject: currentAudioLocation];
        }
    }
    return matchingAudioLocations;
}


- (void) addAudioLocation: (UGAudioLocation *) audioLocation {
    [[self audioLocations] addObject: audioLocation];
    [topics release];
    topics = nil;
}

- (NSArray *) topics {
    
    if (topics != nil) {
        return topics;
    }
    else {
        /*DebugLog(@"Generating topics array");*/
        topics = [[NSMutableArray alloc] init];
    }
    
    NSEnumerator *audioLocationsEnumerator = [audioLocations objectEnumerator];
    UGAudioLocation *currentAudioLocation;
    
    while (currentAudioLocation = [audioLocationsEnumerator nextObject]) {
        if([topics indexOfObjectIdenticalTo: [currentAudioLocation topic]] == NSNotFound) {
            [topics addObject: [[currentAudioLocation topic] copy]];
        }
    }
    
    return topics ;
}

- (NSDictionary *) dictionary {
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc] init];
    
    NSEnumerator *audioLocationsEnumerator = [audioLocations objectEnumerator];
    UGAudioLocation *currentAudioLocation;
    
    while (currentAudioLocation = [audioLocationsEnumerator nextObject]) {
        [resultDictionary setValue: [currentAudioLocation dictionary] forKey: [currentAudioLocation uuid]];
    }
    
    return [resultDictionary autorelease];
    
}

+ (NSString *) defaultCacheFileLocation {
    // For now just the App Bundle because the content does not change
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //NSString *cachesDirectory = [paths objectAtIndex:0];
    NSString *cachesDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *path = [cachesDirectory stringByAppendingPathComponent:@"audioLocationsCache.plist"];
    
    return path;    
}

#pragma mark Distance Sorting Stuff

NSInteger distanceSort(id firstAudioLocation, id secondAudioLocation, void *userLocation)
{
    CLLocation *firstLocation = [[CLLocation alloc] initWithCoordinate:[firstAudioLocation coordinate]
                                                              altitude: 0 
                                                    horizontalAccuracy: kCLLocationAccuracyBest
                                                      verticalAccuracy:kCLLocationAccuracyBest 
                                                             timestamp: [NSDate date]];
    
    CLLocation *secondLocation = [[CLLocation alloc] initWithCoordinate:[secondAudioLocation coordinate]
                                                               altitude: 0 
                                                     horizontalAccuracy: kCLLocationAccuracyBest
                                                       verticalAccuracy:kCLLocationAccuracyBest 
                                                              timestamp: [NSDate date]];
    double firstDistance = [(CLLocation *)userLocation getDistanceFrom: firstLocation];
    double secondDistance = [(CLLocation *)userLocation getDistanceFrom: secondLocation];
    
    [firstLocation release];
    [secondLocation release];
    
    if (firstDistance < secondDistance) {
        return NSOrderedAscending;
    }
    else if (firstDistance > secondDistance) {
        return NSOrderedDescending;
    }
    else {
        return NSOrderedSame;
    }
}

+ (NSArray *) sortArray: (NSArray *) array byDistanceFrom: (CLLocation *) newLocation {
    return [array sortedArrayUsingFunction: distanceSort context: newLocation];    
}




@end
