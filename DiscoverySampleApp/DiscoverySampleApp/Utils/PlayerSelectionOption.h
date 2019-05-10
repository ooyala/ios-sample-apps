//
//  PlayerSelectionOption.h
//  DiscoverySampleApp
//
//  Created on 15/04/19.
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

@import Foundation;

@interface PlayerSelectionOption : NSObject

@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *nib;
@property (nonatomic) NSString *playerDomain;
@property (nonatomic) NSString *pcode;
@property (nonatomic) Class viewController;

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                        pcode:(NSString *)pcode
                 playerDomain:(NSString *)playerDomain
               viewController:(Class)viewController
                          nib:(NSString *)nib;
@end
