/**
 * @class      PluginPlayerViewController PluginPlayerViewController.m "PluginPlayerViewController.m"
 * @brief      A Player that can be used to simply load an embed code and play it
 * @details    PluginPlayerViewController in Ooyala Sample Apps
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */


#import "PluginPlayerViewController.h"
#import "OOSamplePlugin.h"

#import "AppDelegate.h"
#import <OoyalaSDK/OoyalaSDK.h>

@interface PluginPlayerViewController ()
@property OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property NSString *embedCode;
@property NSString *nib;
@property NSString *pcode;
@property NSString *playerDomain;
@end

@implementation PluginPlayerViewController
AppDelegate *appDel;

- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled {
    self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
    self.nib = @"PlayerSimple";
    if (self.playerSelectionOption) {
        self.embedCode = self.playerSelectionOption.embedCode;
        self.title = self.playerSelectionOption.title;
        self.pcode = self.playerSelectionOption.pcode;
        self.playerDomain = self.playerSelectionOption.domain;
    } else {
        NSLog(@"There was no PlayerSelectionOption!");
        return nil;
    }
    return self;
}


- (void)loadView {
    [super loadView];
    [[NSBundle mainBundle] loadNibNamed:self.nib owner:self options:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDel = [[UIApplication sharedApplication] delegate];
    
    // Create Ooyala ViewController
    OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain]];
    self.ooyalaPlayerViewController = [[OOOoyalaPlayerViewController alloc] initWithPlayer:player];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector:@selector(notificationHandler:)
                                                 name:nil
                                               object:_ooyalaPlayerViewController.player];
    // In QA Mode , making textView visible
    if(self.qaModeEnabled==YES){
        self.textView.hidden = NO;
        
    }
    
    
    // Attach it to current view
    [self addChildViewController:_ooyalaPlayerViewController];
    [self.playerView addSubview:_ooyalaPlayerViewController.view];
    [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];
    
    
    
    OOSamplePlugin *plugin = [[OOSamplePlugin alloc] initWithPlayer:self.ooyalaPlayerViewController.player];
    [self.ooyalaPlayerViewController.player registerPlugin:plugin];
    
    // Load the video
    [_ooyalaPlayerViewController.player setEmbedCode:self.embedCode];
    [_ooyalaPlayerViewController.player play];
}

- (void) notificationHandler:(NSNotification*) notification {
    
    // Ignore TimeChangedNotificiations for shorter logs
    if ([notification.name isEqualToString:OOOoyalaPlayerTimeChangedNotification]) {
        return;
    }
    
    NSString *message = [NSString stringWithFormat:@"Notification Received: %@. state: %@. playhead: %f count: %d",
                         [notification name],
                         [OOOoyalaPlayer playerStateToString:[self.ooyalaPlayerViewController.player state]],
                         [self.ooyalaPlayerViewController.player playheadTime], appDel.count];
    
    NSLog(@"%@",message);
    
    //In QA Mode , adding notifications to the TextView
    if(self.qaModeEnabled==YES) {
        NSString *string = self.textView.text;
        NSString *appendString = [NSString stringWithFormat:@"%@ :::::::::: %@" ,string, message];
        [self.textView setText:appendString];
    }
    appDel.count++;
}

@end
