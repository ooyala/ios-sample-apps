/**
 * \file FWProtocols.h
 * \brief Protocols in FreeWheel AdManager SDK
 */
@class UIView;
@class CLLocation;
@class MPMoviePlayerController;
@class UIViewController;

@protocol FWAdManager;
@protocol FWContext;
@protocol FWSlot;
@protocol FWAdInstance;
@protocol FWCreativeRendition;
@protocol FWCreativeRenditionAsset;
@protocol FWRendererController;
@protocol FWRenderer;

#pragma clang arc_cf_code_audited begin

/** 
 *	\fn id<FWAdManager> newAdManager()
 *	Create a new AdManager instance
 *	\return	an id<FWAdManager>
 */
FW_EXTERN id<FWAdManager> newAdManager(void);

/** 
 *	\fn void FWSetLogLevel(FWLogLevel value); 
 *	Set log level
 *	\param value
 *		-	FW_LOG_LEVEL_INFO	Default value
 *		-	FW_LOG_LEVEL_QUIET
 *		-	FW_LOG_LEVEL_VERBOSE	force the verbose log in both debug & release version
 */
FW_EXTERN void FWSetLogLevel(FWLogLevel value);

/**
 *	\fn void FWSetUncaughtExceptionHandler(NSUncaughtExceptionHandler *handler)
 *	AdManager registers NSSetUncaughtExceptionHandler() to report uncaught exception.
 *	If app needs to perform last-minute logging before the program terminates, use this function instead of NSSetUncaughtExceptionHandler.
 *	\param handler
 */
FW_EXTERN void FWSetUncaughtExceptionHandler(NSUncaughtExceptionHandler *handler);

/** 
 *	\fn void FWClearCookie();
 *	Clear all cookies from fwmrm.net domains.
 */
FW_EXTERN void FWClearCookie(void);

/** 
 *	\fn void FWSetCookieOptOutState(BOOL value);
 *	Opt-out cookies from fwmrm.net domains.
 */
FW_EXTERN void FWSetCookieOptOutState(BOOL value);

/** 
 *	\fn BOOL FWGetCookieOptOutState();
 *	Get MRM cookie opt-out state.
 */
FW_EXTERN BOOL FWGetCookieOptOutState(void);

/**
 *	Protocol for AdManager
 *
 *	Use newAdManager() to create a new id<FWAdManager> instance
 */
@protocol FWAdManager <NSObject>
/**
 *	Set application's current view controller. Required if using FWAdMobRenderer or FWMillennialDisplayAdRenderer or FWMillennialTakeoverAdRenderer.
 *  Once set, the view controller set will be retained by AdManager.
 *	\param value    current view controller
 */
- (void)setCurrentViewController:(UIViewController *)value;

/**
 *	Set the ad server URL provided by FreeWheel. REQUIRED. Consult your FreeWheel sales engineer for the value.
 *	\param	value	url of the FreeWheel Ad Server
 */
- (void)setServerUrl:(NSString *)value;

/**
 *	Set the network ID of the distributor. REQUIRED. Consult your FreeWheel sales engineer for the value.
 *	\param	value	network ID of the distributor
 */
- (void)setNetworkId:(NSUInteger)value;

/**
 *	Set the current location of the device. This value will only be used for geo targeting purposes.
 *	\param	value	device's current location, CLLocation. nil by default.
 */
- (void)setLocation:(CLLocation *)value;

/**
 *	Get major version of AdManager
 *	\return	version of AdManager, e.g. 0x02060000 for v2.6
 */
- (NSUInteger)version;

/**
 *	Create a new FWContext instance
 *	A FWContext instance is used to set ad request information for a particular ad or ad set.  Multiple contexts can be created throughout the lifecycle of the FreeWheel AdManager and may exist simultaneously without consequence. Multiple simultaneous contexts are useful to optimize user experience in the network-resource limited environment.
 *	\return	an id<FWContext>
 */
- (id<FWContext>)newContext;

/**
 *	Create a new context from the given context. The new context copies internal state and information of the old one, so you can use this method to create an identical context without having to set all the information again.
 *		
 *	The following methods are called automatically on the new context with values of the old one.
 *		-	-[FWContext setRequestMode:]
 *		-	-[FWContext setCapability:status:]
 *		-	-[FWContext setVisitorId:ipV4Address:bandwidth:bandwidthSource:]
 *		-	-[FWContext setVisitorHTTPHeader:withValue:]
 *		-	-[FWContext setSiteSectionId:idType:pageViewRandom:networkId:fallbackId:]
 *		-	-[FWContext setVideoAssetId:idType:duration:durationType:location:autoPlayType:videoPlayRandom:networkId:fallbackId:]
 *		-	-[FWContext setPlayerProfile:defaultTemporalSlotProfile:defaultVideoPlayerSlotProfile:defaultSiteSectionSlotProfile:]
 *		-	-[FWContext startSubsessionWithToken:]
 *		-	-[FWContext setRequestDuration:]
 *		-	-[FWContext setVideoDisplayCompatibleSizes:]
 *		-	-[FWContext setVideoState:]
 *
 *	You are required to call the following methods again on the new context:
 *		-	-[NSNotificationCenter addObserver:selector:name:object:] 	(add notification observer for the new context)
 *		-	-[FWContext addTemporalSlot:adUnit:timePosition:slotProfile:cuePointSequence:minDuration:maxDuration:acceptPrimaryContentType:acceptContentType:] (if there's any)
 *		-	-[FWContext addSiteSectionNonTemporalSlot:adUnit:width:height:slotProfile:acceptCompanion:initialAdOption:acceptPrimaryContentType:acceptContentType:compatibleDimensions:] (if there's any)
 *		-	-[FWContext addVideoPlayerNonTemporalSlot:adUnit:width:height:slotProfile:acceptCompanion:initialAdOption:acceptPrimaryContentType:acceptContentType:compatibleDimensions:] (if there's any)
 *		-	-[FWContext submitRequestWithTimeout:]
 */
- (id<FWContext>)newContextWithContext:(id<FWContext>)context;

/**
 *	Disable FreeWheel crash reporter. By default AdManager will send a crash report to ad server when an app crash is detected.
 */
- (void)disableFWCrashReporter;
@end

/**
 *	Protocol for AdManager context
 */
@protocol FWContext <NSObject>
/**
 *	Set video display base UIView. REQUIRED. Video ads are rendered within the base view in the same frame.
 *	When video display base view changes, app needs to call this method again with the new video display to notify AdManager to render video ads in the updated video display. App does not need to call this method when video display view's frame changes.
 *	Prior to AdManager 3.8, renderer assumes main video's MPMoviePlayerController view is the video display base. Starting from AdManager 3.8, for iOS>=3.2, app must invoke this method to specify video display base explicitly. For iOS3.0-3.1, app does not need to invoke this method since the legacy MPMoviePlayerController is always played in fullscreen.
 */
- (void)setVideoDisplayBase:(UIView *)value;

/**
 *	The API is no longer required. You only need to set your player to the correct state by calling [player setFullscreen:(BOOL)fullscreen] before temporal slot starts.
 *  Prior to AdManager 5.3.0, when the content MPMoviePlayerController enters or exits from fullscreen, it is required to call this method with the updated fullscreen status so that AdManager gets notified about the change. Existing apps could remove the calls if they make sure to call setVideoDisplayBase and [player setFullscreen:(BOOL)fullscreen] before temporal slot starts.
 */
- (void)setMoviePlayerFullscreen:(BOOL)value DEPRECATED_ATTRIBUTE;

