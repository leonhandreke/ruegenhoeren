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
        audioLocations = [[NSMutableArray alloc] init];
        
        UGAudioLocation *woorkeAudioLocation = [[UGAudioLocation alloc] init];
        [woorkeAudioLocation setTitle: @"Hügelgräberfeld \"Woorker Berge\""];
		CLLocationCoordinate2D woorkeLocation = {54.447286617183636, 13.410186767578125};
        [woorkeAudioLocation setCoordinate: woorkeLocation];
        [woorkeAudioLocation setDescription: @"Von Bergen aus gelangt man über Parchtitz, Thesenvitz und Patzig zum kleinen Dorf Woorke. Östlich des Ortes liegt eine Gruppe von 13 Hügelgräbern der Bronzezeit, die sich schon von weitem als kleine Waldinseln in den Feldern abzeichnen. Folgt man dem Feldweg, gelangt man zu einem Rastplatz mit Infotafel, der direkt zu Füßen eines der bis zu 6m hohen Grabhügel liegt."];
        [woorkeAudioLocation setImageFileLocation: [NSURL URLWithString: @"http://icanhascheezburger.files.wordpress.com/2009/08/funny-pictures-cat-came-in-mail.jpg"]];
		[woorkeAudioLocation setAudioFileName: @"9PM.mp3"];
        
		[self addAudioLocation: woorkeAudioLocation];
    }
    return self;
}

- (void) addAudioLocation: (UGAudioLocation *) audioLocation {
    [[self audioLocations] addObject: audioLocation];
}

@end
