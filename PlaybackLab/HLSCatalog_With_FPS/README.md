# HLS Catalog with FPS: Using AVFoundation to play and persist HTTP Live Streams with FairPlay Streaming Content Protection

This sample demonstrates how to use the AVFoundation framework to play HTTP Live Streams hosted on remote servers as well as how to persist the HLS streams on disk for offline playback.

To learn more about FairPlay Streaming, see the FairPlay Streaming Programming Guide.

For additional information about AVAssetResourceLoader, see the AVAssetResourceLoader Class Reference:

https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVAssetResourceLoader_Class/

## Using the Sample

Build and run the sample on an actual device running iOS 10.0 or later using Xcode.  The APIs demonstrated in this sample do not work on the iOS Simulator.

This sample provides a list of HLS Streams that you can playback by tapping on the UITableViewCell corresponding to the stream.  If you wish to manage the download of an HLS stream such as initiating an AVAssetDownloadTask, canceling an already running AVAssetDownloadTask or deleteting an already downloaded HLS stream from disk, you can accomplish this by tapping on the accessory button on the UITableViewCell corresponding to the stream you wish to manage.

If you wish to add your own HLS streams to test with using this sample, you can do this by adding an entry into the Streams.plist that is part of the Xcode Project.  There are two important keys you need to provide values for:

__AssetNameKey__: What the display name of the HLS stream should be in the sample.

__AssetStreamPlaylistURL__: The URL of the HLS stream's master playlist.

If any of the streams you add are not hosted securely, you will need to add an Application Transport Security (ATS) exception in the Info.plist.  More information on ATS and the relevant plist keys can be found in the following article:

Information Property List Key Reference - NSAppTransportSecurity: <https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW33>

## Important Notes

Saving HLS streams for offline playback is only supported for VOD streams.  If you try to save a live HLS stream, the system will throw an exception. 

Currently there is a known issue with the NSURL returned as part of the AVAssetDownloadDelegate.urlSession(_:assetDownloadTask:didFinishDownloadingTo:). This URL will not be valid when your application's data containter changes as a result of rebuilding with Xcode.

## Main Files

__AssetPersistenveManager.swift__: 

- AssetPersistenveManager is the main class in this sample that demonstrates how to manage downloading HLS streams.  It includes APIs for starting and canceling downloads, deleting existing assets off the users device, and monitoring the download progress.

__AssetPlaybackManager.swift__:

- AssetPlaybackManager is the class that manages the playback of Assets in this sample using Key-value observing on various AVFoundation classes.

__AssetLoaderDelegate.swfit__:

- AssetLoaderDelegate is the class that manages responding to content key requests for FairPlay Streaming protected content.


## Requirements

### Build

Xcode 8.0 or later; iOS 10.0 SDK or later

### Runtime

iOS 10.0 or later.

Copyright (C) 2016 Apple Inc. All rights reserved.
