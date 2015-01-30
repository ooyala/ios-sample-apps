/** 
 * \file FWConstants.h
 * \brief Constants in FreeWheel AdManager SDK
 */

#ifndef FW_EXTERN
#ifdef __cplusplus
#define FW_EXTERN			extern "C"
#define FW_PRIVATE_EXTERN   __attribute__((visibility("hidden")))
#else
#define FW_EXTERN			extern
#define FW_PRIVATE_EXTERN   __attribute__((visibility("hidden")))
#endif

#define FW_LINK_RENDERER(r) \
@class r; \
@interface r : NSObject { \
} \
@end; \
extern void FWAdManager_Force_Link_##r (void) __attribute__ ((constructor)); \
void FWAdManager_Force_Link_##r (void) { \
@autoreleasepool{ \
NSLog(@"AdManager: registering renderer class: %@", [r description]); \
} \
}

#endif

typedef enum {
	FW_LOG_LEVEL_QUIET		=	0,
	FW_LOG_LEVEL_INFO		=	3,
	FW_LOG_LEVEL_VERBOSE	=	5
} FWLogLevel;

/**
 * Enumeration of non-temporal slot ad initial options
 */
typedef enum {
	/** Display an ad in the non-temporal slot */
	FW_SLOT_OPTION_INITIAL_AD_STAND_ALONE						=	0,
	/** Keep the original ad in the non-temporal slot */
	FW_SLOT_OPTION_INITIAL_AD_KEEP_ORIGINAL						=	1,	
	/** Use the non-temporal ad in the first companion ad package */
	FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_ONLY				=	2,
	/** Either FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_ONLY or FW_SLOT_OPTION_INITIAL_AD_STAND_ALONE  */
	FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_OR_STAND_ALONE	=	3,
	/** Fill this slot with the first companion ad, or display a new stand alone ad if there is no companion ad */
	FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_THEN_STAND_ALONE   =       4,
	/** Fill this slot with the first companion ad, but never deliver a standalone ad if there is no companion ad */
	FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_OR_NO_STAND_ALONE  =       5,
	/** Fill this slot only with the PREROLL slot’s companion ad if there is one */
	FW_SLOT_OPTION_INITIAL_AD_NO_STAND_ALONE                     =       6,
	/** Fill this slot with a standalone ad only when no temporal ad will be delivered, if there is any temporal ad selected, let this slot empty */
	FW_SLOT_OPTION_INITIAL_AD_NO_STAND_ALONE_IF_TEMPORAL         =       7,
	/** fill this slot with a standAlone ad only when no temporal ad will be delivered, if there is any temporal ad selected, let this slot empty, but if there is companion, can use this companion to initialize this slot */
	FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_OR_NO_STAND_ALONE_IF_TEMPORAL  =   8
} FWInitialAdOption;

/**
 * Enumeration of capability status
 */
typedef enum {
	/** Capability status is off */
	FW_CAPABILITY_STATUS_OFF					=	0,
	/** Capability status is on */
	FW_CAPABILITY_STATUS_ON						=	1,	
	/** Default capability status. The default value can be either on or off for each individual capability. */
	FW_CAPABILITY_STATUS_DEFAULT				=	-1
} FWCapabilityStatus;

/**
 * Enumeration of id types
 */
typedef enum {
	/** Custom id provided by non-FreeWheel parties */
	FW_ID_TYPE_CUSTOM							=	0,
	/** Unique id provided by FreeWheel */
	FW_ID_TYPE_FW								=	1,	
	/** Unique group id provided by FreeWheel */
	FW_ID_TYPE_FWGROUP							=	2
} FWIdType;

/**
 * Enumeration of current video states
 */
typedef enum {
	/** Current video is playing */
	FW_VIDEO_STATE_PLAYING						=	1,	
	/** Current video is paused */
	FW_VIDEO_STATE_PAUSED						=	2,
	/** Current video is stopped */
	FW_VIDEO_STATE_STOPPED						=	3,
	/** Current video is completed */
	FW_VIDEO_STATE_COMPLETED					=	4
} FWVideoState;

/**
 * Enumeration of time position classes
 */
typedef enum {
	/** Time position class type: preroll */
	FW_TIME_POSITION_CLASS_PREROLL				=	1,	
	/** Time position class type: midroll */
	FW_TIME_POSITION_CLASS_MIDROLL				=	2,
	/** Time position class type: postroll */
	FW_TIME_POSITION_CLASS_POSTROLL				=	3,
	/** Time position class type: overlay */
	FW_TIME_POSITION_CLASS_OVERLAY				=	4,
	/** Time position class type: display */
	FW_TIME_POSITION_CLASS_DISPLAY				=	5,
	/** Time position class type: pause_midroll */
	FW_TIME_POSITION_CLASS_PAUSE_MIDROLL 		= 	6
} FWTimePositionClass;

/**
 * Enumeration of slot types
 */
typedef enum {
	/** Type of slot: temporal slot */
	FW_SLOT_TYPE_TEMPORAL						=	1,	
	/** Type of slot: non-temporal slot in video player */
	FW_SLOT_TYPE_VIDEOPLAYER_NONTEMPORAL		=	2,
	/** Type of slot: non-temporal slot in site section */
	FW_SLOT_TYPE_SITESECTION_NONTEMPORAL		=	3
} FWSlotType;

/**
 * Enumeration of parameter level
 */
typedef enum {
	/** profile level param */
	FW_PARAMETER_LEVEL_PROFILE					=	0,	
	/** global level param */
	FW_PARAMETER_LEVEL_GLOBAL					=	1,	
	/** slot level param */
	FW_PARAMETER_LEVEL_SLOT						=	2,
	/** creative level param */
	FW_PARAMETER_LEVEL_CREATIVE					=	3,
	/** rendition level param */
	FW_PARAMETER_LEVEL_RENDITION				=	4,
	/** override level param, highest priority */
	FW_PARAMETER_LEVEL_OVERRIDE					=	5
} FWParameterLevel;

