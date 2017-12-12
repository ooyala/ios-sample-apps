/**
 * @class      OOAdPodInfo OOAdPodInfo.h "OOAdPodInfo.h"
 * @brief      OOAdPodInfo
 * @details    OOAdPodInfo.h in OoyalaSDK
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */
#import <Foundation/Foundation.h>

@interface OOAdPodInfo : NSObject

@property (nonatomic, readonly) NSString *title;          /** the title of the ad, if any */
@property (nonatomic, readonly) NSString *clickUrl;       /** the click url, if any */
@property (nonatomic, readonly) NSUInteger count;         /** the total ads count */
@property (nonatomic, readonly) NSUInteger unplayedCount; /** the unplayed ads count */
@property (nonatomic, readonly) Float64 skipoffset;       /** the skipoffset of the ad, if any */
@property (nonatomic, readonly) NSMutableArray *icons;    /** the icons of the ad, if any */
@property (nonatomic, readonly) BOOL requireAdBar;        /** if the ad require an adbar */
@property (nonatomic, readonly) BOOL requireControls;     /** if the ad require UI controls */


/**
 * Initialize an OOOptions object with the given parameters
 * @returns the initialized OOOptions
 */
- (instancetype)initWithTitle:(NSString *)title
                     clickUrl:(NSString *)clickUrl
                        count:(NSUInteger)adsCount
                unplayedCount:(NSUInteger)unplayedCount
                requiredAdBar:(BOOL)adbar
              requireControls:(BOOL)controls;

- (instancetype)initWithTitle:(NSString *)title
                     clickUrl:(NSString *)clickUrl
                        count:(NSUInteger)adsCount
                unplayedCount:(NSUInteger)unplayedCount
                   skipoffset:(Float64)skipoffset
                        icons:(NSMutableArray *)icons
                requiredAdBar:(BOOL)adbar
              requireControls:(BOOL)controls;

- (NSDictionary *)toDictionary;

@end