- (void)setMoviePlayerController:(MPMoviePlayerController *)value DEPRECATED_ATTRIBUTE;

- (BOOL)setCapability:(NSString *)capability :(FWCapabilityStatus)status DEPRECATED_ATTRIBUTE;

/**
 *	Set the capabilities supported by the player
 *	\param	capability capability name, should be one of FW_CAPABILITY_* in FWConstants.h
 *	\param	status indicates whether to enable this capability, should be one of:
 *	 	- FW_CAPABILITY_STATUS_ON: enable
 *	 	- FW_CAPABILITY_STATUS_OFF: disable
 *	 	- FW_CAPABILITY_STATUS_DEFAULT: leave it unset, follow the network settings
 *	\return Boolean value, indicating whether the capability is set successfully
 */
- (BOOL)setCapability:(NSString *)capability status:(FWCapabilityStatus)status;

- (void)addKeyValue:(NSString *)key :(NSString *)value DEPRECATED_ATTRIBUTE;

/**
 *	Add a key-value pair to ad request. The key-value pair is used in ad targeting. If called with the same key multiple times, all the values will be added to the same key.
 *	\param	key		key of the key-value pair, NSString. Can not be nil or empty
 *	\param	value	value of the key-value pair, NSString. Can not be nil
 */
- (void)addValue:(NSString *)value forKey:(NSString *)key;

- (void)setProfile:(NSString *)playerProfile :(NSString *)defaultTemporalSlotProfile :(NSString *)defaultVideoPlayerSlotProfile :(NSString *)defaultSiteSectionSlotProfile DEPRECATED_ATTRIBUTE;

/**
 *	Set the profiles names. Consult your FreeWheel sale engineer for available values.
 *	\param	playerProfile					name of the global profile
 *	\param	defaultTemporalSlotProfile		name of the temporal slot default profile, nil by default
 *	\param	defaultVideoPlayerSlotProfile	name of the video player slot default profile, nil by default
 *	\param	defaultSiteSectionSlotProfile	name of the site section slot default profile, nil by default
 */
- (void)setPlayerProfile:(NSString *)playerProfile defaultTemporalSlotProfile:(NSString *)defaultTemporalSlotProfile defaultVideoPlayerSlotProfile:(NSString *)defaultVideoPlayerSlotProfile defaultSiteSectionSlotProfile:(NSString *)defaultSiteSectionSlotProfile;

- (void)setVisitor:(NSString *)customId :(NSString *)ipV4Address :(NSUInteger)bandwidth :(NSString *)bandwidthSource DEPRECATED_ATTRIBUTE;

/**
 *	Set the attributes of the visitor
 *	\param	customId		custom ID of the visitor
 *	\param	ipV4Address		ip address of the visitor
 *	\param	bandwidth		bandwidth of the visitor
 *	\param	bandwidthSource	bandwidth source of the visitor
 */
- (void)setVisitorId:(NSString *)customId ipV4Address:(NSString *)ipV4Address bandwidth:(NSUInteger)bandwidth bandwidthSource:(NSString *)bandwidthSource;

- (void)setVisitorHttpHeader:(NSString *)name :(NSString *)value DEPRECATED_ATTRIBUTE;

/**
 *	Set the HTTP headers of the visitor
 *	\param	name	name of the header
 *	\param	value	value of the header. If set to nil, the original value of the HTTP header name will be removed.
 */
- (void)setVisitorHTTPHeader:(NSString *)name withValue:(NSString *)value;

- (void)setVideoAsset:(NSString *)videoAssetId :(NSTimeInterval)duration :(NSString *)location :(FWVideoAssetAutoPlayType)autoPlayType :(NSUInteger)videoPlayRandom :(NSUInteger)networkId :(FWIdType)idType :(NSUInteger)fallbackId :(FWVideoAssetDurationType)durationType DEPRECATED_ATTRIBUTE;

/**
 *	Set the attributes of the current video asset
 *	\param	videoAssetId	id of the video asset
 *	\param	idType			type of video id, should be one of
 *								-	FW_ID_TYPE_CUSTOM
 *								-	FW_ID_TYPE_FW
 *								-	FW_ID_TYPE_FWGROUP
 *	\param	duration		duration of the video in seconds
 *	\param	durationType	type of duration, should be one of
 *								-	FW_VIDEO_ASSET_DURATION_TYPE_EXACT		default
 *								-	FW_VIDEO_ASSET_DURATION_TYPE_VARIABLE	for live video
 *	\param	location		location(URI) of the video, nil by default
 *	\param	autoPlayType	whether the video starts playing automatically without user interaction
 *								-	FW_VIDEO_ASSET_AUTO_PLAY_TYPE_NONE
 *								-	FW_VIDEO_ASSET_AUTO_PLAY_TYPE_ATTENDED		(default)
 *								-	FW_VIDEO_ASSET_AUTO_PLAY_TYPE_UNATTENDED
 *	\param	videoPlayRandom	random number generated everytime a user watches the video asset
 *	\param	networkId		id of the network the video belongs to, 0 by default
 *	\param	fallbackId		video ID to fallback to. When ad server fails to find the video asset specified by videoAssetId, this ID will be used. 0 by default
 */
- (void)setVideoAssetId:(NSString *)videoAssetId idType:(FWIdType)idType duration:(NSTimeInterval)duration durationType:(FWVideoAssetDurationType)durationType location:(NSString *)location autoPlayType:(FWVideoAssetAutoPlayType)autoPlayType videoPlayRandom:(NSUInteger)videoPlayRandom networkId:(NSUInteger)networkId fallbackId:(NSUInteger)fallbackId;

/**
 *	Set the current time position of the content asset.
 *	\param	timePosition	time position value in seconds.
 *	
 *	Notes:
 *			  If the stream is broken into multiple distinct files, this should be the time position within the asset as a whole.
 */
- (void)setVideoAssetCurrentTimePosition:(NSTimeInterval)timePosition;

- (void)setSiteSection:(NSString *)siteSectionId :(NSUInteger)pageViewRandom :(NSUInteger)networkId :(FWIdType)idType :(NSUInteger)fallbackId DEPRECATED_ATTRIBUTE;

/**
 *	Set the attributes of the site section
 *	\param	siteSectionId	id of the site section
 *	\param	idType			type of the ID, should be one of
 *								-	FW_ID_TYPE_CUSTOM
 *								-	FW_ID_TYPE_FW
 *								-	FW_ID_TYPE_FWGROUP
 *	\param	pageViewRandom	random number generated everytime a user visits current site section
 *	\param	networkId		id of the network the site section belongs to, 0 by default
 *	\param	fallbackId		site section ID to fallback to. When ad server fails to find the site section specified by siteSectionId, this ID will be used. 0 by default
 */
- (void)setSiteSectionId:(NSString *)siteSectionId idType:(FWIdType)idType pageViewRandom:(NSUInteger)pageViewRandom networkId:(NSUInteger)networkId fallbackId:(NSUInteger)fallbackId;

- (void)addCandidateAd:(NSUInteger)candidateAdId DEPRECATED_ATTRIBUTE;

/**
 *	Add candidate ads into the ad request
 *	\param	candidateAdId	id of the candidate ad
 */
- (void)addCandidateAdId:(NSUInteger)candidateAdId;

- (void)addTemporalSlot:(NSString *)customId :(NSString *)adUnit :(NSTimeInterval)timePosition :(NSString *)slotProfile :(NSUInteger)cuePointSequence :(NSTimeInterval)maxDuration :(NSString *)acceptPrimaryContentType :(NSString *)acceptContentType :(NSTimeInterval)minDuration DEPRECATED_ATTRIBUTE;

