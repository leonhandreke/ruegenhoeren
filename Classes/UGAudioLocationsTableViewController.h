//
//  UGAudioLocationsTableViewController.h
//  ruegenhoeren
//
//  Created by Leon on 9/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ruegenhoerenAppDelegate.h"
#import "UGAudioLocationDatabase.h"
#import "UGAudioLocation.h"
#import "UGAudioLocationDetailViewController.h"

@interface UGAudioLocationsTableViewController : UITableViewController <UISearchBarDelegate> {

    NSArray *audioLocations;
    NSMutableArray *filteredAudioLocations;
    
    IBOutlet UISearchBar *searchBar;
    
}


@property (retain) NSArray *audioLocations;
@property (retain) NSArray *filteredAudioLocations;

@end
