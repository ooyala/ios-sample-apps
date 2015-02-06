/**
 * @file       OOUIUtils.m
 * @brief      Implementation of OOUIUtils
 * @details    OOUIUtils.m in OoyalaSDK
 * @date       1/20/12
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */


#import "OOUIUtils.h"

@implementation OOUIUtils

+(void) doSafeGStateBlock:(void(^)(CGContextRef))block {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState( context );
  block( context );
  CGContextRestoreGState( context );
}

+ (UIColor *)colorByDarkening:(UIColor*)color by:(float)factor {
	// oldComponents is the array INSIDE the original color
	// changing these changes the original, so we copy it
	CGFloat *oldComponents = (CGFloat *)CGColorGetComponents([color CGColor]);
	CGFloat newComponents[4];
	unsigned long numComponents = CGColorGetNumberOfComponents([color CGColor]);
	switch (numComponents)
	{
		case 2:
		{
			//grayscale
			newComponents[0] = oldComponents[0]*factor;
			newComponents[1] = oldComponents[0]*factor;
			newComponents[2] = oldComponents[0]*factor;
			newComponents[3] = oldComponents[1];
			break;
		}
		case 4:
		{
			//RGBA
			newComponents[0] = oldComponents[0]*factor;
			newComponents[1] = oldComponents[1]*factor;
			newComponents[2] = oldComponents[2]*factor;
			newComponents[3] = oldComponents[3];
			break;
		}
	}

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);

	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);

	return retColor;
}

+ (UIImage *)imageFromBase64String: (NSString *)string
{
  unsigned long ixtext, lentext;
  unsigned char ch, inbuf[4] = {}, outbuf[3];
  short i, ixinbuf;
  Boolean flignore, flendtext = false;
  const unsigned char *tempcstring;
  NSMutableData *theData;

  if (string == nil)
  {
    return [NSData data];
  }

  ixtext = 0;

  tempcstring = (const unsigned char *)[string UTF8String];

  lentext = [string length];

  theData = [NSMutableData dataWithCapacity: lentext];

  ixinbuf = 0;

  while (true)
  {
    if (ixtext >= lentext)
    {
      break;
    }

    ch = tempcstring [ixtext++];

    flignore = false;

    if ((ch >= 'A') && (ch <= 'Z'))
    {
      ch = ch - 'A';
    }
    else if ((ch >= 'a') && (ch <= 'z'))
    {
      ch = ch - 'a' + 26;
    }
    else if ((ch >= '0') && (ch <= '9'))
    {
      ch = ch - '0' + 52;
    }
    else if (ch == '+')
    {
      ch = 62;
    }
    else if (ch == '=')
    {
      flendtext = true;
    }
    else if (ch == '/')
    {
      ch = 63;
    }
    else
    {
      flignore = true;
    }

    if (!flignore)
    {
      short ctcharsinbuf = 3;
      Boolean flbreak = false;

      if (flendtext)
      {
        if (ixinbuf == 0)
        {
          break;
        }

        if ((ixinbuf == 1) || (ixinbuf == 2))
        {
          ctcharsinbuf = 1;
        }
        else
        {
          ctcharsinbuf = 2;
        }

        ixinbuf = 3;

        flbreak = true;
      }

      inbuf [ixinbuf++] = ch;

      if (ixinbuf == 4)
      {
        ixinbuf = 0;

        outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
        outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
        outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);

        for (i = 0; i < ctcharsinbuf; i++)
        {
          [theData appendBytes: &outbuf[i] length: 1];
        }
      }

      if (flbreak)
      {
        break;
      }
    }
  }

  return [UIImage imageWithData:theData];
}

+ (BOOL)isIpad {
  return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+ (BOOL)is1xDensity {
  return [[UIScreen mainScreen] scale] == 1.0;
}

@end
