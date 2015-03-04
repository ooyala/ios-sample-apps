//
//  Util.m
//  AdobePassDemoApp
//
//  Created by Chris Leonavicius on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Util.h"
#import "NSUtils.h"

@implementation Util

+ (NSString *)signRequestorId:(NSString *)requestorId keystore:(NSString *)keyStoreName pass:(NSString *)keyStorePass {
  uint8_t *signedBytes = NULL;
  SecKeyRef privateKey = NULL;
  NSString *signedRequestorId = nil;
  OSStatus status;

  NSString *thePath = [[NSBundle mainBundle] pathForResource:keyStoreName ofType:@"p12"];
  NSData *PKCS12Data = [NSData dataWithContentsOfFile:thePath];
  CFDataRef inPKCS12Data = (__bridge CFDataRef)PKCS12Data;
  CFStringRef password =  (__bridge CFStringRef)keyStorePass;

  const void *keys[] = { kSecImportExportPassphrase };
  const void *values[] = { password };
  CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
  CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
  status = SecPKCS12Import(inPKCS12Data, optionsDictionary, &items);

  if (status == errSecSuccess) {
    CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items, 0);
    SecIdentityRef outIdentity = (SecIdentityRef)CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemIdentity);

    // get the private key
    status = SecIdentityCopyPrivateKey (outIdentity, &privateKey);
    if (status != errSecSuccess) {
      NSLog(@"Failed to extract the private key from the keystore.");
    } else {
      // get the maximum size of the digital signature
      size_t signedBytesSize = SecKeyGetBlockSize(privateKey);;

      // malloc a buffer to hold signature
      signedBytes = malloc(signedBytesSize * sizeof(uint8_t));
      memset((void *)signedBytes, 0x0, signedBytesSize);

      // sign data
      const char* nonce = [requestorId UTF8String];
      status = SecKeyRawSign(privateKey,
                             kSecPaddingPKCS1,
                             (const uint8_t*)nonce,
                             strlen(nonce),
                             signedBytes,
                             &signedBytesSize);

      if (status == errSecSuccess) {
        NSData *encryptedBytes = [NSData dataWithBytes:(const void *)signedBytes
                                                length:signedBytesSize];

        signedRequestorId = [NSUtils base64Encoding:encryptedBytes];
      } else {
        NSLog(@"Cannot sign the device id info: failed obtaining the signed bytes.");
      }
    }
  } else {
    NSLog(@"Cannot sign the device id info: failed importing keystore.");
    NSLog(@"This is the expected behavior on the iOS 4.3 Simulator");
  }

  // clean-up
  if (items) {
    CFRelease(items);
  }

  if (privateKey) {
    CFRelease(privateKey);
  }

  if (signedBytes) {
    free(signedBytes);
  }

  if (optionsDictionary) {
    CFRelease(optionsDictionary);
  }

  return signedRequestorId;
}

+ (NSString *)htmlEntityEncode:(NSString *)string {
  return [string stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
}

+ (NSString *)urlEncode:(NSString *)str {
  return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)str, NULL, (__bridge CFStringRef)@"|!*'\"();:@&=+$/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
}

@end