/**
 * Enumeration of FWRendererState types
 */
typedef enum {
	/** Renderer State: Preloaded. Renderer should transit to this state as soon as it finishes preloading. */
	FW_RENDERER_STATE_PRELOADED                 =   2,
	/** Renderer State: Started. Renderer should transit to this state as soon as it starts. */
	FW_RENDERER_STATE_STARTED					=	3,
	/** Renderer State: Completed. Renderer should transit to this state when it has completed all its workflow and ready to be destroyed. */
	FW_RENDERER_STATE_COMPLETED					=	5,
	/** Renderer State: Failed. Renderer should transit to this state when the workflow is interrupted due to some errors. */
	FW_RENDERER_STATE_FAILED					=	6
} FWRendererStateType;

/**
 * Enumeration of RequestMode types
 */
typedef enum {
	/** Request Mode: On demand */
	FW_REQUEST_MODE_ON_DEMAND				=	1,	
	/** Request Mode: Live */
	FW_REQUEST_MODE_LIVE					=	2
} FWRequestMode;

/**
 * Enumeration of video asset duration types. See also: -[FWContext setVideoAssetId:idType:duration:durationType:location:autoPlayType:videoPlayRandom:networkId:fallbackId:]
 */
typedef enum {
	/** Video asset duration type: Exact. This value should be used for video asset whose exact duration is known. */
	FW_VIDEO_ASSET_DURATION_TYPE_EXACT				=	1,	
	/** Video asset duration type: Variable. This value should be used for live stream video asset whose exact duration is not available. */
	FW_VIDEO_ASSET_DURATION_TYPE_VARIABLE			=	2
} FWVideoAssetDurationType;

/**
 * Enumeration of video asset auto play types
 */
typedef enum {
	/** Video asset auto play type: None */
	FW_VIDEO_ASSET_AUTO_PLAY_TYPE_NONE	= 0,
	/** Video asset auto play type: Attended*/
	FW_VIDEO_ASSET_AUTO_PLAY_TYPE_ATTENDED	=	1,	
	/** Video asset auto play type: Unattended */
	FW_VIDEO_ASSET_AUTO_PLAY_TYPE_UNATTENDED =	2
} FWVideoAssetAutoPlayType;

/**
 * Enumeration of user actions. See -[FWContext notifyUserAction:] for details.
 */
typedef enum {
	/** User action: video player's pause button is clicked */
	FW_USER_ACTION_PAUSE_BUTTON_CLICKED = 0,
	/** User action: video player's resume button is clicked */
	FW_USER_ACTION_RESUME_BUTTON_CLICKED = 1
} FWUserAction;

/**
 *  Notification broadcasted when ad request has completed.
 *  object is the FWContext instance used to send the request;
 *  Check userInfo with FW_INFO_KEY_ERROR for errors; will get nil if request has been successful.
 */ 
FW_EXTERN NSString *const FW_NOTIFICATION_REQUEST_COMPLETE;

/**
 *  Notification broadcasted when a slot has finished preloading.
 *  Check userInfo with FW_INFO_KEY_CUSTOM_ID for the slot's custom ID.
 *  See also: - FW_NOTIFICATION_SLOT_STARTED
 */
FW_EXTERN NSString *const FW_NOTIFICATION_SLOT_PRELOADED;

/** 
 *	Notification broadcasted when a slot has started.
 *	Check userInfo with FW_INFO_KEY_CUSTOM_ID for the slot's custom ID.
 *  See also: - FW_NOTIFICATION_SLOT_ENDED
 */
FW_EXTERN NSString *const FW_NOTIFICATION_SLOT_STARTED;

/** 
 *	Notification broadcasted when a slot has ended.
 *	Check userInfo with FW_INFO_KEY_CUSTOM_ID for the slot's custom ID.
 *  See also: - FW_NOTIFICATION_SLOT_STARTED
 */
FW_EXTERN NSString *const FW_NOTIFICATION_SLOT_ENDED; 

/** 
 *	Notification broadcasted when inAppView is opened.
 *  See also: - FW_NOTIFICATION_IN_APP_VIEW_CLOSE
 *            - FW_NOTIFICATION_IN_APP_VIEW_WILL_OPEN_MEDIA_DOCUMENT
 */
FW_EXTERN NSString *const FW_NOTIFICATION_IN_APP_VIEW_OPEN;

/** 
 *	Notification broadcasted when inAppView is closed.
 *  See also: - FW_NOTIFICATION_IN_APP_VIEW_OPEN
 *            - FW_NOTIFICATION_IN_APP_VIEW_WILL_OPEN_MEDIA_DOCUMENT
 */
FW_EXTERN NSString *const FW_NOTIFICATION_IN_APP_VIEW_CLOSE;

/** 
 *	Notification broadcasted when inAppView will open a media document from URI.
 *  See also: - FW_NOTIFICATION_IN_APP_VIEW_OPEN
 *            - FW_NOTIFICATION_IN_APP_VIEW_CLOSE
 */
FW_EXTERN NSString *const FW_NOTIFICATION_IN_APP_VIEW_WILL_OPEN_MEDIA_DOCUMENT;

/** 
 *	Notification broadcasted when AdManager needs your content video player to pause.
 *  It could be due to a midroll slot is about to start, or user has tapped on an ad that needs to interrupt the main video.
 *	You can query userInfo with FW_INFO_KEY_CUSTOM_ID to find the slot that has caused the interruption.
 *  See also: - FW_NOTIFICATION_CONTENT_RESUME_REQUEST
 */
FW_EXTERN NSString *const FW_NOTIFICATION_CONTENT_PAUSE_REQUEST;

/** 
 *	Notification broadcasted when AdManager needs your content video player to resume.
 *  It could be due to a midroll slot has ended, or an interruptive ad has been closed.
 *	You can query userInfo with FW_INFO_KEY_CUSTOM_ID to find the slot that has caused the interruption.
 *  See also: - FW_NOTIFICATION_CONTENT_PAUSE_REQUEST
 */
