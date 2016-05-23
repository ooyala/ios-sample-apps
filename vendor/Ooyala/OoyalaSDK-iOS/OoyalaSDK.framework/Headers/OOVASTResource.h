//
//  OOVASTResource.h
//  OoyalaSDK
//
//  Copyright © 2016 Ooyala, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Type) {
  TypeNone,
  TypeStatic,
  TypeIFrame,
  TypeHTML
};

@interface OOVASTResource : NSObject

@property (readonly, nonatomic) Type type;
@property (readonly, nonatomic, strong) NSString *uri;
@property (readonly, nonatomic, strong) NSString *mimeType;

- (id)initWithType:(Type)type mimeType:(NSString *)mimeType uri:(NSString *)uri;
- (NSString *)typeToStr:(Type)type;

@end
