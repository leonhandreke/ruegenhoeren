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

/*
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden: NO animated: YES];
    [[self navigationItem] setTitle: @"Audio Location"];
    [[self navigationItem] setHidesBackButton: NO animated: NO];
    
    
    UIFont *descriptionFont = [UIFont fontWithName: @"Helvetica" size: 17];
    
    CGSize descriptionSize = [[audioLocation description] sizeWithFont: descriptionFont constrainedToSize: CGSizeMake(320, CGFLOAT_MAX)];
    NSLog(@"%f", descriptionSize.height);
    
    // Resize the content view to fit the text view
    // Do not ask me why bound /2, it works
    CGRect scrollViewContentViewBounds = CGRectMake([scrollViewContentView bounds].origin.x, [scrollViewContentView bounds].origin.y - descriptionSize.height / 2,
                                                    [scrollViewContentView bounds].size.width, [scrollViewContentView bounds].size.height + descriptionSize.height);
    [scrollViewContentView setBounds: scrollViewContentViewBounds];
    
    CGRect descriptionTextViewBounds = CGRectMake([descriptionTextView bounds].origin.x, [descriptionTextView bounds].origin.y,
     [descriptionTextView bounds].size.width, descriptionSize.height);
     [descriptionTextView setS];
    
    
    [descriptionTextView setText: [audioLocation description]];
    
    
    [scrollView setContentSize: scrollViewContentView.bounds.size];
    [scrollView addSubview: scrollViewContentView];
    
    [titleLabel setText: [audioLocation title]];
    
    
    
    [self performSelectorInBackground: @selector(loadAudioLocationImage) withObject: nil];
    
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

- (void) loadAudioLocationImage {
    NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];
    UIImage *audioLocationImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [audioLocation imageFileLocation]]];
    [imageView setImage: audioLocationImage];
    [apool release];
}

- (void)dealloc {
    [super dealloc];
}


@end

