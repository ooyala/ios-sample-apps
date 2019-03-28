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
  // 2-1 Check if button for pip defined and configured
  NSDictionary *buttonsDict = self.skinConfig[@"buttons"];
  NSArray<NSDictionary *> *buttonsMobile = buttonsDict[@"mobileContent"];
  BOOL foundFlag = false;
  for (NSDictionary *nextDict in buttonsMobile) {
    NSString *buttonName = nextDict[@"name"];

    if ([buttonName isEqualToString:@"pipButton"]) {
      foundFlag = true;
      break;
    }
  }
  
  // 2-2 Check if icon for button defined
  NSDictionary *iconsDict = self.skinConfig[@"icons"];
  NSDictionary *pipInButtonIcon = iconsDict[@"pipInButton"];
  NSDictionary *pipOutButtonIcon = iconsDict[@"pipOutButton"];
  
  // 3 - then
  XCTAssertTrue(foundFlag, @"❌ pipInButton dictionary is not found");
  XCTAssertGreaterThan(pipInButtonIcon.count, 0, @"❌ pipInButtonIcon dictionary can't be empty");
  XCTAssertGreaterThan(pipOutButtonIcon.count, 0, @"❌ pipOutButtonIcon dictionary can't be empty");
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
