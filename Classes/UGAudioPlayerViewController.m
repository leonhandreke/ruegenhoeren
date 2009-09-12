//
//  UGAudioPlayerViewController.m
//  ruegenhoeren
//
//  Created by Leon on 9/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGAudioPlayerViewController.h"


@implementation UGAudioPlayerViewController


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil audioFile: (NSURL *) newAudioFileLocation {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
        audioFileLocation = newAudioFileLocation;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileLocation error: nil];
        
        //Initialize the custom UISlider
        scrubberSlider.backgroundColor = [UIColor clearColor];  
        UIImage *stetchLeftTrack = [[UIImage imageNamed:@"blueTrack.png"]
                                    stretchableImageWithLeftCapWidth:9.0 topCapHeight:0.0];
        UIImage *stetchRightTrack = [[UIImage imageNamed:@"whiteTrack.png"]
                                     stretchableImageWithLeftCapWidth:9.0 topCapHeight:0.0];
        [scrubberSlider setThumbImage: [UIImage imageNamed:@"whiteSlide.png"] forState:UIControlStateNormal];
        [scrubberSlider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
        [scrubberSlider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden: NO animated: YES];
    
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

- (void) viewDidAppear: (BOOL) animated {
    [super viewDidAppear: animated];
    
    [audioPlayer play];
}

//- (void) updateDurationScrubber

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
