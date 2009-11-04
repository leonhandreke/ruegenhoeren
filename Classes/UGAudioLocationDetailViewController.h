//
//  UGAudioLocationDetailViewController.h
//  ruegenhoeren
//
//  Created by Leon on 9/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
 
#import "UGDownload.h"

#import "ruegenhoerenAppDelegate.h"
#import "UGAudioLocation.h"
#import "UGAudioPlayerViewController.h"

@interface UGAudioLocationDetailViewController : UIViewController <UIWebViewDelegate> {

    UGAudioLocation *audioLocation;
    
    IBOutlet UIWebView *webView;
    
    //IBOutlet UIBarButtonItem *
    
}

- (BOOL)hidesBottomBarWhenPushed;
- (IBAction) playAudioLocation: (id) sender;

@property (assign) UGAudioLocation *audioLocation;


@end
