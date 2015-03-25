/**
 * @file       OOOoyalaPlayerViewController.m
 * @brief      Implementation of OOOoyalaPlayerViewController
 * @details    OOOoyalaPlayerViewController.m in OoyalaSDK
 * @date       1/9/12
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */
#import "OOOoyalaPlayerViewController.h"
#import "OOClosedCaptionsSelectorBackgroundViewController.h"
#import "OOFullScreenIOS7ViewController.h"
#import "OOInlineIOS7ViewController.h"
#import "OOFullscreenIOS7ViewController.h"
#import "OOClosedCaptionsSelectorViewController.h"
#import "OOOoyalaAPIClient.h"
#import "OOPlayerDomain.h"
#import "OODebugMode.h"

NSString *const TAG = @"OOOoyalaPlayerViewController";
NSString *const OOOoyalaPlayerViewControllerFullscreenEnter = @"fullscreenEnter";
NSString *const OOOoyalaPlayerViewControllerFullscreenExit = @"fullscreenExit";
NSString *const OOOoyalaPlayerViewControllerDoneClicked = @"doneClicked";
NSString *const OOOoyalaPlayerViewControllerInlineViewVisible = @"fullscreenViewVisible";
NSString *const OOOoyalaPlayerViewControllerFullscreenViewVisible = @"inlineViewVisible";

@interface OOOoyalaPlayerViewController() {
  BOOL initialLoad;
  UIView* _inlineOverlay;
  UIView* _fullscreenOverlay;
  BOOL fullscreenQueued;
@private
  BOOL isClosedCaptionsEnabled;
  BOOL isFullScreenButtonShowing;
}

@property (nonatomic, strong) OOControlsViewController *fullScreenViewController;
@property (nonatomic, strong) OOControlsViewController *inlineViewController;
@property (nonatomic, strong) NSDictionary *defaultLocales;
@property (nonatomic, strong) NSDictionary *currentLocale;
@property (nonatomic, strong) OOClosedCaptionsSelectorViewController *selectorViewController;

- (void)loadInline;
- (void)loadFullscreen;
- (void)unloadInline;
- (void)unloadFullscreen;
- (void)showFullscreen;
- (void)onFullscreenDoneButtonClick;
- (void)determineControlType;
- (OOControlsViewController *)fullscreenViewControllerInstance;
- (OOControlsViewController *)inlineViewControllerInstance;
@end

@implementation OOOoyalaPlayerViewController

static NSDictionary *defaultLocales = nil;
static NSDictionary *currentLocale = nil;

@synthesize player, initialControlType, fullScreenViewController, inlineViewController;
@synthesize defaultLocales, currentLocale;
@synthesize selectorViewController;

- (id)initWithPlayer:(OOOoyalaPlayer *)_player {
  return [self initWithPlayer:_player controlType:OOOoyalaPlayerControlTypeInline];
}

- (id)initWithPlayer:(OOOoyalaPlayer *)_player controlType:(OOOoyalaPlayerControlType)_controlType {
  self = [super init];
  if (self) {
    player = _player;
    initialLoad = YES;

    // change the language in the button when the close caption language changed
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:OOOoyalaPlayerLanguageChangedNotification object: nil];

    [OODebugMode assert:self.initialControlType == OOOoyalaPlayerControlTypeInline || self.initialControlType == OOOoyalaPlayerControlTypeFullScreen tag:TAG message:[NSString stringWithFormat:@"unexpected: %ld", (long)self.initialControlType]];
    initialControlType = _controlType;
    fullscreenQueued = initialControlType == OOOoyalaPlayerControlTypeFullScreen ? YES : NO;

    //Initialize CC Selector and popup helper
    selectorViewController = [[OOClosedCaptionsSelectorViewController alloc] initWithPlayer:_player];
    isFullScreenButtonShowing = YES;
  }

  return self;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

  if (fullscreenQueued) {
    [self loadFullscreen];
    [self setFullscreen:true];
  } else {
    [self loadInline];
    [self setFullscreen:false];
  }
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

- (void)loadFullscreen {
  if (!fullScreenViewController) {
    fullScreenViewController = [[OOFullScreenIOS7ViewController alloc] initWithControlsType:OOOoyalaPlayerControlTypeFullScreen player:self.player overlay:_fullscreenOverlay delegate:self];
  }

  [self presentModalViewController:fullScreenViewController animated:NO];

  if( [self.player isShowingAdWithCustomControls] ) {
    [fullScreenViewController hideControls];
    [fullScreenViewController setIsVisible:NO];
  }
  else {
    [fullScreenViewController showControls];
    [fullScreenViewController setIsVisible:YES];
  }

  [[NSNotificationCenter defaultCenter] postNotificationName:OOOoyalaPlayerViewControllerFullscreenEnter object:self];
}

