/**
 * @class      PlayerSelectionOption PlayerSelectionOption.m "PlayerSelectionOption.m"
 * @brief      An object that contains the information needed to represent an example.
 * @details    An object that contains the information needed to represent an example.
 *             This object is passed between the List and the Player to transfer the information
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

@import Foundation;

@protocol OOEmbedTokenGenerator;

@interface PlayerSelectionOption : NSObject
/**
 An Ooyala embed code from the same account of the pcode.
 */
@property (nonatomic) NSString *embedCode;
/**
 Ooyala's account pcode.
 */
@property (nonatomic) NSString *pcode;
/**
 Valid domain to play the content in (e.g. http://www.ooyala.com).
 */
@property (nonatomic) NSString *domain;
/**
 Title of the asset.
 */
@property (nonatomic) NSString *title;
/**
 The viewController class to use
 */
@property (nonatomic) Class viewController;
/**
 OOEmbedTokenGenerator used to generate an authToken to append to the Fairplay requests.
 */
@property (nonatomic) id<OOEmbedTokenGenerator> embedTokenGenerator;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                       domain:(NSString *)domain
               viewController:(Class)viewController;

+ (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                       domain:(NSString *)domain
               viewController:(Class)viewController
          embedTokenGenerator:(id<OOEmbedTokenGenerator>)embedTokenGenerator;

@end
