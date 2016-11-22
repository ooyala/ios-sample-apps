DownloadToOwnSampleApp
==================================

To run this app, we assume you have an Apple developer account because you need to run the app in a real device with iOS 10 or above as downloading videos is supported from iOS 10. You should be familiar with provisioning profiles and signing of an app in development. Downloading videos is not supported in the iOS Simulator.

## Quick Start

1. After cloning the repository, open the `DownloadToOwnSampleApp.xcodeproj` file in Xcode.
1. Connect a device to your computer with iOS 10 or above.
1. In Xcode, run the app in the device that you connected. We assume you successfully signed your app for development.
1. The app contains a list of test assets that may be downloadable.
1. To start downloading click on the accessory button of the download you wish to download. You'll be prompted with a _Download_ alert. Tap on _Download_ to start downloading an asset.
1. When a download is in progress, you can cancel it by selecting the _Cancel_ option, after clicking the accessory button of asset being downloaded.
1. When a download has completed, you can delete the downloaded asset by selecting the _Delete_ option of the panel presented by the accessory button.
1. Tap on any of the assets (not the accessory button) to get to a player view with the selected asset.
1. Tap on the _Set Online Video_ button to play a regular online video coming from our servers.
1. You will be able to tap on the _Set Offline Video_ button, if you downloaded an asset. When you do, you will be able to play the downloaded asset.
  * Confirm this behavior by turning airplane mode on, meaning you have no Internet on your device. You should be able to playback an offline video without Internet now.

## App Architecture

The app uses the following classes provided by the _OoyalaSDK_:
* **OOAssetDownloadManager**: Downloads a single video asset. Needs an `OOAssetDownloadOptions` to initialize.
* **OOAssetDownloadOptions**: Provides information to `OOAssetDownloadManager` so it knows which asset to download.
* **OOEmbedTokenGenerator**: An instance of this protocol is used to enable our Ooyala Player Token (OPT) protection feature. This is necessary for assets using entitlements and Fairplay DRM protected assets. When downloading a Fairplay asset, you must provide an `OOEmbedTokenGenerator` instance to `OOAssetDownloadOptions` before creating an `OOAssetDownloadManager`.
* **OOAssetDownloadManagerDelegate**: Build a class implementing this protocol to know about the progress of a download. Remember setting the class as a delegate of `OOAssetDownloadManager`.
* **OOOoyalaPlayer**: The player we always provide to playback video.
* **OOOoyalaPlayerViewController**: Used to manage the `view` of the player.

On top of these classes, we built the provided sample app that you can find here. It uses all the functionality described in the objects above. Here are the important classes you want to check out:

* **AssetPersistenceManager**: This is a singleton object which manages multiple `OOAssetDownloadManager` objects. It means you can check this example to manage multiple downloads at the same time. This class is the `OOAssetDownloadManagerDelegate` for all the `OOAssetDownloadManager` objects, so you'll get notified here on the progress of a download. `AssetPersistenceManager` broadcasts notifications in the app so anyone interested can add itself as an observer of these notifications and act accordingly as the downloads progress.
* **AssetListViewController**: Manages the `UITableView` showing the assets of the app. Depending on the download state of each asset, it will show different options when tapping the accessory button of each cell. Options can be _Download_, _Cancel_, or _Delete_.
* **OptionTableViewCell**: An instance of each cell rendered in the `UITableView`. Each cell is an observer of the download notifications sent by `AssetPersistenceManager`, so the cell refreshes the UI when there's a new download state.
* **OptionsDataSource**: Defines the video assets in the app. This is the data that each cell in the `UITableView` will show, and the configuration the download and player objects will use.
* **PlayerSelectionOption**: Is the object containing all the information of a particular asset.
* **BasicEmbedTokenGenerator**: An example implementation of `OOEmbedTokenGenerator`. Some specifics should not be performed this way in a production app, because it is using an Ooyala's account API_KEY and API_SECRET that we discourage using this way. Everything done here using API_KEY and API_SECRET information should be performed securely in your own server and your app should be calling that server instead.
* **PlayerViewController**: Uses an `OOOoyalaPlayerViewController` to show a player view and playback the video. Here's where online or offline playback can happen. This object is an observer of the `AssetPersistenceManager` notifications, so it knows when an asset has been downloaded and can be played offline.

Make sure to check the documentation in code for each file. We explain in more detail what happens in each object.