/**
 *	Add a temporal slot
 *	\param	customId					custom ID of the slot. If slot with specified ID already exists, the function call will be ignored.
 *	\param	adUnit						ad unit supported by the slot
 *	\param	timePosition				time position of the slot
 *	\param	slotProfile					profile name of the slot, nil by default
 *	\param	cuePointSequence			slot cue point sequence
 *	\param	minDuration					minimum duration of the slot allowed, 0 by default
 *	\param	maxDuration					maximum duration of the slot allowed, 0 by default
 *	\param	acceptPrimaryContentType	accepted primary content types, comma separated values, use "," as delimiter, nil by default
 *	\param	acceptContentType			accepted content types, comma separated values, use "," as delimiter, nil by default
 */
- (void)addTemporalSlot:(NSString *)customId adUnit:(NSString *)adUnit timePosition:(NSTimeInterval)timePosition slotProfile:(NSString *)slotProfile cuePointSequence:(NSUInteger)cuePointSequence minDuration:(NSTimeInterval)minDuration maxDuration:(NSTimeInterval)maxDuration acceptPrimaryContentType:(NSString *)acceptPrimaryContentType acceptContentType:(NSString *)acceptContentType;

- (void)addVideoPlayerNonTemporalSlot:(NSString *)customId :(NSString *)adUnit :(NSUInteger)width :(NSUInteger)height :(NSString *)slotProfile :(BOOL)acceptCompanion :(FWInitialAdOption)initialAdOption :(NSString *)acceptPrimaryContentType :(NSString *)acceptContentType :(NSArray *)compatibleDimensions DEPRECATED_ATTRIBUTE;

/**
 *	Add a video player non-temporal slot.
 *	\param	customId					custom ID of the slot. If slot with specified ID already exists, the function call will be ignored.
 *	\param	adUnit						ad unit supported by the slot
 *	\param	width						width of the slot
 *	\param	height						height of the slot
 *	\param	slotProfile					profile name of the slot, nil by default
 *	\param	acceptCompanion				whether companion ads are accepted
 *	\param	initialAdOption				choice of the initial ad in this slot, should be one of
 *		- FW_SLOT_OPTION_INITIAL_AD_STAND_ALONE: Display a new ad in this slot
 *		- FW_SLOT_OPTION_INITIAL_AD_KEEP_ORIGINAL: Keep the original ad in this slot
 *		- FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_ONLY: Ask ad server to fill this slot with the first companion ad, or keep the original ad if there is no companion ad available
 *		- FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_OR_STAND_ALONE: Ask ad server to fill this slot with the first companion ad, or display a new ad if there is no companion ad available
 *		- FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_THEN_STAND_ALONE: Ask ad server to fill this slot with the first companion ad, or display a new stand alone ad if there is no companion ad
 *		- FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_OR_NO_STAND_ALONE: Ask ad server to fill this slot with the first companion ad, but never deliver a stand alone ad if there is no companion ad
 *		- FW_SLOT_OPTION_INITIAL_AD_NO_STAND_ALONE: Ask ad server to fill this slot only with the PREROLL slot’s companion ad if there is one
 *		- FW_SLOT_OPTION_INITIAL_AD_NO_STAND_ALONE_IF_TEMPORAL: Ask ad server to fill this slot with a stand alone ad only when no temporal ad will be delivered, if there is any temporal ad selected, let this slot empty
 *		- FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_OR_NO_STAND_ALONE_IF_TEMPORAL Ask ad server to fill this slot with a stand alone ad only when no temporal ad will be delivered, if there is any temporal ad selected, let this slot empty, but if there is companion, can use this companion to initial this slot
 *	\param	acceptPrimaryContentType	accepted primary content types, comma separated values, use "," as delimiter, nil by default
 *	\param	acceptContentType			accepted content types, comma separated values, use "," as delimiter, nil by default
 *	\param	compatibleDimensions        an array of compatible dimensions, The dimension must be a NSDictionary object with key @'width' and @'height', the value of should be a positive integer. Examples:
 *		-	NSArray *keys = [NSArray arrayWithObjects:@"width", @"height", nil];
 *		-	NSArray *dimension1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:1980], [NSNumber numberWithInt:1080], nil];
 *		-	NSArray *dimension2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:1280], [NSNumber numberWithInt:720], nil];
 *		-	NSArray *myDimensions = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:dimension1 forKeys:keys], [NSDictionary dictionaryWithObjects:dimension2 forKeys:keys], nil];
 */
- (void)addVideoPlayerNonTemporalSlot:(NSString *)customId adUnit:(NSString *)adUnit width:(NSUInteger)width height:(NSUInteger)height slotProfile:(NSString *)slotProfile acceptCompanion:(BOOL)acceptCompanion initialAdOption:(FWInitialAdOption)initialAdOption acceptPrimaryContentType:(NSString *)acceptPrimaryContentType acceptContentType:(NSString *)acceptContentType compatibleDimensions:(NSArray *)compatibleDimensions;

- (void)addSiteSectionNonTemporalSlot:(NSString *)customId :(NSString *)adUnit :(NSUInteger)width :(NSUInteger)height :(NSString *)slotProfile :(BOOL)acceptCompanion :(FWInitialAdOption)initialAdOption :(NSString *)acceptPrimaryContentType :(NSString *)acceptContentType :(NSArray *)compatibleDimensions DEPRECATED_ATTRIBUTE;

/**
 *	Add a site section non-temporal slot
 *	\param	customId					custom ID of the slot. If slot with specified ID already exists, the function call will be ignored.
 *	\param	adUnit						ad unit supported by the slot
 *	\param	width						width of the slot
 *	\param	height						height of the slot
 *	\param	slotProfile					profile name of the slot, nil by default
 *	\param	acceptCompanion				whether companion ads are accepted
 *	\param	initialAdOption				choice of the initial ad in this slot, should be one of
 *		- FW_SLOT_OPTION_INITIAL_AD_STAND_ALONE: Display a new ad in this slot
 *		- FW_SLOT_OPTION_INITIAL_AD_KEEP_ORIGINAL: Keep the original ad in this slot
 *		- FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_ONLY: Ask ad server to fill this slot with the first companion ad, or keep the original ad if there is no companion ad available
 *		- FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_OR_STAND_ALONE: Ask ad server to fill this slot with the first companion ad, or display a new ad if there is no companion ad available
 *		- FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_THEN_STAND_ALONE: Ask ad server to fill this slot with the first companion ad, or display a new stand alone ad if there is no companion ad
 *		- FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_OR_NO_STAND_ALONE: Ask ad server to fill this slot with the first companion ad, but never deliver a stand alone ad if there is no companion ad
 *		- FW_SLOT_OPTION_INITIAL_AD_NO_STAND_ALONE: Ask ad server to fill this slot only with the PREROLL slot’s companion ad if there is one
 *		- FW_SLOT_OPTION_INITIAL_AD_NO_STAND_ALONE_IF_TEMPORAL: Ask ad server to fill this slot with a stand alone ad only when no temporal ad will be delivered, if there is any temporal ad selected, let this slot empty
 *		- FW_SLOT_OPTION_INITIAL_AD_FIRST_COMPANION_OR_NO_STAND_ALONE_IF_TEMPORAL Ask ad server to fill this slot with a stand alone ad only when no temporal ad will be delivered, if there is any temporal ad selected, let this slot empty, but if there is companion, can use this companion to initial this slot
 *	\param	acceptPrimaryContentType	accepted primary content types, comma separated values, use "," as delimiter, nil by default
 *	\param	acceptContentType			accepted content types, comma separated values, use "," as delimiter, nil by default
 *	\param	compatibleDimensions        an array of compatible dimensions, The dimension must be a NSDictionary object with key @'width' and @'height', the value of should be a positive integer. Examples:
 *		-	NSArray *keys = [NSArray arrayWithObjects:@"width", @"height", nil];
 *		-	NSArray *dimension1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:1980], [NSNumber numberWithInt:1080], nil];
 *		-	NSArray *dimension2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:1280], [NSNumber numberWithInt:720], nil];
 *		-	NSArray *myDimensions = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:dimension1 forKeys:keys], [NSDictionary dictionaryWithObjects:dimension2 forKeys:keys], nil];
 */
