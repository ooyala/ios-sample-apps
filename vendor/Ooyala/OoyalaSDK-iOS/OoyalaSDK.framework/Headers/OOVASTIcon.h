//
//  VASTIcon.h
//  OoyalaSDK
//
//  Created by Yi Gu on 3/1/16.
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOTBXML.h"

typedef enum {
  Static,
  IFrame,
  HTML
} ResourceType;

@interface OOVASTIcon : NSObject

@property (readonly, strong, nonatomic) NSString *program;
@property (readonly, nonatomic) NSInteger width;
@property (readonly, nonatomic) NSInteger height;
@property (readonly, nonatomic) NSInteger xPosition;
@property (readonly, nonatomic) NSInteger yPosition;
@property (readonly, nonatomic) Float64 duration;
@property (readonly, nonatomic) Float64 offset;
@property (readonly, strong, nonatomic) NSString *resourceUrl;
@property (readonly, strong, nonatomic) NSString *creativeType;
@property (readonly, nonatomic, assign) ResourceType type;
@property (readonly, strong, nonatomic) NSString *apiFramework;
@property (readonly, strong, nonatomic) NSString *clickThrough;

@property (readonly, strong, nonatomic) NSMutableArray *clickTrackings;
@property (readonly, strong, nonatomic) NSMutableArray *viewTrackings;

- (id)initWithXML:(OOTBXMLElement *)xml;


@end
