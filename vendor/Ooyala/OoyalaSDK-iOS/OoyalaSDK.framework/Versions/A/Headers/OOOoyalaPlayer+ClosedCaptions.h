//
//  OOOoyalaPlayer+ClosedCaptions.h
//  OoyalaSDK
//
//  Created on 11/1/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#import "OOOoyalaPlayer.h"

#ifndef OOOoyalaPlayer_ClosedCaptions_h
#define OOOoyalaPlayer_ClosedCaptions_h

@interface OOOoyalaPlayer (ClosedCaptions)

/**
 * Disables the CC in the HLS Playlist.
 */
- (void)disablePlaylistClosedCaptions;

/**
 * Get the available closed captions languages
 * @returns an NSArray containing the available closed captions languages as NSStrings
 */
- (NSArray *)availableClosedCaptionsLanguages;

/**
 * Get the short code from the natural language name. Example: name="english", code="en".
 * @param name is the long name, from availableClosedCaptionsLanguages.
 * @return the short cc code. If the reverse mapping fails, the original name parameter value is returned.
 */
-(NSString*)languageNameToLanguageCode:(NSString*)name;

@end


#endif /* OOOoyalaPlayer_ClosedCaptions_h */
