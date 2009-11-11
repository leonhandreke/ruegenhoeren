//
//  UGAudioLocationsTableViewController.m
//  ruegenhoeren
//
//  Created by Leon on 9/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UGAudioLocationsTableViewController.h"


@implementation UGAudioLocationsTableViewController

@synthesize audioLocations, filteredAudioLocations;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
            
    }
    return self;
}*/



- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationItem] setTitle: @"Hörstationen"];
    
    [self setFilteredAudioLocations: [NSMutableArray array]];
    [self setAudioLocations: [[UGAudioLocationDatabase sharedAudioLocationDatabase] audioLocations]];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //NSLog(@"%@", filteredAudioLocations);
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    [searchBar resignFirstResponder];
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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [filteredAudioLocations count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"AudioLocationCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [[cell textLabel] setText: [[filteredAudioLocations objectAtIndex: indexPath.row] title]];
    [[cell detailTextLabel] setText: [[filteredAudioLocations objectAtIndex: indexPath.row] subtitle]];
    
	[cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
    UGAudioLocation * selectedAudioLocation = (UGAudioLocation *)[filteredAudioLocations objectAtIndex: indexPath.row];
	
    UGAudioLocationDetailViewController *detailViewController = [[UGAudioLocationDetailViewController alloc] initWithNibName: @"UGAudioLocationDetailViewController" bundle: [NSBundle mainBundle]];
    [detailViewController setAudioLocation: selectedAudioLocation];
    [[self navigationController] pushViewController: detailViewController animated: YES];
}


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

#pragma mark property override

- (void) setAudioLocations:(NSArray *) newAudioLocations {
    [audioLocations release];
    audioLocations = [newAudioLocations retain];
    
    [filteredAudioLocations removeAllObjects];
    [filteredAudioLocations addObjectsFromArray: audioLocations];
}

#pragma mark UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText isEqualToString: @""]) {
        [filteredAudioLocations removeAllObjects];
        [filteredAudioLocations addObjectsFromArray: audioLocations];
        return;
    }
    
    [filteredAudioLocations removeAllObjects];
    
    NSEnumerator *audioLocationsEnumerator = [audioLocations objectEnumerator];
    UGAudioLocation *currentAudioLocation;
    
    while (currentAudioLocation = [audioLocationsEnumerator nextObject]) {
        NSRange titleRange = [[currentAudioLocation title] rangeOfString: searchText options: (NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        NSRange descriptionRange = [[currentAudioLocation description] rangeOfString: searchText options: (NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        
        if (titleRange.location != NSNotFound || descriptionRange.location != NSNotFound)
        {
            [filteredAudioLocations addObject:currentAudioLocation];
        }
    }

    [[self tableView] reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)clickedSearchBar
{
    [clickedSearchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)clickedSearchBar
{
    [clickedSearchBar resignFirstResponder];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)clickedSearchBar {  
    [clickedSearchBar setShowsCancelButton: YES animated: YES];
    return YES;
}  

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)clickedSearchBar {  
    [clickedSearchBar setShowsCancelButton: NO animated: YES];
    return YES;
}  

- (void)dealloc {
    [super dealloc];
}


@end

