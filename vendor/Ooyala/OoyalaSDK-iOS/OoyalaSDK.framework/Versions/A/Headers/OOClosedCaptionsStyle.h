@import UIKit;
@import MediaAccessibility.MACaptionAppearance;

/**
 * Defines text style to be used when displaying closed captions.
 * \ingroup captions
 */

/** Closed captions presentation, deprecated */
typedef NS_ENUM(NSInteger, OOClosedCaptionPresentation) {
  /** text that appears all at once */
  OOClosedCaptionPresentationPopOn,
  /** text that scrolls up as new text appears */
  OOClosedCaptionPresentationRollUp,
  /** text where each new letter or word is displayed as it arrives */
  OOClosedCaptionPresentationPaintOn
};

@interface OOClosedCaptionsStyle : NSObject

/** Closed captions text color */
@property (nonatomic) UIColor *textColor;

/** Closed captions text opacity (between opaque and semi-transparent) */
@property (nonatomic) CGFloat textOpacity;

/** Closed caption text size */
@property (nonatomic) CGFloat textSize;

/** Closed captions text font name */
@property (nonatomic) NSString *textFontName;

/** Closed captions window color */
@property (nonatomic) UIColor *windowColor;

/** Closed captions window opacity */
@property (nonatomic) CGFloat windowOpacity;

/** Closed captions presentation */
@property (nonatomic) OOClosedCaptionPresentation presentation;

/** Closed captions edge attributes */
@property (nonatomic) MACaptionAppearanceTextEdgeStyle edgeStyle;

/** The type of captions that should be displayed */
@property (nonatomic) MACaptionAppearanceDisplayType displayType;

/** This is the background of text itself instead of the backgound of the window holding the text
 *  So in our SDK when we mention "background" we mean the " window"  in this case
 *  Closed captions background color
 */
@property (nonatomic) UIColor *backgroundColor;

/** Closed captions background opacity (between opaque and semi-transparent)
 * This this is only used for classic settings in device otherwise we choose windowOpacity for background opacity
 */
@property (nonatomic) CGFloat backgroundOpacity;

/**
 * update closed caption style
 */
- (void)updateStyle;

/**
 * compare closed captions style
 */
- (NSComparisonResult)compare:(OOClosedCaptionsStyle *)closedCaptionDeviceStyle;

@end
