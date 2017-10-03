#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaAccessibility/MACaptionAppearance.h>
#import <MediaAccessibility/MediaAccessibility.h>
#import <CoreFoundation/CoreFoundation.h>

/**
 * Defines text style to be used when displaying closed captions.
 * \ingroup captions
 */
@interface OOClosedCaptionsStyle : NSObject

/** Closed captions text color */
@property (nonatomic, strong) UIColor *textColor;

/** Closed captions text opacity (between opaque and semi-transparent) */
@property (nonatomic) CGFloat textOpacity;

/** Closed caption text size (from 50% to 200% of default size) */
@property (nonatomic) NSInteger textSize;

/** Closed captions text font name */
@property (nonatomic, strong) NSString* textFontName;

/** Closed captions window color */
@property (nonatomic, strong) UIColor* windowColor;

/** Closed captions window opacity */
@property (nonatomic) CGFloat windowOpacity;

/** Closed captions presentation, deprecated */
typedef enum {
  /** text that appears all at once */
  OOClosedCaptionPopOn,
  /** text that scrolls up as new text appears */
  OOClosedCaptionRollUp,
  /** text where each new letter or word is displayed as it arrives */
  OOClosedCaptionPaintOn
} OOClosedCaptionPresentation;

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
@property (nonatomic, strong) UIColor *backgroundColor;


/** Closed captions background opacity (between opaque and semi-transparent)
 * This this is only used for classic settings in device otherwise we choose windowOpacity for background opacity
 */
@property (nonatomic) CGFloat backgroundOpacity;

/**
 * update closed caption style
 */
- (void) updateStyle;
/**
 * compare closed captions style
 */
- (NSComparisonResult)compare:(OOClosedCaptionsStyle *) closedCaptionDeviceStyle;

@end