- (void)addSiteSectionNonTemporalSlot:(NSString *)customId adUnit:(NSString *)adUnit width:(NSUInteger)width height:(NSUInteger)height slotProfile:(NSString *)slotProfile acceptCompanion:(BOOL)acceptCompanion initialAdOption:(FWInitialAdOption)initialAdOption acceptPrimaryContentType:(NSString *)acceptPrimaryContentType acceptContentType:(NSString *)acceptContentType compatibleDimensions:(NSArray *)compatibleDimensions;

/**
 *	Set the current state of the video
 *	\param	videoState	video state, should be one of:
 *		-	FW_VIDEO_STATE_PLAYING
 *		-	FW_VIDEO_STATE_PAUSED
 *		-	FW_VIDEO_STATE_STOPPED
 *		-	FW_VIDEO_STATE_COMPLETED
 */
- (void)setVideoState:(FWVideoState)videoState;

/**
 *  Set playhead time of the content video
 *  \param  playheadTime  video playhead time
 */
- (void)setVideoPlayheadTime:(NSTimeInterval *)playheadTime;

/**
 *	Get all temporal slots
 *	\return An NSArray of id<FWSlot> objects
 */
- (NSArray * /* id<FWSlot> */)temporalSlots;

/**
 *	Get all video player non-temporal slots
 *	\return An NSArray of id<FWSlot> objects
 */
- (NSArray * /* id<FWSlot> */)videoPlayerNonTemporalSlots;  

/**
 *	Get all site section non-temporal slots
 *	\return An NSArray of id<FWSlot> objects
 */
- (NSArray * /* id<FWSlot> */)siteSectionNonTemporalSlots;  

/**
 *	Get all slots in specified time position class
 *	\param	timePositionClass	time position class, should be one of:
 *   - FW_TIME_POSITION_CLASS_PREROLL
 *   - FW_TIME_POSITION_CLASS_MIDROLL
 *   - FW_TIME_POSITION_CLASS_POSTROLL
 *   - FW_TIME_POSITION_CLASS_OVERLAY
 *   - FW_TIME_POSITION_CLASS_DISPLAY
 *   - FW_TIME_POSITION_CLASS_PAUSE_MIDROLL
 *	\return An Array of id<FWSlot> objects
 */
- (NSArray * /* id<FWSlot> */)getSlotsByTimePositionClass:(FWTimePositionClass)timePositionClass;

/**
 *	Get a slot by its custom ID
 *	\param	customId	custom ID of the slot
 *	\return An id<FWSlot> object, or nil if not found
 */
- (id<FWSlot>)getSlotByCustomId:(NSString *)customId;

- (void)submitRequest:(NSTimeInterval)timeoutInterval DEPRECATED_ATTRIBUTE;

/**
 *	Submit the request to FreeWheel Ad Server
 *	\param	timeoutInterval ad request timeout value in seconds. 3 by default.
 */
- (void)submitRequestWithTimeout:(NSTimeInterval)timeoutInterval;

/**
 *  Add renderer class to context which takes higher priority than renderers set in renderer manifest returned from server.
 *  \param  className	The class name of the renderer.
 *  \param  contentType	The content types that the renderer can support, separated by comma.
 *  \param	creativeAPI The creative APIs that the renderer can support, separated by comma.
 *  \param	slotType	The slot types that the renderer can support, separated by comma.
 *  \param	baseAdUnit	The base ad units that the renderer can support, separated by comma.
 *	\param	soldAsAdUnit	The soldAs ad unit that the renderer can support, separated by comma.
 *  \param	parameters	The parameters set on renderer level.
 */
- (void)addRendererClass:(NSString *)className forContentType:(NSString *)contentType creativeAPI:(NSString *)creativeAPI slotType:(NSString *)slotType baseUnit:(NSString *)baseAdUnit adUnit:(NSString *)soldAsAdUnit withParameters:(NSDictionary *)parameters;

/**
 *	Set a parameter on a specified level. 
 *	
 *	\param	name    parameter name
 *	\param	value	parameter value
 *	\param	level	level of the parameter, must be one of:
 *					-	FW_PARAMETER_LEVEL_GLOBAL
 *					-	FW_PARAMETER_LEVEL_OVERRIDE					
 */
- (void)setParameter:(NSString *)name withValue:(id)value forLevel:(FWParameterLevel)level;

/**
 *	Retrieve a parameter
 *  \param  name  The name of the parameter
 */
- (id)getParameter:(NSString *)name;

/**
 *	Set a list of acceptable alternative dimensions
 *	
 *	\param	compatibleDimensions	an array of compatible dimensions, The dimension must be a NSDictionary object with key @'width' and @'height', the value of should be a positive integer. Examples:
 *					-	NSArray *keys = [NSArray arrayWithObjects:@"width", @"height", nil];
 *					-	NSArray *dimension1 = [NSArray arrayWithObjects:[NSNumber numberWithInt:1980], [NSNumber numberWithInt:1080], nil];
 *					-	NSArray *dimension2 = [NSArray arrayWithObjects:[NSNumber numberWithInt:1280], [NSNumber numberWithInt:720], nil];
 *					-	NSArray *myDimensions = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:dimension1 forKeys:keys], [NSDictionary dictionaryWithObjects:dimension2 forKeys:keys], nil];
 *					-	[context setVideoDisplayCompatibleSizes:myDimensions];
 */
- (void)setVideoDisplayCompatibleSizes:(NSArray *)compatibleDimensions;

/**
 *	Set request mode of AdManager.
 *	\param	mode	request mode, must be one of:
 *					- FW_REQUEST_MODE_ON_DEMAND (default)
 *					- FW_REQUEST_MODE_LIVE
 *			
 *	Notes:
 *		AdManager runs in On-Demand mode(_FW_REQUEST_MODE_ON_DEMAND) by default. If your video asset is a live stream, invoke this method to set the player to live mode. This method should be called (if needed) right after a new FWContext instance is created.
 *	
 */
- (void)setRequestMode:(FWRequestMode)mode;

/**
 *	Set the duration for which the player is requesting ads. Optional.
 *	\param	requestDuration		requesting duration value, in seconds.
 */
- (void)setRequestDuration:(NSTimeInterval)requestDuration;

/**
 *	Reset the exclusivity scope
 */
- (void)resetExclusivity;

- (void)startSubsession:(NSUInteger)subsessionToken DEPRECATED_ATTRIBUTE;

/**
 *	Start a subsession in live mode. Subsequent requests will be in the same subsession, until this method is called again with a different token.
 *	\param	subsessionToken		a token to identify the subsession, should be unique across different subsessions. Use a different token to start a new subsession.
 *	    
 *	Note:
 *		Calling this method multiple times with the same token will have no effect.
 *		Subsession only works when FW_CAPABILITY_SYNC_MULTI_REQUESTS is on, calling this method will turn on this capability.
 */
