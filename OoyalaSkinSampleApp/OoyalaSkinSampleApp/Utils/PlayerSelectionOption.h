/**
 * @class      PlayerSelectionOption PlayerSelectionOption.m "PlayerSelectionOption.m"
 * @brief      An object that contains the information needed to represent an example.
 * @details    An object that contains the information needed to represent an example.
 *             This object is passed between the List and the Player to transfer the information
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

@import UIKit;

@interface PlayerSelectionOption : NSObject

@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *domain;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *adSetProvider;
@property (nonatomic) NSString *playerDomain;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *markersFileName;
@property Class viewController;

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                 playerDomain:(NSString *)playerDomain
               viewController:(Class)viewController
                          nib:(NSString *)nib;

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                 playerDomain:(NSString *)playerDomain
               viewController:(Class)viewController
              markersFileName:(NSString *)markersFileName
                          nib:(NSString *)nib;

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                 playerDomain:(NSString *)playerDomain
                adSetProvider:(NSString *)adSetProvider
               viewController:(Class)viewController
                          nib:(NSString *)nib;
@end
