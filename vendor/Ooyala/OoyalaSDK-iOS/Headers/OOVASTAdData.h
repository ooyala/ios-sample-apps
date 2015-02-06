//
//  OOVASTAdData.h
//  OoyalaSDK
//
// Copyright (c) 2015 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OOVASTAdData : NSObject
@property(nonatomic, strong) NSString *adID;                   /**< the ID of the Ad */
@property(nonatomic, strong) NSString *system;                 /**< the System */
@property(nonatomic, strong) NSString *systemVersion;          /**< the System Version */
@property(nonatomic, strong) NSString *title;                  /**< the title of the Ad */
@property(nonatomic, strong) NSString *adDescription;            /**< the description of the Ad */
@property(nonatomic, strong) NSMutableArray *surveyURLs;       /**< the survey URLs of the Ad */
@property(nonatomic, strong) NSMutableArray *errorURLs;        /**< the error URLs of the Ad */
@property(nonatomic, strong) NSMutableArray *impressionURLs;   /**< the impression URLs of the Ad */
@property(nonatomic, strong) __block NSMutableArray *sequence; /**< the ordered sequence of the Ad (NSMutableArray of OOVASTSequenceItem) */
@property(nonatomic) NSDictionary *extensions;                 /**< the extensions of the Ad */
@end
