//
//  UGAudioPlayerViewController.m
//  ruegenhoeren
//
//  Created by Leon on 9/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGAudioPlayerViewController.h"


@implementation UGAudioPlayerViewController

@synthesize audioLocation;

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
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: [audioLocation audioFileLocalLocation] error: nil];
    
    //Initialize the custom UISlider
    scrubberSlider.backgroundColor = [UIColor clearColor];  
    UIImage *stetchLeftTrack = [[UIImage imageNamed:@"bluetrack.png"]
                                stretchableImageWithLeftCapWidth:9.0 topCapHeight:0.0];
    UIImage *stetchRightTrack = [[UIImage imageNamed:@"whitetrack.png"]
                                 stretchableImageWithLeftCapWidth:9.0 topCapHeight:0.0];
    [scrubberSlider setThumbImage: [UIImage imageNamed:@"whiteslide.png"] forState:UIControlStateNormal];
    [scrubberSlider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [scrubberSlider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    
    [scrubberSlider setMaximumValue: [audioPlayer duration]];
    
    [[self navigationItem] setTitle: [audioLocation title]];
    
    //updateDurationTimer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(updateDurationScrubber) userInfo: nil repeats: YES];
    
    /*NSString *resourcePath = [[NSBundle mainBundle] bundlePath];
    NSURL *resourceURL = [NSURL fileURLWithPath: resourcePath];
    [webView loadHTMLString: [audioLocation descriptionPage] baseURL: resourceURL];*/
    
    [titleLabel setText: [audioLocation title]];
    [subtitleLabel setText: [audioLocation subtitle]];
    

    
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

- (void) viewWillAppear: (BOOL) animated {
    updateDurationTimer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(updateDurationScrubber) userInfo: nil repeats: YES];
    
}

- (void) viewDidAppear: (BOOL) animated {
    [super viewDidAppear: animated];
    [audioPlayer play];
}

- (void) viewDidDisappear: (BOOL) animated {
    [updateDurationTimer invalidate];
    [super viewDidDisappear: animated];
}

- (void) updateDurationScrubber {
    
    NSNumber *timeDone = [NSNumber numberWithDouble: [audioPlayer currentTime]];
    NSNumber *timeRemaining = [NSNumber numberWithDouble: [audioPlayer duration] - [audioPlayer currentTime]];
    
    NSString *doneLabelValue = [NSString stringWithFormat: @"%02d:%02d", [timeDone intValue] / 60, [timeDone intValue] % 60];
    NSString *remainingLabelValue = [NSString stringWithFormat: @"-%02d:%02d", [timeRemaining intValue] / 60, [timeRemaining intValue] % 60];
    
    NSNumber *sliderValue =  timeDone;
    
    [doneTimeLabel setText: doneLabelValue];
    [remainingTimeLabel setText: remainingLabelValue];
    [scrubberSlider setValue: [sliderValue doubleValue]];

}

- (IBAction) togglePlayPause: (id) sender {
    if ([audioPlayer isPlaying]) {
        [audioPlayer pause];
        [playPauseButton setImage: [UIImage imageNamed: @"play.png"] forState: UIControlStateNormal];
    }
    else {
        [audioPlayer play];
        [playPauseButton setImage: [UIImage imageNamed: @"pause.png"] forState: UIControlStateNormal];
    }
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction) scrubberSliderMoved: (id) sender {
    [audioPlayer setCurrentTime: [scrubberSlider value]];
}


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
    
	[audioPlayer release];
    [super dealloc];
}

@end
