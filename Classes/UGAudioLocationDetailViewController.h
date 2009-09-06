//
//  UGAudioLocationDetailViewController.h
//  ruegenhoeren
//
//  Created by Leon on 9/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
 
//Private header 
//#import "UINavigationButton.h"

#import "UGAudioLocation.h"

@interface UGAudioLocationDetailViewController : UIViewController {

    UGAudioLocation *audioLocation;
    IBOutlet UINavigationBar *navigationBar;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIView *scrollViewContentView;
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UITextView *descriptionTextView;
    IBOutlet UIImageView *imageView;
    
}

@property (assign) UGAudioLocation *audioLocation;


@end
