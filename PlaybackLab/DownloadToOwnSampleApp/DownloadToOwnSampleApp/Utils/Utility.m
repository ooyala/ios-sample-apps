//
//  Utility.m
//  DownloadToOwnSampleApp
//
//  Created on 11/23/17.
//  Copyright © 2017 Ooyala. All rights reserved.
//

#import "Utility.h"
#import "Reachability.h"

@implementation Utility

+(BOOL)shouldDownload {
  Reachability *reachability = [Reachability reachabilityForInternetConnection];
  NetworkStatus netStatus = [reachability currentReachabilityStatus];

  switch (netStatus) {
    case NotReachable: {
      return NO;
    }
    case ReachableViaWWAN: {
      return [[NSUserDefaults standardUserDefaults] boolForKey:@"use_cellular"];
    }
    case ReachableViaWiFi: {
      return YES;
    }
  }
  return NO;
}
@end
