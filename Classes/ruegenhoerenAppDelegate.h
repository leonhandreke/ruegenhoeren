//
//  ruegenhoerenAppDelegate.h
//  ruegenhoeren
//
//  Created by Leon on 8/30/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UGAudioPlayerViewController.h"

@interface ruegenhoerenAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UITabBarController *tabBarController;
    UGAudioPlayerViewController *currentAudioPlayerViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (assign) UGAudioPlayerViewController *currentAudioPlayerViewController;
@end