- (void)startSubsessionWithToken:(NSUInteger)subsessionToken;

/**
 *	Get video asset's location URL
 *
 *	\return video asset's URL, nil if not set
 */
- (NSString *)getVideoLocation;

/**
 *  Get the AdManager instance for this context
 *
 *  \return A id<FWAdManager> instance
 */
- (id<FWAdManager>)getAdManager;

/**
 *	Return the object [NSNotificationCenter defaultCenter]
 */
- (NSNotificationCenter *)notificationCenter;

/**
 *	Notify AdManager about user actions
 *	\param	userAction		user actions, must be one of:
 *							- FW_USER_ACTION_PAUSE_BUTTON_CLICKED
 *							- FW_USER_ACTION_RESUME_BUTTON_CLICKED
 */
- (void)notifyUserAction:(FWUserAction)userAction;

/**
 *	Load player extension by its class name
 *
 *	Parameters:
 *		extensionName		-	the class name of the extension
 *
 *	Events:
 *		FW_NOTIFICATION_EXTENSION_LOADED will be posted by the FWContext object when an extension succeeds or fails to initialize.
 *		If the notification's userInfo dict contains key FW_INFO_KEY_ERROR, it indicate the extension failed to initialize.
 */
- (void)loadExtension:(NSString *)extensionName;

/**
 *	Request timeline to pause. The timeline consists of the content video and all linear slots.
 *	When the renderer or extension requires the timeline to be temporarily paused, e.g. when expanding to a fullscreen view that covers the whole player and other ads, calling this method will result in the notification FW_NOTIFICATION_CONTENT_PAUSE_REQUEST being dispatched from the current FWContext instance if content video is currently playing, and send pause requests to all active temporal slots.
 */
- (void)requestTimelinePause;

/**
 *	Request timeline to resume. The timeline consists of the content video and all linear slots.
 *	When the renderer or extension requires the timeline to be resumed, e.g. when dismissing a fullscreen view that covers the whole player and other ads, calling this method will result in the notification FW_NOTIFICATION_CONTENT_RESUME_REQUEST being dispatched from the current FWContext instance if content video is currently paused, and send resume requests to all active temporal slots.
 */
- (void)requestTimelineResume;

- (NSString *)transactionId;

@end


/**
 *	Protocol for slot 
 */
@protocol FWSlot <NSObject>

/**
 *	Get the slot's custom ID
 *	\return Custom ID of the slot
 */
- (NSString *)customId;  

/**
 *	Get the slot's type
 *	\return Type of the slot, the value can be one of:
 *		-	FW_SLOT_TYPE_TEMPORAL
 *		-	FW_SLOT_TYPE_VIDEOPLAYER_NONTEMPORAL
 *		-	FW_SLOT_TYPE_SITESECTION_NONTEMPORAL
 */
- (FWSlotType)type;				

/**
 *	Get the slot's time position
 *	\return Time position of the slot
 */
- (NSTimeInterval)timePosition;     

/**
 *	Get slot's time position class
 *	\return Time position class of the slot, the value can be one of:
 *   - FW_TIME_POSITION_CLASS_PREROLL
 *   - FW_TIME_POSITION_CLASS_MIDROLL
 *   - FW_TIME_POSITION_CLASS_POSTROLL
 *   - FW_TIME_POSITION_CLASS_OVERLAY
 *   - FW_TIME_POSITION_CLASS_DISPLAY
 *   - FW_TIME_POSITION_CLASS_PAUSE_MIDROLL
 */
- (FWTimePositionClass)timePositionClass;	   

/**
 *	Get the slot's embedded ads duration
 *	\return The embeded ads duration of the temporal slot. -1 if not available.
 */
- (NSTimeInterval)embeddedAdsDuration;

/**
 *  Get the slot's end time position
 *  \return The end time position of the temporal slot. -1 if not available.
 */
- (NSTimeInterval)endTimePosition;

/**
 *	Get the ad instances in the slot
 *	\return An array of id<FWAdInstance>
 */
- (NSArray * /* <id>FWAdInstance */)adInstances;

/**
 *	Get the width of the slot in pixels as returned in ad response.
 *	\return Width in pixels
 */
- (NSInteger)width;

/**
 *	Get the height of the slot in pixels as returned in ad response.
 *	\return Height in pixels
 */
- (NSInteger)height;

/**
 *	Process slot event
 *	\param	eventName Event to be processed, one of FW_EVENT_SLOT_* in FWConstants.h
 */
- (void)processEvent:(NSString *)eventName;

/**
 *  Preload the slot.
 *  The notification FW_NOTIFICATION_SLOT_PRELOADED will be dispatched when the slot has finished preloading.
 *
 *  Note: For ads, the preload behaviour may differ due to different ad types.
 */
- (void)preload;

/**
 *	Play the slot.
 *
 *	Note: If your app uses MPMoviePlayerController for content video playback, you will need to release the player when a midroll video slot is about to start, and re-create a new MPMoviePlayerController after the midroll slot ends, starting from where it was left off. This is due to the limitation that MPMoviePlayerController only supports one active stream at a time.
 *	AVPlayer does not have this limitation.
 */
- (void)play;

/**
 *	Stop the slot
 */
- (void)stop;

/**
 *	Pause the slot.
 */
- (void)pause;

/**
 *	Resume the slot.
 */
- (void)resume;

/**
 *	Get slot's visibility. Only applicable to non-temporal slots. YES by default.
 */
- (BOOL)visible;

/**
 *	Set the visibility for a nontemporal slot. 
 *
 *	If a nontemporal slot view should not be visible, call setVisible:NO before the slot starts. In this case there will be no impression sent to FreeWheel ad server, even if [slot play] has already been called. 
 *  If a nontemporal slot has started([slot play] has been called) when it is invisible, calling setVisible:YES will display the slot and send an impression.
 *
 *	Note:
 *		This method has no effect on temporal slots.
 *      This method has no effect anymore if an impression has been sent.
 *
 *  \param  value	YES or NO
 */
- (void)setVisible:(BOOL)value;

/**
 *	Get slot base UIView object.
 *	For nontemporal slots, the returned UIView should be added to a parent UIView that is already in your apps view hierarchy.
 *	For temporal slot, return value is the object set by -[FWContext setVideoDisplayBase:].
 */
- (UIView *)slotBase;

/**
 *	Set a parameter on the slot level
 *	\param	name	name of the parameter
 *	\param	value	value of the parameter
 */
- (void)setParameter:(NSString *)name withValue:(id)value;

/**
 *	Get the value of a parameter by its name
 *  \param  name    Parameter name
 *  \return value of the parameter
 */
- (id)getParameter:(NSString *)name;

/** 
 *  Get the slot's duration
 *  \return the duration in seconds, greater than or equal to 0 
 */  
- (NSTimeInterval)totalDuration;

/** 
 *  Get the slot's playhead
 *  \return the playhead time in seconds, greater than or equal to 0
 */  
- (NSTimeInterval)playheadTime;

/**
 *	Get the currently playing ad instance
 *	\return the AdInstance object of the currently playing ad in this slot. Return nil if no ad instance is currently playing.
 */
- (id<FWAdInstance>)currentAdInstance;
@end


/**
 *	Protocol for ad instance
 */
@protocol FWAdInstance <NSObject>

/**
 *	Get the ad ID of the ad instance. This value can also be found in the advertising module of the FreeWheel MRM UI.
 *	\return ID of the ad instance
 */
