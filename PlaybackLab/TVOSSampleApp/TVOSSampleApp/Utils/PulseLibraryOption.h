//
//  PulseLibraryOption.h
//  TVOSSampleApp
//
//  Created by Steve on 2016-10-12.
//  Copyright © 2016 Ooyala. All rights reserved.
//

#include <Foundation/Foundation.h>

@interface PulseLibraryOption : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *embedCode;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSArray *midrollPositions;

- (instancetype) initWithTitle:(NSString*)title embedCode:(NSString*)embedCode category:(NSString*)category tags:(NSArray*)tags midrollPositions:(NSArray*)midrollPositions;
@end
