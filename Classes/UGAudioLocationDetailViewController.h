//
//  UGAudioLocationDetailViewController.h
//  ruegenhoeren
//
//  Created by Leon on 9/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
 
#import "UGDownload.h"
#import "NSData+MBBase64.h"
#import "ruegenhoerenAppDelegate.h"
#import "UGAudioLocation.h"
#import "UGAudioPlayerViewController.h"

@interface UGAudioLocationDetailViewController : UIViewController <UIWebViewDelegate, UIActionSheetDelegate> {

    UGAudioLocation *audioLocation;
    
    IBOutlet UIToolbar *toolbar;
    IBOutlet UIBarButtonItem *playDownloadButton;
    IBOutlet UIWebView *webView;
    
    UIProgressView *downloadProgressBar;
    UIActionSheet *downloadActionSheet;
    UGDownload *download;
    
}

- (BOOL)hidesBottomBarWhenPushed;
- (IBAction) playAudioLocation: (id) sender;
- (IBAction) downloadAudioLocation: (id) sender;

- (void) updatePlayDownloadIcon;

#pragma mark UGDownload delegate
- (void)downloadDidFinish: (UGDownload *) download;
- (void)download: (UGDownload *) download didReceiveDataOfLength: (NSUInteger) dataLength;

#pragma mark UIActionSheetDelegate
- (void)actionSheetCancel:(UIActionSheet *)actionSheet;

@property (assign) UGAudioLocation *audioLocation;


@end