- (NSUInteger)adId;

- (NSString *)adUniqueId;

/**
 *	Get the creative ID of the ad instance
 *	This is the creative ID associated with this ad. The value can also be found in the advertising module of the FreeWheel MRM UI.
 *	\return Creative ID as an unsigned int
 */
- (NSUInteger)creativeId;

/**
 *	Get the primary rendition of the ad instance
 *	\return An id<FWCreativeRendition>
 */
- (id<FWCreativeRendition>)primaryCreativeRendition;

- (NSArray *)getEventCallbackUrls:(NSString *)eventName :(NSString *)eventType DEPRECATED_ATTRIBUTE;

/**
 *	Get the callback urls for the specified event
 *
 *	\param	eventName	name of the event, FW_EVENT_AD_*
 *	\param	eventType	type of the event, FW_EVENT_TYPE_*
 *	Valid eventName/eventType pairs:
 *		- (FW_EVENT_AD_IMPRESSION,        FW_EVENT_TYPE_IMPRESSION)	-	ad impression
 *		- (FW_EVENT_AD_FIRST_QUARTILE,	  FW_EVENT_TYPE_IMPRESSION) -	firstQuartile
 *		- (FW_EVENT_AD_MIDPOINT,		  FW_EVENT_TYPE_IMPRESSION) -	midPoint
 *		- (FW_EVENT_AD_THIRD_QUARTILE,	  FW_EVENT_TYPE_IMPRESSION) -	thirdQuartile
 *		- (FW_EVENT_AD_COMPLETE,          FW_EVENT_TYPE_IMPRESSION)	-	complete
 *		- (FW_EVENT_AD_CLICK,             FW_EVENT_TYPE_CLICK)		-	click through
 *		- (FW_EVENT_AD_CLICK,             FW_EVENT_TYPE_CLICKTRACKING)	-	click tracking
 *		- ("custom_click_name",           FW_EVENT_TYPE_CLICK)			-	custom click
 *		- ("custom_click_tracking_name",  FW_EVENT_TYPE_CLICKTRACKING)	-	custom click tracking
 *		- (FW_EVENT_AD_PAUSE,             FW_EVENT_TYPE_STANDARD)		-	IAB metric, pause
 *		- (FW_EVENT_AD_RESUME,            FW_EVENT_TYPE_STANDARD)		-	IAB metric, resume
 *		- (FW_EVENT_AD_REWIND,            FW_EVENT_TYPE_STANDARD)		-	IAB metric, rewind
 *		- (FW_EVENT_AD_MUTE,              FW_EVENT_TYPE_STANDARD)		-	IAB metric, mute
 *		- (FW_EVENT_AD_UNMUTE,            FW_EVENT_TYPE_STANDARD)		-	IAB metric, unmute
 *		- (FW_EVENT_AD_COLLAPSE,          FW_EVENT_TYPE_STANDARD)		-	IAB metric, collapse
 *		- (FW_EVENT_AD_EXPAND,            FW_EVENT_TYPE_STANDARD)		-	IAB metric, expand
 *		- (FW_EVENT_AD_MINIMIZE,          FW_EVENT_TYPE_STANDARD)		-	IAB metric, minimize
 *		- (FW_EVENT_AD_CLOSE,             FW_EVENT_TYPE_STANDARD)		-	IAB metric, close
 *		- (FW_EVENT_AD_ACCEPT_INVITATION, FW_EVENT_TYPE_STANDARD)		-	IAB metric, accept invitation
 *	
 *	\return: Array of urls in NSString
 *	
 */
- (NSArray *)getEventCallbackUrlsByEventName:(NSString *)eventName eventType:(NSString *)eventType;

- (void)setEventCallbackUrls:(NSString *)eventName :(NSString *)eventType :(NSArray *)urls DEPRECATED_ATTRIBUTE;

/**
 *	Set callback urls for the specified event
 *
 *	\param	eventName	name of event, FW_EVENT_AD_*
 *	\param	eventType	type of event, FW_EVENT_TYPE_*
 *	\param	urls		external urls to ping 
 *	Valid eventName/eventType pairs:
 *		- (FW_EVENT_AD_IMPRESSION,        FW_EVENT_TYPE_IMPRESSION)	-	ad impression
 *		- (FW_EVENT_AD_FIRST_QUARTILE,    FW_EVENT_TYPE_IMPRESSION)	-	1st quartile
 *		- (FW_EVENT_AD_MIDPOINT,          FW_EVENT_TYPE_IMPRESSION)	-	midpoint
 *		- (FW_EVENT_AD_THIRD_QUARTILE,    FW_EVENT_TYPE_IMPRESSION)	-	3rd quartile
 *		- (FW_EVENT_AD_COMPLETE,          FW_EVENT_TYPE_IMPRESSION)	-	complete
 *		- (FW_EVENT_AD_CLICK,             FW_EVENT_TYPE_CLICK)		-	click through
 *		- (FW_EVENT_AD_CLICK,             FW_EVENT_TYPE_CLICK_TRACKING)	-	click tracking
 *		- ("custom_click_name",           FW_EVENT_TYPE_CLICK)			-	custom click through
 *		- ("custom_click_name",           FW_EVENT_TYPE_CLICK_TRACKING)	-	custom click tracking
 *		- (FW_EVENT_AD_PAUSE,             FW_EVENT_TYPE_STANDARD)		-	IAB metric, pause
 *		- (FW_EVENT_AD_RESUME,            FW_EVENT_TYPE_STANDARD)		-	IAB metric, resume
 *		- (FW_EVENT_AD_REWIND,            FW_EVENT_TYPE_STANDARD)		-	IAB metric, rewind
 *		- (FW_EVENT_AD_MUTE,              FW_EVENT_TYPE_STANDARD)		-	IAB metric, mute
 *		- (FW_EVENT_AD_UNMUTE,            FW_EVENT_TYPE_STANDARD)		-	IAB metric, unmute
 *		- (FW_EVENT_AD_COLLAPSE,          FW_EVENT_TYPE_STANDARD)		-	IAB metric, collapse
 *		- (FW_EVENT_AD_EXPAND,            FW_EVENT_TYPE_STANDARD)		-	IAB metric, expand
 *		- (FW_EVENT_AD_MINIMIZE,          FW_EVENT_TYPE_STANDARD)		-	IAB metric, minimize
 *		- (FW_EVENT_AD_CLOSE,             FW_EVENT_TYPE_STANDARD)		-	IAB metric, close
 *		- (FW_EVENT_AD_ACCEPT_INVITATION, FW_EVENT_TYPE_STANDARD)		-	IAB metric, accept invitation
 */
- (void)setEventCallbackUrls:(NSArray *)urls forEventName:(NSString *)eventName eventType:(NSString *)eventType;

/**
 *	Add a creative rendition to the ad instance 
 *	\return the FWCreativeRendition object added to the ad instance
 */
- (id<FWCreativeRendition>)addCreativeRendition;

/**
 *	Get the renderer controller of the ad instance
 *	\return An id<FWRendererController>
 */
- (id<FWRendererController>)rendererController;

/**
 *  Retrieve the parameter from the ad instance.
 *  The parameter value will be retrieved from levels in the following order: 
 *  override, creative rendition, creative, slot, profile, global.
 *
 *  \param  name  parameter name
 *  \return the value of the parameter
 */
- (id)getParameter:(NSString *)name;

/**
 *	Get the companion slots of the ad instance
 * \return an array of id<FWSlot>
 */
- (NSArray *)companionSlots;

