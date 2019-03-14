# PictureInPictureSampleApp

This is a sample app showing the current state of the Picture-In-Picture (PIP) functionality.
This only works when you are using a device that supports PIP (Most new iPads)

The important parts are:

# Maintaining a global OoyalaPlayer

The PIP layer only exists for the life of the OoyalaPlayer.  Most of our samples create an OoyalaPlayer in the PlayerVC.

# Required steps for using PictureInPicture
* Create an instance of OOOptions and set the flag to true
```
OOOptions *options = [OOOptions new];
options.enablePictureInPictureSupport = YES;
```
* Create an instance of either `OODefaultPlayerInfo` or `OODefaultAudioOnlyPlayerInfo` (this depends on your asset type - see the sample code snippets below) and set it to property playerInfo in the same `OOOptions`
```
if (self.isAudioOnlyAsset) {
  options.playerInfo = [OODefaultAudioOnlyPlayerInfo new];
} else {
  options.playerInfo = [OODefaultPlayerInfo new];
}
```
* When creating `OOOoyalaPlayer`, use `-initWithPcode:domain:options:` and pass the `OOOptions` instance into the this method.
```
OOOoyalaPlayer *player = [[OOOoyalaPlayer alloc] initWithPcode:self.pcode domain:[[OOPlayerDomain alloc] initWithString:self.playerDomain] options:options];
```


# Calling togglePictureInPictureMode

To on/off Picture In Picture in Native-Skin-App, you need to call the provided OoyalaPlayer API

      [self.skinController.player togglePictureInPictureMode];

To on/off Picture In Picture in Native-App, there no additional code required, everything is implemented in OoyalaSDK.framework


# Implementing AVPictureInPictureControllerDelegate

To react to the PIP events, AVKit provides [AVPictureInPictureControllerDelegate](https://developer.apple.com/reference/avkit/avpictureinpicturecontrollerdelegate), which lets your application react before and after PIP is started or stopped.  Now it is part of the PictureInPictureSampleApp, and used for changing icon for button only if AVKit notify about changing of state.

You can set your PIP Delegate within your OOOptions object when intitializing your OOOoyalaPlayer:

    OOOptions *options = [OOOptions new];
    options.pipDelegate = self;

# Other Considerations
* Advertisements are not supported
* The sample does not handle multiple pcodes, so most assets will not playback
* Memory profiling has not been performed, so leaks may exist.  If you see a leak, feel free to file an issue
* If you have any feedback on the API or development issues, contact your CSM or Support with information
* Going into PIP, then into the ListView, then selecting the same video, the video should resume in normal view (or PIP), however right now the video will restart in normal view
* There are no icons for PIP-button for Native-Skin-App, that's why app uses existed icon (mute and replay) 
