//
//  OOVASTCompanionAds.h
//  OoyalaSDK
//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOTBXML.h"

typedef NS_ENUM(NSInteger, RequiredType) {
  RequiredTypeAll,
  RequiredTypeAny,
  RequiredTypeNone
};

@interface OOVASTCompanionAds : NSObject

- (id)initWithElement:(OOTBXMLElement *)element;

@property (readonly, nonatomic) RequiredType required;
@property (readonly, nonatomic, strong) NSMutableArray *companions;

@end
