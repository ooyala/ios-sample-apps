// Copyright 2016 Google Inc.

/** @cond ENABLE_FEATURE_GUI */

#import <GoogleCast/GCKDefines.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A class for controlling the style (colors, fonts, icons) of the default views of the framework.
 *
 * @since 3.3
 */
GCK_EXPORT
@interface GCKUIStyleAttributes : NSObject

/**
 * An image that will be used in "closed captions" buttons in the framework's default views.
 */
@property(nonatomic, strong) UIImage *closedCaptionsImage;
/**
 * An image that will be used in "forward 30 seconds" buttons in the frameworks default views.
 */
@property(nonatomic, strong) UIImage *forward30SecondsImage;
/**
 * An image that will be used in "rewind 30 seconds" buttons in the framework's default views.
 */
@property(nonatomic, strong) UIImage *rewind30SecondsImage;
/**
 * An image that will be used to indicate that a slider is a volume slider in the framework's
 * default views.
 */
@property(nonatomic, strong) UIImage *volumeImage;
/**
 * An image that will be used in the "mute toggle" button in the framework's default views.
 * This is the image that will be displayed while the receiver is muted.
 */
@property(nonatomic, strong) UIImage *muteOffImage;
/**
 * An image that will be used in the "mute toggle" button in the framework's default views. This is
 * the image that will be displayed while the receiver is not muted.
 */
@property(nonatomic, strong) UIImage *muteOnImage;
/**
 * An image that will be used in the "play/pause toggle" button in the framework's default views.
 * This is the image that will be displayed while the receiver is playing.
 */
@property(nonatomic, strong) UIImage *pauseImage;
/**
 * An image that will be used in the "play/pause toggle" button in the framework's default views.
 * This is the image that will be displayed while the receiver is paused.
 */
@property(nonatomic, strong) UIImage *playImage;
/**
 * An image that will be used in "forward 30 seconds" buttons in the framework's default views.
 */
@property(nonatomic, strong) UIImage *skipNextImage;
/**
 * An image that will be used in "forward 30 seconds" buttons in the framework's default views.
 */
@property(nonatomic, strong) UIImage *skipPreviousImage;
/**
 * An image that will be used in the track selector, to select the audio track chooser view.
 */
@property(nonatomic, strong) UIImage *audioTrackImage;
/**
 * An image that will be used in the track selector, to select the subtitle track chooser view.
 */
@property(nonatomic, strong) UIImage *subtitlesTrackImage;
/**
 * An image that will be used in "stop" buttons in the framework's default views.
 */
@property(nonatomic, strong) UIImage *stopImage;
/**
 * The UIFont to be used in labels of buttons in the framework's default views.
 */
@property(nonatomic, strong) UIFont *buttonTextFont;
/**
 * The color to be used in labels of buttons in the framework's default views.
 *
 * @since 3.4
 */
@property(nonatomic, strong) UIColor *buttonTextColor;
/**
 * The shadow color to be used in labels of buttons in the framework's default views.
 */
@property(nonatomic, strong) UIColor *buttonTextShadowColor;
/**
 * The offset for the shadow for labels of buttons in the framework's default views.
 */
@property(nonatomic, assign) CGSize buttonTextShadowOffset;
/**
 * The UIFont to be used in labels of type "body" in the framework's default views.
 */
@property(nonatomic, strong) UIFont *bodyTextFont;
/**
 * The UIFont to be used in labels of type "heading" in the framework's default views.
 */
@property(nonatomic, strong) UIFont *headingTextFont;
/**
 * The font to be used in labels of type "caption" in the framework's default views.
 */
@property(nonatomic, strong) UIFont *captionTextFont;
/**
 * The color to be used in labels of type "body" in the framework's default views.
 */
@property(nonatomic, strong) UIColor *bodyTextColor;
/**
 * The shadow color to be used in labels of type "body" in the framework's default views.
 */
@property(nonatomic, strong) UIColor *bodyTextShadowColor;
/**
 * The color to be used in labels of type "heading" in the framework's default views.
 */
@property(nonatomic, strong) UIColor *headingTextColor;
/**
 * The shadow color to be used in labels of type "heading" in the framework's default views.
 */
@property(nonatomic, strong) UIColor *headingTextShadowColor;
/**
 * The color to be used in labels of type "caption" in the framework's default views.
 */
@property(nonatomic, strong) UIColor *captionTextColor;
/**
 * The shadow color to be used in labels of type "caption" in the framework's default views.
 */
@property(nonatomic, strong) UIColor *captionTextShadowColor;
/**
 * The background color to be used on the framework's default views.
 */
@property(nonatomic, strong) UIColor *backgroundColor;
/**
 * The color to use as tint color on all buttons and icons on the framework's default views.
 */
@property(nonatomic, strong) UIColor *iconTintColor;
/**
 * The offset for the shadow for labels of type "body" in the framework's default views.
 */
@property(nonatomic, assign) CGSize bodyTextShadowOffset;
/**
 * The offset for the shadow for labels of type "caption" in the framework's default views.
 */
