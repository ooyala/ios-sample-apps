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
//@property UILabel *videotitle; //title on portrait mode
@property UILabel *playedVideoName;
@property DemoSettings *configuration; //read config.json
@property NSArray *labels; //user labels
@property NSMutableArray *carousels; //user carousels
@property NSMutableArray *similartableview;
@property NSArray *discoveryResults; //results of middleware/discoveryapi
@property NSString *actualembed; //embed
@property NSString *actualVideoTitle;
@property int SimilarFeature;
@property PlayerViewController *playerViewController;

- (void)userRender;
- (NSString *)decodeString:(NSString *)data;

@end

