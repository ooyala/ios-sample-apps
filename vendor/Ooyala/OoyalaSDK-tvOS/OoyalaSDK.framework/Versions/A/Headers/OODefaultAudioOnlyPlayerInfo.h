//
//  OODefaultAudioOnlyPlayerInfo.h
//  OoyalaSDK
//
//  Created by Max Kupetskii on 12/28/18.
//  Copyright © 2018 Ooyala, Inc. All rights reserved.
//

#ifndef OODefaultAudioOnlyPlayerInfo_h
#define OODefaultAudioOnlyPlayerInfo_h

#import "OODefaultPlayerInfo.h"

#define OO_AUDIO_HLS @"audio_hls"
#define OO_AUDIO_M4A @"audio_m4a"

/**
 This is the default implementation of OOPlayerInfo for audio_only assets.
 OOPlayerInfo is used for providing information for Authorization.
 You can extend this class and override any of the settings in OOPlayerInfo, then call
 [OOStreamPlayer setDefaultPlayerInfo:customPlayerInfo]; before you setEmbedCode
 */
@interface OODefaultAudioOnlyPlayerInfo : OODefaultPlayerInfo
@end

#endif /* OODefaultAudioOnlyPlayerInfo_h */
