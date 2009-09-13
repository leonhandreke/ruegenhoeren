//
//  UGAudioPlayerViewController.h
//  ruegenhoeren
//
//  Created by Leon on 9/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface UGAudioPlayerViewController : UIViewController {

    NSURL *audioFileLocation;
    
    AVAudioPlayer *audioPlayer;
    
    IBOutlet UISlider *scrubberSlider;
    IBOutlet UILabel *doneTimeLabel;
    IBOutlet UILabel *remainingTimeLabel;
    
    IBOutlet UIImageView *backgroundView;
    IBOutlet UITextView *descriptionView;
    
    IBOutlet UIView *volumeViewHolder;
    IBOutlet UIView *volumeViewSlider;
    MPVolumeView *volumeView;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil audioFile: (NSURL *) newAudioFileLocation;

- (void) volumeChanged:(NSNotification *)notify;
- (void) updateDurationScrubber;

@end
