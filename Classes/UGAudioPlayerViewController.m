//
//  UGAudioPlayerViewController.m
//  ruegenhoeren
//
//  Created by Leon on 9/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGAudioPlayerViewController.h"


@implementation UGAudioPlayerViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
	// VolumeViewHolder is the frame to hold the slider.  We'll resize the slider to be the size of the frame.
	volumeView = [[[MPVolumeView alloc] initWithFrame:volumeViewHolder.bounds] autorelease];
	[volumeView sizeToFit];
	[volumeViewHolder addSubview:volumeView];
	
	// Find the volume view slider
	for (UIView *view in [volumeView subviews]){
		if ([[[view class] description] isEqualToString:@"MPVolumeSlider"]) {
			volumeViewSlider = view;
		}
	}
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(volumeChanged:) 
												 name:@"AVSystemController_SystemVolumeDidChangeNotification" 
											   object:nil];	
}


- (void) volumeChanged:(NSNotification *)notify
{
	[volumeViewSlider _updateVolumeFromAVSystemController];
}



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


- (void)dealloc {
    [super dealloc];
}


@end