FW_EXTERN NSString *const FW_NOTIFICATION_CONTENT_RESUME_REQUEST;

/**
 *  Notification broadcasted when an ad has successfully started.
 */ 
FW_EXTERN NSString *const FW_NOTIFICATION_AD_IMPRESSION;

/**
 *  Notification broadcasted when an ad has successfully ended.
 */ 
FW_EXTERN NSString *const FW_NOTIFICATION_AD_IMPRESSION_END;

/**
 *  Notification broadcasted when an ad has failed.
 */ 
FW_EXTERN NSString *const FW_NOTIFICATION_AD_ERROR;


FW_EXTERN NSString *const FW_NOTIFICATION_USER_ACTION_NOTIFIED;

/**
 *  Renderer should publish this notification before an ad expands to fullscreen
 */
FW_EXTERN NSString *const FW_NOTIFICATION_AD_EXPAND_TO_FULLSCREEN;

/**
 *  Renderer should publish this notification after an ad collapses from fullscreen
 */
FW_EXTERN NSString *const FW_NOTIFICATION_AD_COLLAPSE_FROM_FULLSCREEN;

/**
 *  Notification broadcasted when the slot starts AirPlaying
 */
FW_EXTERN NSString *const FW_NOTIFICATION_SLOT_EXTERNAL_PLAYBACK_STARTED;

/**
 *  Notification broadcasted when the slot stops AirPlaying
 */
FW_EXTERN NSString *const FW_NOTIFICATION_SLOT_EXTERNAL_PLAYBACK_STOPPED;

/**
 *	AdManager uses this notification to send standard, impression, error, IAB metric events.
 *	The exact type of event will be exposed to subscriber in the notification userInfo dictionary with key FW_INFO_KEY_SUB_EVENT_NAME.
 *	The slot will be exposed to subscriber in the notification userInfo dictionary with key FW_INFO_KEY_SLOT.
 *	The adInstance will be exposed to subscriber in the notification userInfo dictionary with key FW_INFO_KEY_ADINSTANCE.
 */
FW_EXTERN NSString *const FW_NOTIFICATION_RENDERER_EVENT;

/** 
 *	Notification broadcasted when video display is changed.
 *	Renderer can get the new video display base by querying userInfo with FW_INFO_KEY_VIDEO_DISPLAY_BASE
 *  See also: [FWContext setVideoDisplayBase:]
 */
FW_EXTERN NSString *const FW_NOTIFICATION_VIDEO_DISPLAY_BASE_CHANGED;

/** 
 *	Notification broadcasted when video display's frame has been changed.
 *	Renderer can get the video display base by querying userInfo with FW_INFO_KEY_VIDEO_DISPLAY_BASE
 */
FW_EXTERN NSString *const FW_NOTIFICATION_VIDEO_DISPLAY_BASE_FRAME_CHANGED;

/**
 *	Notification broadcasted when a extension is loaded. <br>
 *	If the userInfo of the notification contains key FW_INFO_KEY_ERROR, it means the extension failed to be load
 */
FW_EXTERN NSString *const FW_NOTIFICATION_EXTENSION_LOADED;

/**
 * Ad unit: preroll
 *
 * See Also:
 *	- FW_ADUNIT_MIDROLL
 *	- FW_ADUNIT_POSTROLL
 *	- FW_ADUNIT_OVERLAY
 *	- FW_ADUNIT_STREAM_PREROLL
 *	- FW_ADUNIT_STREAM_POSTROLL
 *	- FW_ADUNIT_PAUSE_MIDROLL
 */
FW_EXTERN NSString *const FW_ADUNIT_PREROLL; 

/**
 * Ad unit: midroll
 * 
 * See Also:
 *	- FW_ADUNIT_PREROLL
 *	- FW_ADUNIT_POSTROLL
 *	- FW_ADUNIT_OVERLAY
 *	- FW_ADUNIT_STREAM_PREROLL
 *	- FW_ADUNIT_STREAM_POSTROLL
 *	- FW_ADUNIT_PAUSE_MIDROLL
 */
FW_EXTERN NSString *const FW_ADUNIT_MIDROLL; 

/**
 * Ad unit: postroll
 *
 * See Also:
 *	- FW_ADUNIT_PREROLL
 *	- FW_ADUNIT_MIDROLL
 *	- FW_ADUNIT_OVERLAY
 *	- FW_ADUNIT_STREAM_PREROLL
 *	- FW_ADUNIT_STREAM_POSTROLL
 *	- FW_ADUNIT_PAUSE_MIDROLL
 */
FW_EXTERN NSString *const FW_ADUNIT_POSTROLL; 

/**
 * Ad unit: overlay
 *
 * See Also:
 *	- FW_ADUNIT_PREROLL
 *	- FW_ADUNIT_MIDROLL
 *	- FW_ADUNIT_POSTROLL
 *	- FW_ADUNIT_STREAM_PREROLL
 *	- FW_ADUNIT_STREAM_POSTROLL
 *	- FW_ADUNIT_PAUSE_MIDROLL
 */
FW_EXTERN NSString *const FW_ADUNIT_OVERLAY;


/**
 * Ad unit: pause midroll
 *
 * See Also:
 *	- FW_ADUNIT_PREROLL
 *	- FW_ADUNIT_MIDROLL
 *	- FW_ADUNIT_POSTROLL
 *	- FW_ADUNIT_OVERLAY
 *	- FW_ADUNIT_STREAM_PREROLL
 *	- FW_ADUNIT_STREAM_POSTROLL
 */
FW_EXTERN NSString *const FW_ADUNIT_PAUSE_MIDROLL;

/**
 *	Ad unit: stream preroll
 *	
 *	See Also:
 *	- FW_ADUNIT_PREROLL
 *	- FW_ADUNIT_MIDROLL
 *	- FW_ADUNIT_POSTROLL
 *	- FW_ADUNIT_OVERLAY
 *  - FW_ADUNIT_STREAM_POSTROLL
 *  - FW_ADUNIT_PAUSE_MIDROLL
 */
