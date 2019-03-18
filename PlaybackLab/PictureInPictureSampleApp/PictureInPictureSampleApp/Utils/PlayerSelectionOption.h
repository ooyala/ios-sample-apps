/**
 * @class      PlayerSelectionOption PlayerSelectionOption.m "PlayerSelectionOption.m"
 * @brief      An object that contains the information needed to represent an example.
 * @details    An object that contains the information needed to represent an example.
 *             This object is passed between the List and the Player to transfer the information
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

@import Foundation;

@interface PlayerSelectionOption : NSObject
@property NSString *embedCode;
@property NSString *title;
@property NSString *nib;
@property NSString *playerDomain;
@property NSString *pcode;
@property Class viewController;
@property BOOL isAudioOnlyAsset;

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                 playerDomain:(NSString *)playerDomain
               viewController:(Class)viewController
                          nib:(NSString *)nib;

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                       domain:(NSString *)domain
               viewController:(Class)viewController;

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                       domain:(NSString *)domain
               viewController:(Class)viewController
                  isAudioOnly:(BOOL)isAudioOnly;

@end
