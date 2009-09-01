//
//  UGMapViewController.h
//  ruegenhoeren
//
//  Created by Leon on 8/30/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "UGAudioLocationDatabase.h"

@interface UGMapViewController : UIViewController <MKMapViewDelegate> {

    MKMapView *mapView;
}

@end
