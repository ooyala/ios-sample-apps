//
//  CastPlaybackView.h
//  ChromecastSampleApp
//

#import <UIKit/UIKit.h>
#import <OoyalaSDK/OOVideo.h>

@interface CastPlaybackView : UIImageView
-(instancetype) init __attribute__((unavailable("init")));
-(instancetype) initWithFrame:(CGRect)frame __attribute__((unavailable("initWithFrame:")));
-(instancetype) initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("initWithCoder:")));
-(instancetype) initWithImage:(UIImage *)image __attribute__((unavailable("initWithImage:")));
-(instancetype) initWithParentView:(UIView*)parentView;
-(void) configureCastPlaybackViewBasedOnItem:(OOVideo*)item displayName:(NSString*)displayName displayStatus:(NSString*)displayStatus;
@end