- (void)loadInline {
  if (!inlineViewController) {
    inlineViewController = [[OOInlineIOS7ViewController alloc] initWithControlsType:OOOoyalaPlayerControlTypeInline player:self.player overlay:_inlineOverlay delegate:self];
  }

  inlineViewController.view.frame = self.view.bounds;

  [self addChildViewController:inlineViewController];
  [self.view addSubview:inlineViewController.view];
  if( [self.player isShowingAdWithCustomControls] ) {
    [inlineViewController hideControls];
    [inlineViewController setIsVisible:NO];
  }
  else {
    [inlineViewController showControls];
    [inlineViewController setIsVisible:YES];
  }

  [player setVideoGravity:OOOoyalaPlayerVideoGravityResizeAspect];  // make sure video is normal gravity

  //If we tried to hide the fullscreen button before, make sure it's hidden now
  if (isFullScreenButtonShowing == NO) {
    [inlineViewController setFullScreenButtonShowing:isFullScreenButtonShowing ];
  }
}

- (void) unloadFullscreen {
  fullscreenQueued = NO;
  if (self.isFullscreen) {
    [self dismissModalViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:OOOoyalaPlayerViewControllerFullscreenExit object:self];
  }
}

- (void) unloadInline {
  [inlineViewController removeFromParentViewController];
  [inlineViewController.view removeFromSuperview];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  initialLoad = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

- (BOOL)isFullscreen {
  return
  self.modalViewController == self.fullScreenViewController &&
  self.fullScreenViewController != nil &&
  self.fullScreenViewController == self.presentedViewController;
}

- (void)setFullscreen:(BOOL)fullscreen {
    if (self.isFullscreen)
    {
      if (!fullscreen) { // exiting full screen
        [self unloadFullscreen];
      }
    }
    else {
      if (fullscreen) {
        [self unloadInline];
        [self loadFullscreen];
      } else {
        [self unloadFullscreen];
        [self loadInline];
      }
    }
}

- (void)stateChanged:(NSNotification*)notification {
  //viewWillAppear is not fired in 4.3.  Assume that it happens after first state change event.
  initialLoad = NO;
  [self viewDidAppear:NO];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:OOOoyalaPlayerStateChangedNotification object:player];
}

- (void)showFullscreen {
  [self setFullscreen:YES];
}

- (void)onFullscreenDoneButtonClick {
  [[NSNotificationCenter defaultCenter] postNotificationName:OOOoyalaPlayerViewControllerDoneClicked object:self];
  [self setFullscreen:NO];
}

- (void)setFullScreenButtonShowing:(BOOL) showing {
    isFullScreenButtonShowing = showing;
    [inlineViewController setFullScreenButtonShowing: showing];
}

- (OOControlsViewController *)getControls {
  if (self.isFullscreen)
    return fullScreenViewController;
  else
    return inlineViewController;
}

- (void)showControls {
  if (self.isFullscreen)
    [fullScreenViewController showControls];
  else
    [inlineViewController showControls];
}

- (void)hideControls {
  if (self.isFullscreen)
    [fullScreenViewController hideControls];
  else
    [inlineViewController hideControls];
}

- (void)switchVideoGravity {
  if(player.videoGravity == OOOoyalaPlayerVideoGravityResizeAspect) {
    [player setVideoGravity:OOOoyalaPlayerVideoGravityResizeAspectFill];
  } else {
    [player setVideoGravity:OOOoyalaPlayerVideoGravityResizeAspect];
  }

  if (self.isFullscreen) {
    [fullScreenViewController syncUI];
    [fullScreenViewController switchVideoGravity];
  }
}

  // This should be called by the UI when the closed captions button is clicked
- (void) closedCaptionsSelector {
  OOClosedCaptionsSelectorBackgroundViewController* backgroundViewController = [[OOClosedCaptionsSelectorBackgroundViewController alloc] initWithSelectorView:selectorViewController];
  if (self.isFullscreen) {
    [self.presentedViewController presentViewController:backgroundViewController animated:YES completion:nil];
  } else {
    [self.inlineViewController presentViewController:backgroundViewController animated:YES completion:nil];
  }
}

  //Set the language on OOOoyalaPlayer
- (void)setClosedCaptionsLanguage:(NSString *)language {
  [player setClosedCaptionsLanguage:language];
}

- (void)determineControlType {
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    initialControlType = OOOoyalaPlayerControlTypeFullScreen;
  } else {
    initialControlType = OOOoyalaPlayerControlTypeInline;
  }
  //disable this logic for now
