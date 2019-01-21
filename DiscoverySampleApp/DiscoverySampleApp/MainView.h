//
//  MainView.h
//  OoyalaSkinSampleApp
//
//  Created by Alan Garcia on 4/13/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerViewController;
@class DemoSettings;

@interface MainView : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerViewFullHeight;
@property (weak, nonatomic) IBOutlet UILabel *discoveryLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerViewTop;
@property (weak, nonatomic) IBOutlet UIView *playerview;
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

