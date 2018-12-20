//
//  PulseLibraryOption.h
//  TVOSSampleApp
//
//  Created by Steve on 2016-10-12.
//  Copyright © 2016 Ooyala. All rights reserved.
//

@import Foundation;

@interface PulseLibraryOption : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *embedCode;
@property (nonatomic) NSString *category;
@property (nonatomic) NSArray *tags;
@property (nonatomic) NSArray *midrollPositions;

- (instancetype)initWithTitle:(NSString *)title
                    embedCode:(NSString *)embedCode
                     category:(NSString *)category
                         tags:(NSArray *)tags
             midrollPositions:(NSArray *)midrollPositions;

@end
