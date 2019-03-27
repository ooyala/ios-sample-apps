//
//  ContentTests.m
//  PictureInPictureSampleAppTests
//
//  Copyright © 2019 Ooyala, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ContentTests : XCTestCase

@property (nonatomic) NSDictionary *skinConfig;

@end

@implementation ContentTests

- (void)setUp {
  self.skinConfig = [ContentTests getTestDictionary:@"skin.json"];
}

- (void)tearDown {
  self.skinConfig = nil;
}

- (void)testSkinConfigJson {
  
  // 1 - given
  
  // 2 - when
  
  // 3 - then
  XCTAssertGreaterThan(self.skinConfig.count, 0, @"❌ skin.json can't be empty");
}

- (void)testSkinPiPButtons {
  
  // 1 - given
  
  // 2 - when
  NSDictionary *iconsDict = self.skinConfig[@"icons"];
  NSDictionary *pipInButton = iconsDict[@"pipInButton"];
  NSDictionary *pipOutButton = iconsDict[@"pipOutButton"];
  
  // 3 - then
  XCTAssertGreaterThan(pipInButton.count, 0, @"❌ pipInButton can't be empty");
  XCTAssertGreaterThan(pipOutButton.count, 0, @"❌ pipOutButton can't be empty");
}

+ (NSDictionary *)getTestDictionary:(NSString *)file {
  NSError *jsonParsingError = nil;
  
  NSString *filePath = [[NSBundle mainBundle] pathForResource:file ofType:nil];
  NSData *data = [NSData dataWithContentsOfFile:filePath];
  
  NSObject *obj = [NSJSONSerialization JSONObjectWithData:data
                                                  options:0
                                                    error:&jsonParsingError];
  
  if (jsonParsingError != nil || ![obj isKindOfClass:NSDictionary.class]) {
    return nil;
  }
  
  return (NSDictionary *)obj;
}

@end