/**
 *	Get the playable companion ad instances
 *
 *	\return an array of id<FWAdInstance>
 */
- (NSArray *)companionAdInstances;

/**
 *	Whether the ad is required to be shown by law, usually the ad is a companion ad
 *
 *	\return a Bool true if this ad is required to be shown, otherwise false
 */
- (BOOL)isRequiredToShow;

/**
 * Get all creative renditions of the ad instance
 */
- (NSArray* /*id<FWCreativeRendition>*/)creativeRenditions;

/**
 * Set the primary creative rendition
 * \param  primaryCreativeRendition     a pointer to the primary creative rendition
 */
- (void)setPrimaryCreativeRendition:(id<FWCreativeRendition>)primaryCreativeRendition;

/**
 *	Get the slot that contains this ad instance
 */
- (id<FWSlot>)slot;

- (void)play2;

/**
 *	Get duration of the ad instance
 *	\return Duration in seconds
 */
- (NSTimeInterval)duration;

/**
 *  Get the ad instance's playhead
 *  \return the playhead time in seconds, greater than or equal to 0
 */
- (NSTimeInterval)playheadTime;
@end


/**
 *	Protocol for creative rendition
 */
@protocol FWCreativeRendition <NSObject>

/**
 *	Get content type of the rendition
 *	\return  Content type in a string
 */
- (NSString *)contentType;

/**
 *	Set content type of the rendition
 */
- (void)setContentType:(NSString *)value;

/**
 *	Get wrapper type of the rendition
 *	\return  Wrapper type in a string
 */
- (NSString *)wrapperType;

/**
 *	Set wrapper type of the rendition
 */
- (void)setWrapperType:(NSString *)value;

/**
 *	Get wrapper url of the rendition
 *	\return  Wrapper url in a string
 */
- (NSString *)wrapperUrl;

/**
 *	Set wrapper url of the rendition
 */
- (void)setWrapperUrl:(NSString *)value;

/**
 *	Get creativeAPI of the rendition
 *	\return  creativeAPI in a string
 */
- (NSString *)creativeAPI;

/**
 *	Set creativeAPI of the rendition
 */
- (void)setCreativeAPI:(NSString *)value;

/**
 *	Get base unit of the rendition
 *	\return Base unit in a string
 */
- (NSString *)baseUnit;

/**
 *	Get preference of the rendition
 *	\return A number, the higher is preferred among all renditions in the creative
 */
- (int)preference;

/**
 *	Set preference of the rendition
 */
- (void)setPreference:(int)value;

/**
 *	Get width of the rendition
 *	\return Width in pixels
 */
- (NSUInteger)width;

/**
 *	Set width of the rendition
 */
- (void)setWidth:(NSUInteger)value;

/**
 *	Get height of the rendition
 *	\return Height in pixels
 */
- (NSUInteger)height;

/**
 *	Set height of the rendition
 */
- (void)setHeight:(NSUInteger)value;

/**
 *	Get duration of the rendition
 *	\return Duration in seconds
 */
- (NSTimeInterval)duration;

/**
 *	Set duration of the rendition
 *	\return Duration in seconds
 */
- (void)setDuration:(NSTimeInterval)value;

- (void)setParameter:(NSString *)name :(NSString *)value DEPRECATED_ATTRIBUTE;

/**
 *	Set parameter on the rendition
 */
- (void)setParameter:(NSString *)name withValue:(NSString *)value;

/**
 *	Get primary asset of the rendition
 *	\return An id<FWCreativeRenditionAsset>
 */
- (id<FWCreativeRenditionAsset>)primaryCreativeRenditionAsset;

/**
 *	Get all non-primary assets of the rendition
 *	\return An array of id<FWCreativeRenditionAsset>
 */
- (NSArray * /* <id>FWCreativeRenditionAsset */)otherCreativeRenditionAssets;

/**
 *	Add an asset to the rendition
 */
- (id<FWCreativeRenditionAsset>)addCreativeRenditionAsset;
@end


/**
 *	Protocol for creative rendition asset
 */
@protocol FWCreativeRenditionAsset <NSObject>
/**
 *	Get name of the asset
 *	\return Name in a string
 */
- (NSString *)name;

/**
 *	Set name of the asset
 */
- (void)setName:(NSString *)value;

/**
 *	Get URL of the asset
 *	\return URL in a string
 */
- (NSString *)url;

/**
 *	Set URL of the asset
 */
- (void)setUrl:(NSString *)value;

/**
 *	Get content of the asset
 *	\return Content in a string
 */
- (NSString *)content;

/**
 *	Set the content of the asset
 */
- (void)setContent:(NSString *)value;

/**
 *	Get mime type of the asset
 *	\return Mime type in a string
 */
- (NSString *)mimeType;

/**
 *	Set mime type of the asset
 */
- (void)setMimeType:(NSString *)value;

/**
 *	Get content type of the asset
 *	\return Content type in a string
 */
- (NSString *)contentType;

/**
 *	Set content type of the asset
 */
- (void)setContentType:(NSString *)value;

/**
 *	Get size of the asset
 *	\return Size in bytes, or -1 if unknown
 */
- (NSInteger)bytes;

/**
 *	Set size of the asset
 *	\return Size in bytes, or -1 if unknown
 */
- (void)setBytes:(NSInteger)value;
@end


@protocol FWNotificationContext

- (void)postNotificationName:(NSString *)notificationName userInfo:(NSDictionary *)userInfo;

@end


/**
 *	Protocol for renderer controller
 *	The FWRendererController class provides methods for reporting metric events and changing renderer states.
 */
@protocol FWRendererController <NSObject>

/**
 *  Return the current location.
 *  See also: -[FWAdManager setLocation:]
 *  \return current location
 */
- (CLLocation *)location;

/**
 *	Return application's current view controller. 
 *  See also: -[FWAdManager setCurrentViewController:].
 *  \return current view controller
 */
- (UIViewController *)currentViewController;

- (MPMoviePlayerController *)moviePlayerController DEPRECATED_ATTRIBUTE;

- (BOOL)moviePlayerFullscreen DEPRECATED_ATTRIBUTE;

/**
*  Return all renderable renditions for Renderer
*  \return an array of id<FWCreativeRendition>
*/
- (NSArray * /* id<FWCreativeRendition> */)renderableCreativeRenditions;

/**
 *	Process renderer event
 *	\param	eventName Event to be processed, one of FW_EVENT_AD_* in FWConstants.h
 * 
 *	Valid eventName:
 *		- FW_EVENT_AD_FIRST_QUARTILE    - firstQuartile
 *		- FW_EVENT_AD_MIDPOINT          - midPoint
 *		- FW_EVENT_AD_THIRD_QUARTILE    - thirdQuartile
 *		- FW_EVENT_AD_COMPLETE          - complete
 *		- FW_EVENT_AD_CLICK             - click
 *		- FW_EVENT_AD_PAUSE             - IAB metric, pause
 *		- FW_EVENT_AD_RESUME            - IAB metric, resume
 *		- FW_EVENT_AD_REWIND            - IAB metric, rewind
 *		- FW_EVENT_AD_MUTE              - IAB metric, mute
 *		- FW_EVENT_AD_UNMUTE            - IAB metric, unmute
 *		- FW_EVENT_AD_COLLAPSE          - IAB metric, collapse
 *		- FW_EVENT_AD_EXPAND            - IAB metric, expand
 *		- FW_EVENT_AD_MINIMIZE          - IAB metric, minimize
 *		- FW_EVENT_AD_CLOSE             - IAB metric, close
 *		- FW_EVENT_AD_ACCEPT_INVITATION - IAB metric, accept invitation
 *
 *  \param  details  Additional information. Available keys:
 * 					- FW_INFO_KEY_CUSTOM_EVENT_NAME Optional. 
 * 					Name of the custom event.
 * 					- FW_INFO_KEY_SHOW_BROWSER Optional. 
 * 					Force opening / not opening click through url in WebView or Mobile Safari.
 * 					If this key is not provided, AdManager will use the setting booked in MRM UI (recommended).
 * 					- FW_INFO_KEY_URL Optional. 
 * 					URL to open or used as redirect url on FW_EVENT_AD_CLICK.
 * 					If this key is not provided, the URL booked in MRM UI will be used.
 */