FW_EXTERN NSString *const FW_ADUNIT_STREAM_PREROLL;

/**
 *	Ad unit: stream postroll
 *	
 *	See Also:
 *	- FW_ADUNIT_PREROLL
 *	- FW_ADUNIT_MIDROLL
 *	- FW_ADUNIT_POSTROLL
 *	- FW_ADUNIT_OVERLAY
 *  - FW_ADUNIT_STREAM_PREROLL
 *  - FW_ADUNIT_PAUSE_MIDROLL
 */
FW_EXTERN NSString *const FW_ADUNIT_STREAM_POSTROLL;

/**
 *	Capability: Player expects template-based slots generated by ad server
 *	
 *	Default: ON
 *  See also: - [FWContext setCapability:status:]
 */
FW_EXTERN NSString *const FW_CAPABILITY_SLOT_TEMPLATE; 

/**
 *	Capability: Ad unit in multiple slots
 *
 *	Default: ON
 *  See also: - [FWContext setCapability:status:]
 */
FW_EXTERN NSString *const FW_CAPABILITY_ADUNIT_IN_MULTIPLE_SLOTS; 

/**
 *  Capability: Bypass commercial ratio restriction
 *
 *	Default: OFF
 *  See also: - [FWContext setCapability:status:]
 */
FW_EXTERN NSString *const FW_CAPABILITY_BYPASS_COMMERCIAL_RATIO_RESTRICTION; 

/**
 *	Capability: Player expects ad server to check companion for candidate ads 
 *
 *	Default: ON
 *  See also: - [FWContext setCapability:status:]
 */
FW_EXTERN NSString *const FW_CAPABILITY_CHECK_COMPANION; 

/**
 *	Capability: Player expects ad server to check targeting for candidate ads 
 *
 *	Default: ON
 *  See also: - [FWContext setCapability:status:]
 */
FW_EXTERN NSString *const FW_CAPABILITY_CHECK_TARGETING; 

/**
 *	SDK internal use
 */
FW_EXTERN NSString *const FW_CAPABILITY_REQUIRES_VIDEO_CALLBACK_URL; 

/**
 *	SDK internal use
 */
FW_EXTERN NSString *const FW_CAPABILITY_SLOT_CALLBACK; 

/**
 *	SDK internal use
 */
FW_EXTERN NSString *const FW_CAPABILITY_SKIP_AD_SELECTION; 

/**
 *	Capability: Implicitly record video view.
 *
 *  Default: OFF
 *  See also: - [FWContext setCapability:status:]
 */
FW_EXTERN NSString *const FW_CAPABILITY_RECORD_VIDEO_VIEW; 

/**
 *	Capability: Player expects ad server synchronize the request state between multiple request 
 *
 *  Default: OFF
 *  See also: - [FWContext setCapability:status:] 
 */
FW_EXTERN NSString *const FW_CAPABILITY_SYNC_MULTI_REQUESTS;

/**
 *	Capability: Reset the exclusivity scope. Player can turn on/off this capability before making any request.
 *	
 *	Note:
 *		Once you turn this capability ON, all following requests will carry this signal and reset the exclusivity scope.
 *		So make sure to turn it off once the specific ad request has been submitted.
 *
 *  Default: OFF
 *  See also: - [FWContext setCapability:status:]
 */
FW_EXTERN NSString *const FW_CAPABILITY_RESET_EXCLUSIVITY;

/**
 *	Capability: Player expects ad to have fallback alternative ads.
 *	
 *	Default: ON
 *  See also: - [FWContext setCapability:status:]
 */
FW_EXTERN NSString *const FW_CAPABILITY_FALLBACK_ADS;

/**
 *	Capability: Player expects multiple creative renditions for an ad.
 *	
 *	Default: ON
 *  See also: - [FWContext setCapability:status:]
 */
FW_EXTERN NSString *const FW_CAPABILITY_MULTIPLE_CREATIVE_RENDITIONS;

/**
 *	Event name: slot impression. Broadcasted when a slot has started.
 */
FW_EXTERN NSString *const FW_EVENT_SLOT_IMPRESSION;

/**
 *	Event name: slot impression end. Broadcasted when a slot has ended.
 */
FW_EXTERN NSString *const FW_EVENT_SLOT_IMPRESSION_END;

/**
 *	Event name: ad impression. Broadcasted when an ad has started.
 */
FW_EXTERN NSString *const FW_EVENT_AD_IMPRESSION;

/**
 * 	Event name: ad impression end. Broadcasted when an ad has ended.
 */
FW_EXTERN NSString *const FW_EVENT_AD_IMPRESSION_END;

/**
 *	Event name: ad quartile
 */
FW_EXTERN NSString *const FW_EVENT_AD_QUARTILE;

/**
 *	Event name: ad first quartile	
 */
FW_EXTERN NSString *const FW_EVENT_AD_FIRST_QUARTILE;

/**
 *	Event name: ad midroll 
 */
FW_EXTERN NSString *const FW_EVENT_AD_MIDPOINT;

/**
 *	Event name: ad third quartile	
 */
FW_EXTERN NSString *const FW_EVENT_AD_THIRD_QUARTILE;

/**
 *	Event name: ad complete
 */
FW_EXTERN NSString *const FW_EVENT_AD_COMPLETE;

/**
 *	Event name: ad click
 */
FW_EXTERN NSString *const FW_EVENT_AD_CLICK;

/**
 *	Event name: ad mute
 */
FW_EXTERN NSString *const FW_EVENT_AD_MUTE;

/**
 *	Event name: ad unmute
 */
FW_EXTERN NSString *const FW_EVENT_AD_UNMUTE;

/**
 *	Event name: ad collapse 
 */
FW_EXTERN NSString *const FW_EVENT_AD_COLLAPSE;

