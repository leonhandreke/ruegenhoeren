//
//  UGAudioPlayerViewController.h
//  ruegenhoeren
//
//  Created by Leon on 9/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface UGAudioPlayerViewController : UIViewController {

    IBOutlet UIProgressView *progressView;
    IBOutlet UILabel *doneTimeLabel;
    IBOutlet UILabel *remainingTimeLabel;
    
    IBOutlet UIImageView *backgroundView;
    IBOutlet UITextView *descriptionView;
    
    IBOutlet UIView *volumeViewHolder;
    IBOutlet UIView *volumeViewSlider;
    MPVolumeView *volumeView;
    
}

@end
