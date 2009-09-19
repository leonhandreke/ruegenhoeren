//
//  ruegenhoerenAppDelegate.m
//  ruegenhoeren
//
//  Created by Leon on 8/30/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ruegenhoerenAppDelegate.h"
#import "UGMapViewController.h"


@implementation ruegenhoerenAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize navigationController;
@synthesize currentAudioPlayerViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
    [navigationController pushViewController: tabBarController animated: NO];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
    [navigationController release];
	[tabBarController release];
	[window release];
	[super dealloc];
}

@end