/**
 *	Event name: ad expand
 */
FW_EXTERN NSString *const FW_EVENT_AD_EXPAND;

/**
 *	Event name: ad pause
 */
FW_EXTERN NSString *const FW_EVENT_AD_PAUSE;

/**
 *	Event name: ad resume
 */
FW_EXTERN NSString *const FW_EVENT_AD_RESUME;

/**
 *	Event name: ad rewind
 */
FW_EXTERN NSString *const FW_EVENT_AD_REWIND;

/**
 *	Event name: ad accept invitation
 */
FW_EXTERN NSString *const FW_EVENT_AD_ACCEPT_INVITATION;

/**
 *	Event name: ad close
 */
FW_EXTERN NSString *const FW_EVENT_AD_CLOSE;

/**
 *	Event name: ad minimize
 */
FW_EXTERN NSString *const FW_EVENT_AD_MINIMIZE;

/**
 *	Event name: reseller no ad. Broadcasted within FW_NOTIFICATION_RENDERER_EVENT when FreeWheel fails to get any playable ad from a reseller.
 */
FW_EXTERN NSString *const FW_EVENT_AD_RESELLER_NO_AD;

/**
 *	Event name: Ad error. Broadcasted within FW_NOTIFICATION_RENDERER_EVENT when there's any error.
 */
FW_EXTERN NSString *const FW_EVENT_AD_ERROR;

/**
 *	Event name: error
 */
FW_EXTERN NSString *const FW_EVENT_ERROR;

/**
 *	Event name: reseller no ad. Broadcasted when FreeWheel fails to get any playable ad from a reseller.
 */
FW_EXTERN NSString *const FW_EVENT_RESELLER_NO_AD;

/**
 *	Event type: click tracking
 */
FW_EXTERN NSString *const FW_EVENT_TYPE_CLICK_TRACKING; 

/**
 *	Event type: impression
 */
FW_EXTERN NSString *const FW_EVENT_TYPE_IMPRESSION; 

/**
 *	Event type: click 
 */
FW_EXTERN NSString *const FW_EVENT_TYPE_CLICK; 

/**
 *	Event type: standard
 */
FW_EXTERN NSString *const FW_EVENT_TYPE_STANDARD;

/**
 * Event name: pause button clicked. Dispatched by video player when pause button is clicked.
 */ 
FW_EXTERN NSString *const FW_EVENT_PAUSE_BUTTON_CLICKED;

/**
 * Event name: resume button clicked. Dispatched by video player when resume button is clicked.
 */ 
FW_EXTERN NSString *const FW_EVENT_RESUME_BUTTON_CLCKED;

/**
 *  Parameter: Open external url inside your app or by external app, @"YES" or @"NO". @"YES" by default.
 */
FW_EXTERN NSString *const FW_PARAMETER_OPEN_IN_APP;

/**
 *  Parameter: Timeout value for loading inAppView document in seconds.
 *
 *  Note: After the timeout, FreeWheel inAppView's close button will be enabled which allows user to close inAppView.
 *  Default: 3
 */
FW_EXTERN NSString *const FW_PARAMETER_IN_APP_VIEW_LOADING_TIMEOUT;

/**
 *  Parameter: inAppView toolbar.
 *  The value of the parameter is a string of html5 that renders a toolbar inside the inAppView. The toolbar contains a back button, a forward button and a close button.
 *  For example:
 *  \n
 *  \<div\>\n
 *		\<div style=\"\"\>\<img ID=\"<b>FW_IN_APP_VIEW_CONTROL_BAR_BACK_BUTTON</b>\"  src=\"data:image/png;base64,<b><i>PNG_BASE64_STRING</i></b>\" width=\"\" height=\"\"/\>\</div\>\n
 *		\<div style=\"\"\>\<img ID=\"<b>FW_IN_APP_VIEW_CONTROL_BAR_FORWARD_BUTTON</b>\"  src=\"data:image/png;base64,<b><i>PNG_BASE64_STRING</i></b>\" width=\"\" height=\"\"/\>\</div\>\n
 *		\<div style=\"\"\>\<img ID=\"<b>FW_IN_APP_VIEW_CONTROL_BAR_CLOSE_BUTTON</b>\"  src=\"data:image/png;base64,<b><i>PNG_BASE64_STRING</i></b>\" width=\"\" height=\"\"/\>\</div\>\n
 *  \</div\>\n
 *  \n
 *  The <b>FW_IN_APP_VIEW_CONTROL_BAR_BACK_BUTTON</b>, <b>FW_IN_APP_VIEW_CONTROL_BAR_FORWARD_BUTTON</b> and <b>FW_IN_APP_VIEW_CONTROL_BAR_CLOSE_BUTTON</b> IDs have to be kept as such for handling event.\n
 *  All three <b><i>PNG_BASE64_STRING</i></b>s are replaced one by one with each png's base64 string.\n
 *  The size of the \<img/\> tag and alignment of the div tag have to be set properly, e.g. div style can make the close button right aligned.\n
 *  All Safari mobile compatible html5 tags used in body tag are supported, for example, you can use table tags to manage the layout instead of div tag shown in the example.
 */
FW_EXTERN NSString *const FW_PARAMETER_IN_APP_VIEW_TOOLBAR_SURFACE_RENDER;

/**
 *  Parameter: inAppView navigation bar background color. 
 *  Valid values: NSString representing an integer/hexadecimal from 0 to 0xffffff, for example @"256", @"0xffffff"
 */
FW_EXTERN NSString *const FW_PARAMETER_IN_APP_VIEW_NAVIGATION_BAR_BACKGROUND_COLOR;

/**
 *  Parameter: inAppView navigation bar alpha.
 *  Valid values: NSString representing a float from 0.0 to 1.0, where @"0.0" represents totally transparent and @"1.0" represents totally opaque.
 *  Default value: @"1.0"
 */
FW_EXTERN NSString *const FW_PARAMETER_IN_APP_VIEW_NAVIGATION_BAR_ALPHA;

