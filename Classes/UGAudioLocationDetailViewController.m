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
     /*
     TKOverviewHeaderView *overviewHeaderView = [[TKOverviewHeaderView alloc] init];
     [[overviewHeaderView title] setText: [audioLocation title]];
     [[overviewHeaderView subtitle] setText: [audioLocation subtitle]];
     [[overviewHeaderView indicator] setText: [audioLocation topic]];
     [[overviewHeaderView indicator] setColor: TKOverviewIndicatorViewColorGreen];
     
     [headerView addSubview: overviewHeaderView];*/
     
     //[webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com/ncr"]]];
     NSString *resourcePath = [[NSBundle mainBundle] bundlePath];
     NSURL *resourceURL = [NSURL fileURLWithPath: resourcePath];
     [webView loadHTMLString: [audioLocation descriptionPage] baseURL: resourceURL];
 }


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden: NO animated: YES];
    [[self navigationItem] setTitle: [audioLocation title]];
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

- (IBAction) playOrDownloadAudioLocation: (id) sender {
	
    if([[NSFileManager defaultManager] fileExistsAtPath: [[[self audioLocation] audioFileLocalLocation] absoluteString]]) {
        // File exists, go play it...
        
        [[(ruegenhoerenAppDelegate *)[[UIApplication sharedApplication] delegate] currentAudioPlayerViewController] release];
        
        UGAudioPlayerViewController *audioPlayerViewController = [[UGAudioPlayerViewController alloc] initWithNibName:@"UGAudioPlayerViewController" 
                                                                                                               bundle: [NSBundle mainBundle]];
        [audioPlayerViewController setAudioLocation: [self audioLocation]];
        [[self navigationController] pushViewController: audioPlayerViewController animated: YES];
        [(ruegenhoerenAppDelegate *)[[UIApplication sharedApplication] delegate] setCurrentAudioPlayerViewController: audioPlayerViewController];
        
    }
    else {
        
        // Looks like we have to download the file first...
        
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(-140, -18, 280, 25)];
        [progressView setProgress: 0.5];
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
        UGDownload *fileDowload = [[UGDownload alloc] initWithRequest:audioFileRequest 
                                                          destination: [[audioLocation audioFileLocalLocation] path] 
                                                             delegate: self];
        [fileDowload start];
    }
}

#pragma mark UIActionSheetDelegate

- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    
}


#pragma mark UGDownload delegate

- (void)downloadDidFinish: (UGDownload *) download {
    [downloadProgressBar release];
    downloadProgressBar = nil;
}

- (void)download: (UGDownload *) download didReceiveDataOfLength: (NSUInteger) dataLength {
    [downloadProgressBar setProgress: [download progress]];
}


- (void)dealloc {
    [super dealloc];
}


@end

