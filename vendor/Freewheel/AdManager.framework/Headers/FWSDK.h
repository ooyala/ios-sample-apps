/**
 * \mainpage FreeWheel AdManager Cocoa Touch SDK
 *
 *	The FreeWheel AdManager Cocoa Touch SDK is a static library for integrating
 *	your cocoa touch applications with FreeWheel MRM ad services.
 *
 *	The SDK supports iOS 5+ running on iPhone, iPod Touch and iPad. It is a
 *	universal binary bundle with armv7, armv7s, arm64, i386 and x86_64 architectures.
 *
 *	The SDK may utilize UIKit intensively, so invoke from main thread is highly preferred,
 *	otherwise crash may occur.
 *
 * To use the SDK,
 *	- Add libxml2.dylib, UIKit.framework, CoreGraphics.framework,
 *		QuartzCore.framework, MediaPlayer.framework, CoreLocation.framework, 
 *		CoreMedia.framework, AVFoundation.framework, MessageUI.framework, EventKit.framework,
 *		AdSupport.framework(add as optional linked)
 *		to your project.
 *	- Add AdManager.framework to your project.
 *	- Add "#import <AdManager/FWSDK.h>" in your code.
 *	- Add and register additional 3rd party renderer framework to your project (optional)
 *      Use the macro FW_LINK_RENDERER(<renderer class name>) in .m file outside any @@implementation, e.g.
 *      FW_LINK_RENDERER(FWSkeletonRenderer)
 */

#import "FWConstants.h"
#import "FWProtocols.h"
#import "FWVer.h"
