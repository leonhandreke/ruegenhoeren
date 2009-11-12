//
//  UGAudioLocationsDistanceTableViewController.m
//  ruegenhoeren
//
//  Created by Leon on 9/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGAudioLocationsDistanceTableViewController.h"

@implementation UGAudioLocationsDistanceTableViewController


@synthesize locationManager;
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

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDesiredAccuracy: kCLLocationAccuracyKilometer];
    [locationManager setDelegate: self];
    
    //loadingHUDView = [[LoadingHUDView alloc] init];
    //[loadingHUDView setCenter: [[[self tabBarController] view] center]];
    //[[[self tabBarController] view] addSubview: loadingHUDView];
    //[loadingHUDView setTitle: @"Bestimme Standpunkt"];
    //[loadingHUDView startAnimating];
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [locationManager startUpdatingLocation];
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

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
    [locationManager stopUpdatingLocation];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

/*- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}
*/

#pragma mark Table view methods

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
*/

// Customize the number of rows in the table view.
/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}*/


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [super tableView: tableView cellForRowAtIndexPath: indexPath];
    
	if ([locationManager location] == nil) {
        [[cell detailTextLabel] setText: @"Entfernung Unbekannt"];
    }
    else {
        CLLocation *audioLocationLocation = [[CLLocation alloc] initWithCoordinate: [[filteredAudioLocations objectAtIndex: indexPath.row] coordinate]
                                                                          altitude: 0 
                                                                horizontalAccuracy: kCLLocationAccuracyBest 
                                                                  verticalAccuracy: kCLLocationAccuracyBest 
                                                                         timestamp: [NSDate date]];
        
        CLLocationDistance distanceFromUserLocation = [audioLocationLocation getDistanceFrom: [locationManager location]];
        
        if (distanceFromUserLocation > 1000) {
            // Format as km
            [[cell detailTextLabel] setText: [NSString stringWithFormat: @"%dkm", (int) (distanceFromUserLocation / 1000)]];
        }
        else {
            [[cell detailTextLabel] setText: [NSString stringWithFormat: @"%fm", distanceFromUserLocation]];
        }    
    }
    
    return cell;
}


/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}*/


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
    [self setAudioLocations: [UGAudioLocationDatabase sortArray: audioLocations byDistanceFrom: newLocation]];
    [filteredAudioLocations removeAllObjects];
    [filteredAudioLocations addObjectsFromArray: audioLocations];
    
    //[loadingHUDView stopAnimating];
    [[self tableView] reloadData];
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [loadingHUDView stopAnimating];
	DebugLog(@"CLLocationManager error: %@", [error description]);
}


- (void)dealloc {
    [locationManager release];
    [super dealloc];
}



@end
