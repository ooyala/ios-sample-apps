//
//  MainView.h
//  OoyalaSkinSampleApp
//
//  Created on 4/13/17.
//  Copyright © 2017 Ooyala, Inc. All rights reserved.
//

@import UIKit;

@class PlayerViewController;
@class DemoSettings;

@interface MainView : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UILabel *videoTitle;
@property (nonatomic) IBOutlet UILabel *descriptionLabel;
@property (nonatomic) IBOutlet NSLayoutConstraint *playerViewHeight;
@property (nonatomic) IBOutlet NSLayoutConstraint *playerViewFullHeight;
@property (nonatomic) IBOutlet UILabel *discoveryLabel;

@property (nonatomic) IBOutlet NSLayoutConstraint *playerViewTop;
@property (nonatomic) IBOutlet UIView *playerview;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
//@property (nonatomic) UILabel *videotitle; //title on portrait mode
@property (nonatomic) UILabel *playedVideoName;

@property (nonatomic) DemoSettings *configuration; //read config.json
@property (nonatomic) NSArray *labels; //user labels
@property (nonatomic) NSMutableArray *carousels; //user carousels
@property (nonatomic) NSMutableArray *similartableview;
@property (nonatomic) NSArray *discoveryResults; //results of middleware/discoveryapi
@property (nonatomic) NSString *actualembed; //embed
@property (nonatomic) NSString *actualVideoTitle;
@property int SimilarFeature;
@property (nonatomic) PlayerViewController *playerViewController;

- (void)userRender;
- (NSString *)decodeString:(NSString *)data;

@end