/**
 *  Parameter: inAppView navigation bar height. 
 *  Valid values: NSString representing a percentage in the range 0% to 100%, compared to screen height. 
 */
FW_EXTERN NSString *const FW_PARAMETER_IN_APP_VIEW_NAVIGATION_BAR_HEIGHT;

/**
 *  Parameter: inAppView background color. 
 *  Valid values: NSString representing an integer/hexadecimal from 0 to 0xffffff, for example @"256", @"0xffffff"
 *  Default value: @"0xffffff".
 */
FW_EXTERN NSString *const FW_PARAMETER_IN_APP_VIEW_WEB_VIEW_BACKGROUND_COLOR;

/**
 *  Parameter: inAppView webview alpha. 
 *  Valid values: NSString representing a float from 0.0 to 1.0, where @"0.0" represents totally transparent and @"1.0" represents totally opaque. 
 *  Default value: @"1.0"
 */
FW_EXTERN NSString *const FW_PARAMETER_IN_APP_VIEW_WEB_VIEW_ALPHA;

FW_EXTERN NSString *const FW_PARAMETER_VIDEO_AD_SCALING_MODE DEPRECATED_ATTRIBUTE;
FW_EXTERN NSString *const FW_PARAMETER_VIDEO_AD_SCALING_MODE_NONE DEPRECATED_ATTRIBUTE;
FW_EXTERN NSString *const FW_PARAMETER_VIDEO_AD_SCALING_MODE_ASPECT_FIT DEPRECATED_ATTRIBUTE;
FW_EXTERN NSString *const FW_PARAMETER_VIDEO_AD_SCALING_MODE_ASPECT_FILL DEPRECATED_ATTRIBUTE;
FW_EXTERN NSString *const FW_PARAMETER_VIDEO_AD_SCALING_MODE_FILL DEPRECATED_ATTRIBUTE;

/**
 *  Parameter: use application audio session for video ad renderer.
 *  Valid values: NSString @"YES", @"NO"
 *  Default value: @"NO". 
 */
FW_EXTERN NSString *const FW_PARAMETER_VIDEO_AD_USE_APPLICATION_AUDIO_SESSION;

/**
 *  Parameter: display countdown timer for applicable ads.
 *  Valid values: NSString @"YES", @"NO". 
 *  Default value: @"NO". 
 *  Note: This parameter should be set before slot starts, otherwise has no effect.
 */
FW_EXTERN NSString *const FW_PARAMETER_COUNTDOWN_TIMER_DISPLAY;

/**
 *  Parameter: countdown timer refresh interval, in milliseconds.
 *  Valid values: NSString representing an integer from 1 to 1000.
 *  Default value: 300.
 *  Note: This parameter should be set before slot starts, otherwise has no effect.
 */
FW_EXTERN NSString *const FW_PARAMETER_COUNTDOWN_TIMER_REFRESH_INTERVAL;

/**
 *  Parameter: javascript function name to call when the countdown timer is updated, NSString.
 *  The javascript function should be available in the document loaded in the UIWebView. By default the function called is "updateTimer". The function will be called with two parameters: the current playhead time of the slot in seconds; the total duration of the slot in seconds:
    function updateTimer(playheadTime, duration);
 *  Note: This parameter should be set before slot starts, otherwise has no effect.
 */
FW_EXTERN NSString *const FW_PARAMETER_COUNTDOWN_TIMER_UPDATE_CALLBACK;

/**
 *  Parameter: countdown timer position. 
 *  Valid values: NSString @"bottom", @"top", and @"x,y", for example @"10,20".
 *  Note: This parameter should be set before slot starts, otherwise has no effect.
 */
FW_EXTERN NSString *const FW_PARAMETER_COUNTDOWN_TIMER_POSITION;

/**
 *  Parameter: countdown timer alpha. 
 *  Valid values: NSString representing a float in the range 0.0 to 1.0, where @"0.0" represents totally transparent and @"1.0" represents totally opaque. 
 *  Default value: @"1.0".
 *  Note: This parameter should be set before slot starts, otherwise has no effect.
 */
FW_EXTERN NSString *const FW_PARAMETER_COUNTDOWN_TIMER_ALPHA;

/**
 *  Parameter: countdown timer height in pixels.
 *  Valid values: NSString representing an integer greater than 0. 
 *  Default value: @"20".
 *  Note: This parameter should be set before slot starts, otherwise has no effect.
 */
FW_EXTERN NSString *const FW_PARAMETER_COUNTDOWN_TIMER_HEIGHT;

/**
 *  Parameter: countdown timer width in pixels. 
 *  Valid values: NSString representing an integer greater than 0.
 *  Default value: screen width.
 *  Note: This parameter should be set before slot starts, otherwise has no effect.
 */
FW_EXTERN NSString *const FW_PARAMETER_COUNTDOWN_TIMER_WIDTH;

/**
 *  Parameter: countdown timer font size in css syntax.
 *  Valid values: css-valid font-size values, for example, @"medium", @"12px".
 *  Default value: @"medium".
 *  Note: This parameter should be set before slot starts, otherwise has no effect.
 */
FW_EXTERN NSString *const FW_PARAMETER_COUNTDOWN_TIMER_TEXT_SIZE;

/**
 *  Parameter: countdown timer background color. 
 *  Valid values: NSString representing an integer/hexadecimal from 0 to 0xffffff, for example @"256", @"0xffffff"
 *  Default value: @"0x4a4a4a".
 *  Note: This parameter should be set before slot starts, otherwise has no effect.
 */
FW_EXTERN NSString *const FW_PARAMETER_COUNTDOWN_TIMER_BG_COLOR;

/**
 *  Parameter: countdown timer font color. 
 *  Valid values: NSString representing an integer/hexadecimal from 0 to 0xffffff, for example @"256", @"0xffffff"
 *  Default value: @"0xffffff".
 *  Note: This parameter should be set before slot starts, otherwise has no effect.
 */
