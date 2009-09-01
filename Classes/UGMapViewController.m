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
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


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
    
    mapView = [[MKMapView alloc] initWithFrame: [[self view] bounds]];
	[mapView setDelegate: self];
    [mapView setRegion: ruegenRegion animated: NO];
    [[self view] insertSubview: mapView atIndex: 0];
    
    // Insert the location markers
    
    [UGAudioLocationDatabase sharedAudioLocationDatabase];
    
    NSEnumerator *audioLocationsEnumerator = [[[UGAudioLocationDatabase sharedAudioLocationDatabase] audioLocations] objectEnumerator];
	UGAudioLocation *currentLocation;
	
	while (currentLocation = [audioLocationsEnumerator nextObject]) {
		[mapView addAnnotation: currentLocation];
	}
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
	//[annotationView setAnimatesDrop: NO];
	return annotationView;
}

@end
