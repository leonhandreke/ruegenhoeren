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
    
    NSString *resourcePath = [[NSBundle mainBundle] bundlePath];
    NSURL *resourceURL = [NSURL fileURLWithPath: resourcePath];
    [webView loadHTMLString: [audioLocation descriptionPage] baseURL: resourceURL];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden: NO animated: YES];
    [[self navigationItem] setTitle: [audioLocation title]];
    [self updatePlayDownloadIcon];
}

- (BOOL)hidesBottomBarWhenPushed {
	return TRUE;
}


/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
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
    // File exists, go play it...
    
    [[(ruegenhoerenAppDelegate *)[[UIApplication sharedApplication] delegate] currentAudioPlayerViewController] release];
    
    UGAudioPlayerViewController *audioPlayerViewController = [[UGAudioPlayerViewController alloc] initWithNibName:@"UGAudioPlayerViewController" 
                                                                                                           bundle: [NSBundle mainBundle]];
    [audioPlayerViewController setAudioLocation: [self audioLocation]];
    [[self navigationController] pushViewController: audioPlayerViewController animated: YES];
    [(ruegenhoerenAppDelegate *)[[UIApplication sharedApplication] delegate] setCurrentAudioPlayerViewController: audioPlayerViewController];
    
}

- (IBAction) downloadAudioLocation: (id) sender {
	
    
    // Looks like we have to download the file first...
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(-140, -18, 280, 25)];
    [progressView setProgress: 0.0];
    [progressView setProgressViewStyle: UIProgressViewStyleBar];
    progressView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                     UIViewAutoresizingFlexibleRightMargin |
                                     UIViewAutoresizingFlexibleTopMargin |
                                     UIViewAutoresizingFlexibleBottomMargin);
    downloadProgressBar = progressView;
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Downloade Hörstation"
                                                      delegate:self
                                             cancelButtonTitle:nil
                                        destructiveButtonTitle: @"Abbrechen"
                                             otherButtonTitles:nil];
    downloadActionSheet = menu;
    
    [menu addSubview:progressView];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0,0,320, 175)];
    
    
    
    NSURLRequest *audioFileRequest = [NSURLRequest requestWithURL: [audioLocation audioFileRemoteLocation]];
    UGDownload *fileDownload = [[UGDownload alloc] initWithRequest:audioFileRequest 
                                                       destination: [[audioLocation audioFileLocalLocation] path] 
                                                          delegate: self];
    download = fileDownload;
    [fileDownload start];
}

- (void) updatePlayDownloadIcon {
    
    UIBarButtonItem *button;
    UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil] autorelease];
    
    if([[NSFileManager defaultManager] fileExistsAtPath: [[[self audioLocation] audioFileLocalLocation] path]]) {
        button = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemPlay target: self action: @selector(playAudioLocation:)] autorelease];

    }
    else {
        button = [[[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"57-download.png"] style: UIBarButtonItemStylePlain target: self action: @selector(downloadAudioLocation:)] autorelease];
    }
    NSArray *toolbarItems = [NSArray arrayWithObjects: flexibleSpace, button, flexibleSpace, nil];
    [toolbar setItems: toolbarItems];
    
}

#pragma mark UIActionSheetDelegate

- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    [download cancel];
    [download release];
    download = nil;
}


#pragma mark UGDownload delegate

- (void)downloadDidFinish: (UGDownload *) aDownload {
    [downloadActionSheet dismissWithClickedButtonIndex: 0 animated: YES];
    [downloadActionSheet release];
    downloadActionSheet = nil;
    [downloadProgressBar release];
    downloadProgressBar = nil;
    
    // Make a nice play button
    [self updatePlayDownloadIcon];
}

- (void)download: (UGDownload *) aDownload didReceiveDataOfLength: (NSUInteger) dataLength {
    [downloadProgressBar setProgress: [download progress]];
}


- (void)dealloc {
    [super dealloc];
}


@end