FW_EXTERN NSString *const FW_PARAMETER_COUNTDOWN_TIMER_FONT_COLOR;

/**
 *  Parameter: countdown timer font family in css syntax.
 *  Valid values: css-valid font-family values, NSString.
 *  Default value: @"Arial".
 *  Note: This parameter should be set before slot starts, otherwise has no effect.
 */
FW_EXTERN NSString *const FW_PARAMETER_COUNTDOWN_TIMER_TEXT_FONT;

/**
 *  Parameter: countdown timer html.
 *  Valid values: html snippet displaying a countdown timer, NSString. 
 *  Default value: a default timer display html will be provided by default. If you set this parameter by yourself, there should also be a javascript function that updates it periodically. See - FW_PARAMETER_COUNTDOWN_TIMER_UPDATE_CALLBACK for details.
 *  Note: This parameter should be set before slot starts, otherwise has no effect.
 */
FW_EXTERN NSString *const FW_PARAMETER_COUNTDOWN_TIMER_HTML;

/**
 *  Parameter: Track the visibility of nontemporal slot automatically. When it is set to @"YES", non-temporal slots will be played automatically once it is detected on the device screen. 
 *  Valid values: NSString @"YES", @"NO"
 *  Default value: @"NO"
 */
FW_EXTERN NSString *const FW_PARAMETER_NONTEMPORAL_SLOT_VISIBILITY_AUTO_TRACKING;

/**
 *  Parameter: enable pause ads.
 *  Valid values: NSString @"YES", @"NO"
 *  Default value: @"NO"
 *  Note: this parameter indicates whether pause ads should be enabled, and should be set before you send an ad request. When set to @"YES", ad server will return pause ads if available in MRM.
 */
FW_EXTERN NSString *const FW_PARAMETER_PAUSEAD_ENABLE;

/**
 *  - UserInfo dictionary key: url
 *  - The url user clicks
 *  - Applicable event: FW_EVENT_AD_CLICK
 */
FW_EXTERN NSString *const FW_INFO_KEY_URL;


/**
 *  - UserInfo dictionary key: error
 *  - Error message of a failed ad request
 *  - Applicable notification: FW_NOTIFICATION_REQUEST_COMPLETE
 */
FW_EXTERN NSString *const FW_INFO_KEY_ERROR;

/**
 *  - UserInfo dictionary key: slot custom ID
 *  - Custom ID of the related slot
 *  - Applicable notification: FW_NOTIFICATION_SLOT_STARTED, FW_NOTIFICATION_SLOT_ENDED, FW_NOTIFICATION_AD_*
 */
FW_EXTERN NSString *const FW_INFO_KEY_CUSTOM_ID;

/**
 *  - UserInfo dictionary key: slot
 *  - FWSlot instance of the relative slot
 *  - Applicable notification: FW_NOTIFICATION_RENDERER_EVENT
 */
FW_EXTERN NSString *const FW_INFO_KEY_SLOT;

/**
 *  - UserInfo dictionary key: adInstance
 *  - FWAdInstance instance of the relative ad
 *  - Applicable notification: FW_NOTIFICATION_RENDERER_EVENT
 */
FW_EXTERN NSString *const FW_INFO_KEY_ADINSTANCE;

/**
 *  - UserInfo dictionary key: ad ID
 *  - ID of the related ad
 *  - Applicable notification: FW_NOTIFICATION_AD_*
 */
FW_EXTERN NSString *const FW_INFO_KEY_AD_ID;

/**
 *  - UserInfo dictionary key: creative ID
 *  - ID of the related creative
 *  - Applicable notification: FW_NOTIFICATION_AD_*
 */
FW_EXTERN NSString *const FW_INFO_KEY_CREATIVE_ID;

FW_EXTERN NSString *const FW_INFO_KEY_USER_ACTION;

/**
 *  - UserInfo dictionary key: moduleName
 *  - Name of related module
 *  - Applicable notification: FW_NOTIFICATION_EXTENSION_LOADED
 */
FW_EXTERN NSString *const FW_INFO_KEY_MODULE_NAME;

/**
 *  Key of the dictionary returned by -[FWRenderer moduleInfo].
 *  Valid values: FW_MODULE_TYPE_RENDERER, FW_MODULE_TYPE_TRANSLATOR
 */
FW_EXTERN NSString *const FW_INFO_KEY_MODULE_TYPE;

/**
 *  Key of the dictionary returned by =[FWRenderer moduleInfo]. 
 *  optional, if present, its value should be the lowest SDK API version the renderer can compatible
 *  e.g. 0x02060000 for v2.6
 */
FW_EXTERN NSString *const FW_INFO_KEY_REQUIRED_API_VERSION;

/**
 *  Renderer type: renderer.
 *  See also: FW_INFO_KEY_MODULE_TYPE
 */
FW_EXTERN NSString *const FW_MODULE_TYPE_RENDERER;

/**
 *  Renderer type: translator.
 *  See also: FW_INFO_KEY_MODULE_TYPE
 */
FW_EXTERN NSString *const FW_MODULE_TYPE_TRANSLATOR;

/**
 *  Key of the info dictionary in -[FWRendererController handleStateTransition:FW_RENDERER_STATE_FAILED info:details]. 
 *  Valid values: FW_ERROR_*
 */
FW_EXTERN NSString *const FW_INFO_KEY_ERROR_CODE;

/**
 *  Key of the info dictionary in -[FWRendererController handleStateTransition:FW_RENDERER_STATE_FAILED info:details]. 
 *  Valid values: detailed error description message in NSString
 */
FW_EXTERN NSString *const FW_INFO_KEY_ERROR_INFO;

/**
 *  Key of the info dictionary in -[FWRendererController handleStateTransition:FW_RENDERER_STATE_FAILED info:details]. 
 *  Valid values: FW_MODULE_TYPE_*
 */