@property(nonatomic, assign) CGSize captionTextShadowOffset;
/**
 * The offset for the shadow for labels of type "heading" in the framework's default views.
 */
@property(nonatomic, assign) CGSize headingTextShadowOffset;

@end

/**
 * The style attributes for the view group representing the navigation bar of device controller.
 * Can be accessed as castViews.deviceController.connectionController.navigation.
 *
 * @since 4.3.5
 */
GCK_EXPORT
@interface GCKUIStyleAttributesConnectionNavigation : GCKUIStyleAttributes
@end

/**
 * The style attributes for the view group representing the toolbar of device controller.
 * Can be accessed as castViews.deviceController.connectionController.toolbar.
 *
 * @since 4.3.5
 */
GCK_EXPORT
@interface GCKUIStyleAttributesConnectionToolbar : GCKUIStyleAttributes
@end

/**
 * The style attributes for the view group representing the initial instructions overlay.
 * Can be accessed as castViews.instructions.
 */
GCK_EXPORT
@interface GCKUIStyleAttributesInstructions : GCKUIStyleAttributes
@end

/**
 * The style attributes for the view group representing the guest-mode pairing dialog.
 * Can be accessed as castViews.deviceControl.guestModePairingDialog
 */
GCK_EXPORT
@interface GCKUIStyleAttributesGuestModePairingDialog : GCKUIStyleAttributes
@end

/**
 * The style attributes for the view group representing the media track selector.
 * Can be accessed as castViews.mediaControl.trackSelector
 */
GCK_EXPORT
@interface GCKUIStyleAttributesTrackSelector : GCKUIStyleAttributes
@end

/**
 * The style attributes for the view group representing the mini controller.
 * Can be accessed as castViews.mediaControl.miniController
 */
GCK_EXPORT
@interface GCKUIStyleAttributesMiniController : GCKUIStyleAttributes
@end

/**
 * The style attributes for the view group representing the expanded controller.
 * Can be accessed as castViews.mediaControl.expandedController
 */
GCK_EXPORT
@interface GCKUIStyleAttributesExpandedController : GCKUIStyleAttributes
@end

/**
 * The style attributes for the view group representing the device chooser.
 * Can be accessed as castViews.deviceControl.deviceChooser
 */
GCK_EXPORT
@interface GCKUIStyleAttributesDeviceChooser : GCKUIStyleAttributes
@end

/**
 * The style attributes for the view group representing the connection controller.
 * Can be accessed as castViews.deviceControl.connectionController
 */
GCK_EXPORT
@interface GCKUIStyleAttributesConnectionController : GCKUIStyleAttributes

/**
 * The style attributes for the navigation bar of the device connection controller.
 *
 * @since 4.3.5
 */
@property(readonly, nonatomic, strong) GCKUIStyleAttributesConnectionNavigation *navigation;

/**
 * The style attributes for the toolbar of the device connection controller.
 *
 * @since 4.3.5
 */
@property(readonly, nonatomic, strong) GCKUIStyleAttributesConnectionToolbar *toolbar;

@end

/**
 * The style attributes for the view group representing all the media control views.
 * Can be accessed as castViews.mediaControl
 */
GCK_EXPORT
@interface GCKUIStyleAttributesMediaControl : GCKUIStyleAttributes

/** The style attributes for the expanded controller. */
@property(readonly, nonatomic, strong) GCKUIStyleAttributesExpandedController *expandedController;

/** The style attributes for the mini controller. */
@property(readonly, nonatomic, strong) GCKUIStyleAttributesMiniController *miniController;

/** The style attributes for the media track selector. */
@property(readonly, nonatomic, strong) GCKUIStyleAttributesTrackSelector *trackSelector;

@end

/**
 * The style attributes for the view group representing all the device control views.
 * Can be accessed as castViews.deviceControl
 */
GCK_EXPORT
@interface GCKUIStyleAttributesDeviceControl : GCKUIStyleAttributes

/** The style attributes for the device chooser. */
@property(readonly, nonatomic, strong) GCKUIStyleAttributesDeviceChooser *deviceChooser;

/** The style attributes for the device connection controller. */
@property(readonly, nonatomic, strong)
    GCKUIStyleAttributesConnectionController *connectionController;

/** The style attributes for the Guest Mode pairing dialog. */
@property(readonly, nonatomic, strong)
    GCKUIStyleAttributesGuestModePairingDialog *guestModePairingDialog;

@end

/**
 * The style attributes for the root view group.
 * Can be accessed as castViews
 */
GCK_EXPORT
@interface GCKUIStyleAttributesCastViews : GCKUIStyleAttributes

/** The style attributes for device control UI elements. */
@property(readonly, nonatomic, strong) GCKUIStyleAttributesDeviceControl *deviceControl;

/** The style attributes for media control UI elements. */
@property(readonly, nonatomic, strong) GCKUIStyleAttributesMediaControl *mediaControl;

/** The style attributes for instructional UI elements. */
@property(readonly, nonatomic, strong) GCKUIStyleAttributesInstructions *instructions;

@end

NS_ASSUME_NONNULL_END

/** @endcond */
