# Ooyala Player v4 Pulse SDK 2.x integration for iOS

This project demonstrates a simple video player that displays content using the Ooyala Player while displaying
ads using Ooyala Pulse.

This project is a sample intended **only** to give a brief introduction to the Pulse SDK and help developers get started with their iOS integration.

This is absolutely **not** intended to be used in production or to outline best practices, but rather a simplified way of developing your integration.


## Building

1. After cloning the project, download the Ooyala Ad Products iOS SDKs [here](http://support.ooyala.com/resources/mobile-and-client-sdks).
2. Copy the [required](VendorLibraries/README.md) framework files into the VendorLibraries folder of the project.
3. Open the project file in XCode.
4. Select the ```PulseSampleApp``` scheme
5. Build the project.


## Project structure

A [VideoLibraryViewController](PulseSampleApp/Lists/VideoLibraryViewController.m) shows a list of available videos along with [metadata](PulseSampleApp/Lists/VideoItem.h) about these videos. When a video is selected, it opens in a [PulseManagerViewController](PulseSampleApp/Players/PulseManagerViewController.m).

The PulseManagerViewController creates an OOOoyalaPlayer and then associates it with an instance of the OOPulseManager class from the OoyalaPulseIntegration framework. OOPulseManager will allow Ooyala Pulse ads to be shown for video content that is associated with a Videoplaza ad set in Backlot.

```
self.manager = [[OOPulseManager alloc] initWithPlayer:self.player];
self.manager.delegate = self;
```

When the OOPulseManager requires an ad session it will request one from its delegate, (PulseManagerViewController in the sample app). The delegate receives request settings and content metadata that are populated from Backlot, but has the opportunity to change them. For more information about these settings, refer to [Ooyala Ad Products SDK Parameter Reference](http://support.ooyala.com/developers/ad-documentation/oadtech/ad_serving/dg/integration_sdk_parameter.html).

```
- (id<OOPulseSession>)pulseManager:(OOPulseManager *)manager
             createSessionForVideo:(OOVideo *)video
                     withPulseHost:(NSString *)pulseHost
                   contentMetadata:(VPContentMetadata *)contentMetadata
                   requestSettings:(VPRequestSettings *)requestSettings
{
  // Set the correct pulse host and options
  [OOPulse setPulseHost:pulsehost
        deviceContainer:nil
           persistentId:nil];

  // Here we assume a landscape orientation for video playback
  requestSettings.width = (NSInteger)MAX(self.view.frame.size.width, self.view.frame.size.height);
  requestSettings.height = (NSInteger)MIN(self.view.frame.size.width, self.view.frame.size.height);

  // You should probably implement some way of determining the max
  // bitrate of ads to request.
  requestSettings.maxBitRate = [BandwidthChecker maxBitRate];

  return [OOPulse sessionWithContentMetadata:contentMetadata
                             requestSettings:requestSettings];
}
```

## Demo Pulse account

This integration sample uses the following Ooyala Pulse account:
```
https://pulse-demo.videoplaza.tv
```

This account is configured with a set of ad campaigns to help you test your Ooyala Pulse integration. Refer to the [content library](PulseSampleApp/library.json) used in this sample for useful tags and categories.


## Useful information

- [The Ooyala Pulse SDK documentation](http://pulse-sdks.ooyala.com/ios_2/latest/index.html)
- [Ooyala Ad Products SDK Parameter Reference](http://support.ooyala.com/developers/ad-documentation/oadtech/ad_serving/dg/integration_sdk_parameter.html)
- [Ooyala Player v4 Pulse Integration documentation](https://apidocs.ooyala.com/ios_mobilesdk/pulse_integration/html/index.html)