FW_EXTERN NSString *const FW_INFO_KEY_ERROR_MODULE;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_IO;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_TIMEOUT;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_NULL_ASSET;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_ADINSTANCE_UNAVAILABLE;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_UNKNOWN;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_MISSING_PARAMETER;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_NO_AD_AVAILABLE;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_PARSE;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_INVALID_VALUE;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_INVALID_SLOT;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_NO_RENDERER;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_NO_PRELOAD_IN_TRANSLATOR;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_IN_APP_VIEW;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_3P_COMPONENT;

/**
 *  Value for key FW_INFO_KEY_ERROR_CODE
 */
FW_EXTERN NSString *const FW_ERROR_UNSUPPORTED_3P_FEATURE;

/**
 *  Dictionary key: Sub event name
 *  Valid values: sub event of FW_NOTIFICATION_RENDERER_EVENT to be processed, equals to one of FW_EVENT_AD_*, FW_EVENT_ERROR or FW_EVENT_RESELLER_NO_AD.
 */
FW_EXTERN NSString *const FW_INFO_KEY_SUB_EVENT_NAME; 

/**
 *  Dictionary key: Custom event name
 *  See - [FWRendererController processEvent:info:] for details.
 *  Valid values: custom event name to be processed in NSString
 */
FW_EXTERN NSString *const FW_INFO_KEY_CUSTOM_EVENT_NAME; 

/**
 *  Key of the details dictionary passed to -[FWRendererController processEvent:info:]. Its value is @"YES" or @"NO".
 */
/**
 *  Dictionary key: show browser
 *  See - [FWRendererController processEvent:info:] for details.
 *  Valid values: NSString @"YES" or @"NO" indicating whether the click results in the opening of a new browser tab/window.
 */
FW_EXTERN NSString *const FW_INFO_KEY_SHOW_BROWSER;

/**
 *  Key of FW_NOTIFICATION_VIDEO_DISPLAY_BASE_CHANGED & FW_NOTIFICATION_VIDEO_DISPLAY_BASE_FRAME_CHANGED notification's userInfo dictionary. Its value is the videoDisplayBase object set by API [FWContext setVideoDisplayBase:]. 
 */
FW_EXTERN NSString *const FW_INFO_KEY_VIDEO_DISPLAY_BASE;

/**
 *  Specify the postal code of the user for targeting passed through to 3rd party component.
 */
FW_EXTERN NSString *const FW_PARAMETER_POSTAL_CODE;

/**
 *  Specify the area code of the user's phone for targeting passed through to 3rd party component.
 */
FW_EXTERN NSString *const FW_PARAMETER_AREA_CODE;

/**
 *  Specify the user's date of birth for targeting passed through to 3rd party component.
 */
FW_EXTERN NSString *const FW_PARAMETER_DATE_OF_BIRTH;

/**
 *  Specify the user's gender for targeting passed through to 3rd party component.
 */
FW_EXTERN NSString *const FW_PARAMETER_GENDER;

/**
 *  Specify a list of keywords for targeting passed through to 3rd party component.
 */
FW_EXTERN NSString *const FW_PARAMETER_KEYWORDS;

/**
 *  Specify the area code of the user’s phone for targeting passed through to 3rd party component.
 */
FW_EXTERN NSString *const FW_PARAMETER_SEARCH_STRING;

/**
 *  Specify the user's marital status for targeting passed through to 3rd party component.
 */
FW_EXTERN NSString *const FW_PARAMETER_MARITAL;

/**
 *  Specify the user's ethnicity for targeting passed through to 3rd party component.
 */
FW_EXTERN NSString *const FW_PARAMETER_ETHNICITY;

/**
 *  Specify the user's orientation for targeting passed through to 3rd party component.
 */
FW_EXTERN NSString *const FW_PARAMETER_ORIENTATION;

/**
 *  Specify the user's income for targeting passed through to 3rd party component.
 */
FW_EXTERN NSString *const FW_PARAMETER_INCOME;

/**
 *  Parameter: indicates whether AdManager should handle user tapping on a temporal ad.
 *  Valid values: NSString @"YES", @"NO"
 *  Default value: @"YES".
 *  Note: if the value is set to @"NO", app should handle the ad click by itself, for example, opening the click through url in a UIWebView.
 */
FW_EXTERN NSString *const FW_PARAMETER_CLICK_DETECTION;

/**
 *	Parameter: whether AdManager should display a default control panel when user taps on a video ad.
 *	This only takes effect when set to @"YES" and FW_PARAMETER_CLICK_DETECTION is set to @"NO".
 *	Valid values: NSString @"YES", @"NO"
 *	Default value: @"NO"
 */
FW_EXTERN NSString *const FW_PARAMETER_USE_CONTROL_PANEL;

/**
 *  Parameter: desired bitrate. Indicates current viewer's available bandwidth.
 *  Valid values: NSString representing a positive decimal float.
 *  Default value: @"1000.0"
 *  Note: the value is used in creative rendition selection. AdManager will automatically choose the best fit rendition according to current view's bandwidth.
 */
FW_EXTERN NSString *const FW_PARAMETER_DESIRED_BITRATE;

FW_EXTERN NSString *const FW_PARAMETER_DESIRED_ORIENTATION DEPRECATED_ATTRIBUTE;

FW_EXTERN NSString *const FW_PARAMETER_REQUEST_TEMPLATE_VARIABLES;

FW_EXTERN NSString *const FW_PARAMETER_REQUEST_ALTERNATIVE_URL;

/**
 *	Parameter: Whether to enable automatic retrieval and sending of Apple IDFA when the id is available.
 *	Valid values: NSString @"YES", @"NO"
 *	Default value: @"YES"
 */
FW_EXTERN NSString *const FW_PARAMETER_IDFA;

FW_EXTERN NSString *const FW_EVENT_AD_BUFFERING_END;

FW_EXTERN NSString *const FW_EVENT_AD_BUFFERING_START;

FW_EXTERN NSString *const FW_EVENT_TYPE_CUSTOM;
