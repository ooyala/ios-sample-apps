//
//  OOContentMetadata.h
//  Pulse
//
//  Created by Jacques du Toit on 20/04/15.
//  Copyright (c) 2015 Ooyala. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 Potential content form values used to determine the ad insertion policy,
 set in OOContentMetadata
 */
typedef NS_ENUM(NSUInteger, OOContentForm) {
  /// Unknown content form
  OOContentFormUnknown = 0,
  /// Long form content. Typically used for feature films, TV series, complete games, and the like.
  OOContentFormLong  = 1,
  /// Short form content. Typically used for news summaries, game highlights and the like.
  OOContentFormShort = 2
};



/**
 Information about the content that is making the ad request.
 */
@interface OOContentMetadata : NSObject

- (id)copyExistingProperties:(OOContentMetadata *)sourceCm
     OverrideContentMetadata:(OOContentMetadata *)overrideCm;
/**
 Content category is used by Ooyala Pulse to target ads and determine the ad insertion
 policy. The content category can be represented by either its unique id or one 
 of its aliases set in Ooyala Pulse.
 */
@property (nonatomic, copy) NSString *category;

/**
 Content form is used to determine the ad insertion policy.
 */
@property (nonatomic, assign) OOContentForm contentForm;


/**
 Ooyala Pulse content id. Id is used to identify the content to 3rd parties.
 */
@property (nonatomic, copy) NSString *identifier;

/**
 Ooyala Pulse content partner. Content partners can be used by Ooyala Pulse to target ads. 
 The content partner can be represented by either its unique id or one of its 
 aliases set in Ooyala Pulse.
 */
@property (nonatomic, copy) NSString *contentPartner;

/**
 The duration of the content in seconds. 
 
 Must be non-negative.
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 Ooyala Pulse flags as an array of strings..
 
 Since flags overrides Ooyala Pulse's ad insertion policy they should be used with 
 caution. For more information please talk to your contact at Ooyala. 
 
 Supported flags: nocom, noprerolls, nomidrolls, nopostrolls, nooverlays, noskins.
 
 All flags must be instances of NSString.
 */
@property(nonatomic, copy) NSArray *flags;

/**
 Ooyala Pulse content tags, used to target specific ads.
 
 All tags must be instances of NSString.
 */
@property (nonatomic, copy) NSArray *tags;

/**
 The custom parameters to add to the session request. Parameters with names
 containing invalid characters will be omitted.
 
 All keys and values must be of type NSString.
 */
@property (nonatomic, copy) NSDictionary *customParameters;

@end
