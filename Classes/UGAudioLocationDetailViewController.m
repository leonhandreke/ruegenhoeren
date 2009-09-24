//
//  UGAudioLocationDetailViewController.m
//  ruegenhoeren
//
//  Created by Leon on 9/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGAudioLocationDetailViewController.h"


@implementation UGAudioLocationDetailViewController

@synthesize audioLocation;

/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if (self = [super initWithStyle:style]) {
 
 }
 return self;
 }
 */


 - (void)viewDidLoad {
     [super viewDidLoad];
     
     TKOverviewHeaderView *overviewHeaderView = [[TKOverviewHeaderView alloc] init];
     [[overviewHeaderView title] setText: [audioLocation title]];
     [[overviewHeaderView subtitle] setText: [audioLocation subtitle]];
     [[overviewHeaderView indicator] setText: [audioLocation topic]];
     [[overviewHeaderView indicator] setColor: TKOverviewIndicatorViewColorGreen];
     
     [headerView addSubview: overviewHeaderView];
 }


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden: NO animated: YES];
    [[self navigationItem] setTitle: [audioLocation title]];
    [[self navigationItem] setHidesBackButton: NO animated: NO];
}


/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self navigationController] setNavigationBarHidden: YES animated: YES];
}
*/ 
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}
/*
- (void) loadAudioLocationImage {
    NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];
    UIImage *audioLocationImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [audioLocation imageFileLocation]]];
    [imageView setImage: audioLocationImage];
    [apool release];
}*/

- (IBAction) playAudioLocation: (id) sender {
	
	[[(ruegenhoerenAppDelegate *)[[UIApplication sharedApplication] delegate] currentAudioPlayerViewController] release];
	
    UGAudioPlayerViewController *audioPlayerViewController = [[UGAudioPlayerViewController alloc] initWithNibName:@"UGAudioPlayerViewController" 
                                                                                                           bundle: [NSBundle mainBundle] 
                                                                                                        audioFile: [audioLocation audioFileLocation]];
    [[self navigationController] pushViewController: audioPlayerViewController animated: YES];
    [(ruegenhoerenAppDelegate *)[[UIApplication sharedApplication] delegate] setCurrentAudioPlayerViewController: audioPlayerViewController];
}

#pragma mark UIWebViewDelegate

/*
// Disable zoom
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {	
	NSSet *touches = [event allTouches];
	BOOL forwardToSuper = YES;
	for (UITouch *touch in touches) {
		if ([touch tapCount] >= 2) {
			// prevent this 
			forwardToSuper = NO;
		}		
	}
	if (forwardToSuper){
		//return self.superview;
		return [super hitTest:point withEvent:event];
	}
	else {
		// Return the superview as the hit and prevent
		// UIWebView receiving double or more taps
		return self.superview;
	}
}*/

- (void)dealloc {
    [super dealloc];
}


@end