- (void)processEvent:(NSString *)eventName info:(NSDictionary *)details;

- (void)setCapability:(NSString *)eventCapability :(FWCapabilityStatus)status DEPRECATED_ATTRIBUTE;

/**
 *	Declare a capability of the renderer
 *	\param	eventCapability One of FW_EVENT_AD_* (NOT including FW_EVENT_AD_FIRST_QUARTILE, FW_EVENT_AD_THIRD_QUARTILE, FW_EVENT_AD_IMPRESSION) in FWConstants.h
 *	\param	status ON if renderer has specified capability or is able to send specified event
 *
 *	Note: \n
 *	Changing renderer capability after renderer starts playing may result in undefined behaviour
 */
- (void)setCapability:(NSString *)eventCapability status:(FWCapabilityStatus)status;

/**
 *	Return the Major version of AdManager, e.g. 0x02060000 for v2.6
 *  \return version as NSUInteger
 */
- (NSUInteger)version;

/**
 *	Retrieve a parameter
 *  \param  name  Parameter name
 */
- (id)getParameter:(NSString *)name;

/**
 * Get rendering ad instance
 */
- (id<FWAdInstance>)adInstance;

/**
 * Transit renderer state
 * \param  state	destination transition state attempted, available values:
 * 					- FW_RENDERER_STATE_STARTED
 * 					- FW_RENDERER_STATE_COMPLETED
 * 					- FW_RENDERER_STATE_FAILED
 * \param  details	detail info
 * 					- For FW_RENDERER_STATE_FAILED:FW_INFO_KEY_ERROR_CODE are required. FW_INFO_KEY_ERROR_INFO is optional.
 */
- (void)handleStateTransition:(FWRendererStateType)state info:(NSDictionary *)details;

/**
 *	Returns the sender of all FreeWheel related notifications.
 */
- (id<FWContext>)notificationContext;

- (NSArray * /* id<FWAdInstance> */)scheduleAdInstances:(NSArray * /* id<FWSlot> */)slots DEPRECATED_ATTRIBUTE;

/**
 *	Schedule ad instances for the given slots.
 *	\param slots	NSArray of id<FWSlot>, slots to schedule ads for
 *	\return NSArray of scheduled id<FWAdInstance> in the same sequence of the passed in slot. nil if no ad instance can be scheduled for the corresponding slot.
 */
- (NSArray * /* id<FWAdInstance> */)scheduleAdInstancesInSlots:(NSArray * /* id<FWSlot> */)slots;

/**
 *	Request timeline to pause. The timeline consists of the content video and all linear slots.
 *	When the renderer or extension requires the timeline to be temporarily paused, e.g. when expanding to a fullscreen view that covers the whole player and other ads, calling this method will result in the notification FW_NOTIFICATION_CONTENT_PAUSE_REQUEST being dispatched from the current FWContext instance if content video is currently playing, and pause requests sent to all active temporal slots.
 */
- (void)requestTimelinePause;

/**
 *	Request timeline to resume. The timeline consists of the content video and all linear slots.
 *	When the renderer or extension requires the timeline to be resumed, e.g. when dismissing a fullscreen view that covers the whole player and other ads, calling this method will result in the notification FW_NOTIFICATION_CONTENT_RESUME_REQUEST being dispatched from the current FWContext instance if content video is currently paused, and send resume requests to all active temporal slots.
 */
- (void)requestTimelineResume;

/**
 *	Deprecated. Please use [[rendererController context] requestTimelinePause] and [[rendererController context] requestTimelineResume] instead.
 */
- (void)requestContentStateChange:(BOOL)pause DEPRECATED_ATTRIBUTE;

/**
 *  Renderer should use this API to trace all logs
 */
- (void)log:(NSString *)msg;
@end


/**
 *	Protocol for FWRenderer
 */
@protocol FWRenderer <NSObject>
/**
 *	Initialize the renderer with a renderer controller. 
 *	
 *	\param	rendererController	reference to id<FWRendererController>
 *		
 *	Note:
 *		Typically the renderer declares all available capabilities and events when this method is called.
 */
- (id)initWithRendererController:(id<FWRendererController>)rendererController;

/**
 *	Start ad playback.
 *	
 *	Note:
 *		The renderer should start the ad playback when this method is called,
 *		and transit to FW_RENDERER_STATE_STARTED state as soon as the ad has started.
 *		
 *		When the ad stops (either interrupted or reached the end), the renderer should
 *		transit to FW_RENDERER_STATE_COMPLETED state.
 */
- (void)start;

/**
 *	Stop ad playback.
 *
 *	Note:
 *		Typically the renderer will dispose playing images/videos from screen when receive this notification, and 
 *      transit to FW_RENDERER_STATE_COMPLETED state as soon as the ad is stopped.
 */
- (void)stop;

/**
 *	Get module info. The returned dictionary should contain key FW_INFO_KEY_MODULE_TYPE with FW_MODULE_TYPE_* value,
 *  and should contain key FW_INFO_KEY_REQUIRED_API_VERSION with the FreeWheel RDK version when the component is compiled.
 */
- (NSDictionary *)moduleInfo;


/**
 *	Get duration of the ad
 *  \return a positive number in seconds as NSTimeInterval, or -1 if the duration is N/A
 */
- (NSTimeInterval)duration;

/** 
 *	Get playheadTime of the ad
 * 	\return a positive number in seconds as NSTimeInterval, or -1 if the playhead time is N/A
 */  
- (NSTimeInterval)playheadTime;

@optional
/**
 *  Preload the ad.
 *
 *  Note:
 *		Renderers should start preloading the ad asynchronously when this method is called,
 *		and transit to FW_RENDERER_STATE_PRELOADED state when the ad finishes preloading.
 *     
 *		Translators should translate and schedule ads in the preloading stage.
 */
- (void)preload;

/**
 *	User intended pause. Should pause ad playback and send IAB _pause callback by calling [rendererController processEvent:FW_EVENT_AD_PAUSE info:nil].
 */
- (void)pause;

/**
 *	User intended resume. Should resume ad playback and send IAB _resume callback by calling [rendererController processEvent:FW_EVENT_AD_RESUME info:nil]
 */
- (void)resume;

@end

/**
 *	Protocol for FWExtension
 */
@protocol FWExtension <NSObject>
/**
 *	Initialize the extension with a id<FWContext> instance.
 *
 *	\param	context	reference to id<FWContext>
 *
 *	Note:
 *		The constructor of the extension. AdManager will use this method to get an object of the extension.
 */
- (id)initWithFWContext:(id<FWContext>)context;

/**
 *	Stop the extension.
 *
 *	Note:
 *		Extension should stop all its work and do cleanup in the method.
 *		id<FWContext> object should not be used anymore after executing stop.
 */
- (void)stop;

#pragma clang arc_cf_code_audited end

@end

