//
//  OOSkinViewControllerDelegate.h
//  OoyalaSkinSDK
//

@protocol OOSkinViewControllerDelegate <NSObject>

@property (nonatomic, getter=isReactViewInteractionEnabled) BOOL reactViewInteractionEnabled;
/**
 Property is used to obtain real video view frame.
 View controller's view frame may not be equal to video view frame.

 @return The frame of video view
 */
@property (nonatomic, readonly) CGRect videoViewFrame;

- (void)toggleFullscreen;
- (void)toggleStereoMode;

@end
