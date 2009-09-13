//
//  UGMapViewController.m
//  ruegenhoeren
//
//  Created by Leon on 8/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGMapViewController.h"


@implementation UGMapViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
        NSLog(@"Chello");
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
/*- (void)loadView {
    //[super loadView];
    
}*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*Region and Zoom*/
    MKCoordinateRegion ruegenRegion;
    MKCoordinateSpan span;
    span.latitudeDelta=0.3;
    span.longitudeDelta=0.5;
    
    CLLocationCoordinate2D ruegenCenter = {54.390154, 13.364868};

    ruegenRegion.span=span;
    ruegenRegion.center=ruegenCenter;
    
    [(MKMapView *)[self view] setRegion: ruegenRegion animated: NO];
    
    // Insert the location markers
    
    [UGAudioLocationDatabase sharedAudioLocationDatabase];
    
    NSEnumerator *audioLocationsEnumerator = [[[UGAudioLocationDatabase sharedAudioLocationDatabase] audioLocations] objectEnumerator];
	UGAudioLocation *currentLocation;
	
	while (currentLocation = [audioLocationsEnumerator nextObject]) {
		[(MKMapView *)[self view] addAnnotation: currentLocation];
	}
}

- (void) viewWillAppear: (BOOL) animated {
    [super viewWillAppear: animated];
    [[self navigationController] setNavigationBarHidden: YES animated: YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark MKMapViewDelegate

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation {
    
	MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: [annotation title]];
    
    // Set up the Left callout
    UIButton *myDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myDetailButton.frame = CGRectMake(0, 0, 25, 25);
    myDetailButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    myDetailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    // Set the image for the button
    [myDetailButton setImage:[UIImage imageNamed:@"rightarrow.png"] forState:UIControlStateNormal];
    [myDetailButton addTarget:self action:@selector(showAudioLocationDetailView:) forControlEvents:UIControlEventTouchUpInside];
    
    // The UIView tag becomes the index of the annotation
    NSInteger viewTag = [[[UGAudioLocationDatabase sharedAudioLocationDatabase] audioLocations] indexOfObject: annotation];
    myDetailButton.tag = viewTag;
    
    // Set the button as the callout view
    annotationView.rightCalloutAccessoryView = myDetailButton;
    
    [annotationView setCanShowCallout: YES];
	//[annotationView setAnimatesDrop: NO];
	return annotationView;
}

- (IBAction) showAudioLocationDetailView: (id) sender {
    UGAudioLocationDetailViewController *detailViewController = [[UGAudioLocationDetailViewController alloc] initWithNibName: @"UGAudioLocationDetailViewController" bundle: [NSBundle mainBundle]];
    [detailViewController setAudioLocation: [[[UGAudioLocationDatabase sharedAudioLocationDatabase] audioLocations] objectAtIndex: [(UIView *) sender tag]]];
    [[(ruegenhoerenAppDelegate *)[[UIApplication sharedApplication] delegate] navigationController] pushViewController: detailViewController animated: YES];
}

@end
