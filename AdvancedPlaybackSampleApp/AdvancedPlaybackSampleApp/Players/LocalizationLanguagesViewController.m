//
//  LocalizationLanguagesViewController.m
//  AdvancedPlaybackSampleApp
//
//  Created on 10/5/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import "LocalizationLanguagesViewController.h"
#import <OoyalaSDK/OoyalaSDK.h>
#import "AppDelegate.h"

@interface LocalizationLanguagesViewController ()

@property (nonatomic) OOOoyalaPlayerViewController *ooyalaPlayerViewController;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *playerDomain;

@end

@implementation LocalizationLanguagesViewController{
    AppDelegate *appDel;
}
- (id)initWithPlayerSelectionOption:(PlayerSelectionOption *)playerSelectionOption qaModeEnabled:(BOOL)qaModeEnabled{
    self = [super initWithPlayerSelectionOption: playerSelectionOption qaModeEnabled:qaModeEnabled];
    self.nib = @"PlayerSimple";
    if (self && self.playerSelectionOption) {
        _embedCode = self.playerSelectionOption.embedCode;
        self.title = self.playerSelectionOption.title;
        _pcode = self.playerSelectionOption.pcode;
        _playerDomain = self.playerSelectionOption.domain;
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
                                               object:self.ooyalaPlayerViewController.player];
    
    // In QA Mode , making textView visible
    if(self.qaModeEnabled==YES){
        self.textView.hidden = NO;
        
    }
    
    // Add french localization strings and modify some english
    NSDictionary *updatedLocalization = [self updateLocalizedLanguages:[OOOoyalaPlayerViewController availableLocalizations]];
    [OOOoyalaPlayerViewController setAvailableLocalizations:updatedLocalization];
    
    // Attach it to current view
    [self addChildViewController:self.ooyalaPlayerViewController];
    [self.playerView addSubview:self.ooyalaPlayerViewController.view];
    [self.ooyalaPlayerViewController.view setFrame:self.playerView.bounds];
    
    if ([self.ooyalaPlayerViewController.player setEmbedCode:self.embedCode]) {
        [self.ooyalaPlayerViewController.player play];
    }
}

- (NSDictionary *)updateLocalizedLanguages:(NSDictionary *)languages {
    NSMutableDictionary *mutableLanguages = [languages mutableCopy];
    NSMutableDictionary *french = [mutableLanguages[@"en"] mutableCopy];
    french[@"Done"] = @"Fini";
    french[@"Languages"] = @"Langues";
    french[@"Subtitles"] = @"Sous-titres";
    mutableLanguages[@"fr"] = french;
    
    NSMutableDictionary *english = [mutableLanguages[@"en"] mutableCopy];
    english[@"Done"] = @"Set";
    english[@"Languages"] = @"Words";
    english[@"Subtitles"] = @"Closed captions";
    mutableLanguages[@"en"] = english;
    return mutableLanguages;
}

- (void) notificationHandler:(NSNotification*) notification {
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
