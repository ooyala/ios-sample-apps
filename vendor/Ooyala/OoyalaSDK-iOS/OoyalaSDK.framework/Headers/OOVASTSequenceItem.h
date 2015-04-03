/**
 * @class      OOVASTSequenceItem OOVASTSequenceItem.h "OOVASTSequenceItem.h"
 * @brief      OOVASTSequenceItem
 * @details    OOVASTSequenceItem.h in OoyalaSDK
 * @date       12/8/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class OOVASTLinearAd;

@interface OOVASTSequenceItem : NSObject {
@protected
  NSInteger number;
  OOVASTLinearAd *linear;
  NSDictionary *nonLinears;
  NSDictionary *companions;
}

@property(nonatomic) NSInteger number;                 /**< The sequence number associated with this item in the sequence */
@property(nonatomic, strong) OOVASTLinearAd *linear;     /**< The Linear Ad associated with this item in the sequence */
@property(nonatomic, strong) NSDictionary *nonLinears; /**< The Non-Linear Ads associated with this item in the sequence (XML converted to NSDictionary) */
@property(nonatomic, strong) NSDictionary *companions; /**< The Companion Ads associated with this item in the sequence (XML converted to NSDictionary) */

/**
 * Whether or not this OOVASTSequenceItem has a linear ad
 * @returns YES if there exists a linear ad, NO if there does not;
 */
- (BOOL)hasLinear;

@end
