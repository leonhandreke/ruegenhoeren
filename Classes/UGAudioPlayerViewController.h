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

#import "UGAudioLocation.h"
@interface UGAudioPlayerViewController : UIViewController {

    UGAudioLocation *audioLocation;
    
    AVAudioPlayer *audioPlayer;
    
    NSTimer *updateDurationTimer;
    
    IBOutlet UIButton *playPauseButton;
    
    IBOutlet UISlider *scrubberSlider;
    IBOutlet UILabel *doneTimeLabel;
    IBOutlet UILabel *remainingTimeLabel;
    IBOutlet UIImageView *backgroundImageView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *subtitleLabel;
    
    IBOutlet UIView *volumeViewHolder;
    UIView *volumeViewSlider;
    MPVolumeView *volumeView;
    
}

- (void) volumeChanged:(NSNotification *)notify;
- (void) updateDurationScrubber;

- (IBAction) togglePlayPause: (id) sender;
- (IBAction) scrubberSliderMoved: (id) sender;

- (IBAction) disableScrubberUpdate: (id) sender;
- (IBAction) enableScrubberUpdate: (id) sender;

@property (assign) UGAudioLocation *audioLocation;

@end

@interface NSObject (UGAudioPlayerViewController)
// For the volume slider update method...
- (void) _updateVolumeFromAVSystemController;
@end
