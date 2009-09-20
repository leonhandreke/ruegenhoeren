//
//  UGAudioLocationsDistanceTableViewController.h
//  ruegenhoeren
//
//  Created by Leon on 9/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "UGAudioLocationsTableViewController.h"

@interface UGAudioLocationsDistanceTableViewController : UGAudioLocationsTableViewController <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
}

@property (nonatomic, retain) CLLocationManager *locationManager;  

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;


@end