//  controlType = OOOoyalaPlayerControlTypeInline;
}

- (UIView *)inlineOverlay {
  return _inlineOverlay;
}

- (void) setInlineOverlay:(UIView *)_overlay {
  _inlineOverlay = _overlay;
  if(inlineViewController) {
    inlineViewController.overlay = _inlineOverlay;
  }
}

- (UIView *)fullscreenOverlay {
  return _fullscreenOverlay;
}

- (void) setFullscreenOverlay:(UIView *)_overlay {
  _fullscreenOverlay = _overlay;
  if(fullScreenViewController) {
    fullScreenViewController.overlay = _fullscreenOverlay;
  }
}

- (void) setFullScreenViewController:(OOControlsViewController *)controller {
  fullScreenViewController = controller;
}

- (void) setInlineViewController:(OOControlsViewController *)controller {
  inlineViewController = controller;
}

- (void)changeLanguage:(NSNotification *)notification {
  if(!defaultLocales) {
    [OOOoyalaPlayerViewController loadDefaultLocale];
  }
  NSString* language = [notification object];
  if (language == nil) {
    [OOOoyalaPlayerViewController loadDeviceLanguage];
  } else if ([defaultLocales objectForKey:language]) {
    [OOOoyalaPlayerViewController useLanguageStrings:[OOOoyalaPlayerViewController getLanguageSettings:language]];
  } else {
    [OOOoyalaPlayerViewController chooseBackupLanguage:language];
  }
  if (fullScreenViewController) {
    [fullScreenViewController changeButtonLanguage:language];
  }
}

// Choose a default language when there is not specific dialect for that language
// If there is not default language for a language then we choose English
// For example: choose “ja" as language when there is no ”ja_A“, however if there is
// even no "ja" we should always choose "en"
+ (void) chooseBackupLanguage:(NSString*) language {
  BOOL matched = NO;
  NSArray* array = [language componentsSeparatedByString:@"_"];
  NSString* basicLanguage = array[0];
  for (NSString* key in defaultLocales) {
    if([key isEqualToString:basicLanguage]) {
      [OOOoyalaPlayerViewController useLanguageStrings:[OOOoyalaPlayerViewController getLanguageSettings:key]];
      matched = YES;
      break;
    }
  }
  if (!matched) {
    [OOOoyalaPlayerViewController useLanguageStrings:[OOOoyalaPlayerViewController getLanguageSettings:@"en"]];
  }
}

+ (void)loadDefaultLocale{
  NSArray *keys = [NSArray arrayWithObjects:@"LIVE", @"Done", @"Languages", @"Learn More", nil];
  NSDictionary *en = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"LIVE", @"Done", @"Languages", @"Learn More", nil] forKeys:keys];
  NSDictionary *ja = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"ライブ", @"完了", @"言語", @"さらに詳しく", nil] forKeys:keys];
  NSDictionary *es = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"En vivo", @"Hecho", @"Idioma", @"Más información", nil] forKeys:keys];
  
  defaultLocales = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:en, ja, es, nil] forKeys:[NSArray arrayWithObjects:@"en", @"ja", @"es", nil]];
}

+ (void)loadDeviceLanguage{
  if(!defaultLocales) {
    [self loadDefaultLocale];
  }
  NSString* language =[[NSLocale preferredLanguages] objectAtIndex:0];
  if ([defaultLocales objectForKey:language]) {
    [self useLanguageStrings:[defaultLocales objectForKey:language]];
  } else {
    [self chooseBackupLanguage:language];
  }
}

+ (void)useLanguageStrings:(NSDictionary *)strings {
  if(!defaultLocales) {
    [self loadDefaultLocale];
  }
  currentLocale = strings;
}

+ (NSDictionary*)currentLanguageSettings {
  if(!defaultLocales) {
    [self loadDefaultLocale];
  }
  if (!currentLocale) {
    [self loadDeviceLanguage];
  }
  return currentLocale;
}

 + (NSDictionary*)getLanguageSettings:(NSString *)language {
 if(!defaultLocales) {
 [self loadDefaultLocale];
 }
 return [defaultLocales objectForKey:language];
 }

- (OOControlsViewController *)fullscreenViewControllerInstance {
  return [[OOFullScreenIOS7ViewController alloc] init];
}

- (OOControlsViewController *)inlineViewControllerInstance {
  return [[OOInlineIOS7ViewController alloc] init];
}

- (BOOL)prefersStatusBarHidden {
  return [self.parentViewController prefersStatusBarHidden];
}

- (void)dealloc {
  LOG(@"OOOoyalaPlayerViewController.dealloc %@", [self description]);
}

@end
