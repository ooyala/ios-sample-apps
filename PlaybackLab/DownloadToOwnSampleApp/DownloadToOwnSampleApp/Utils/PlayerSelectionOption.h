/**
 * @class      PlayerSelectionOption PlayerSelectionOption.m "PlayerSelectionOption.m"
 * @brief      An object that contains the information needed to represent an example.
 * @details    An object that contains the information needed to represent an example.
 *             This object is passed between the List and the Player to transfer the information
 * @date       12/12/14
 * @copyright  Copyright (c) 2014 Ooyala, Inc. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import <OoyalaSDK/OoyalaSDK.h>

@interface PlayerSelectionOption : NSObject

@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *pcode;
@property (nonatomic) NSString *domain;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *nib;
@property (nonatomic) id<OOEmbedTokenGenerator> embedTokenGenerator;
@property (nonatomic) Class viewController;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode pcode:(NSString *)pcode  domain:(NSString *)domain NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode pcode:(NSString *)pcode  domain:(NSString *)domain viewController:(Class)viewController;
- (instancetype)initWithTitle:(NSString *)title embedCode:(NSString *)embedCode pcode:(NSString *)pcode  domain:(NSString *)domain viewController:(Class)viewController embedTokenGenerator:(id<OOEmbedTokenGenerator>)embedTokenGenerator;

@end
