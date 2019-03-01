# PictureInPictureSampleApp

This is a sample app showing the current state of the Picture-In-Picture (PIP) functionality.

There is no button in the direct UI of the application, only the functionality to enable the button to work.

The important parts are:

# Maintaining a global OoyalaPlayer

The PIP layer only exists for the life of the OoyalaPlayer.  Most of our samples create an OoyalaPlayer in the PlayerVC. In this app, we create the Player in the AppDelegate, and reference it in our PlayerVC.

# Calling togglePictureInPictureMode

To actually fire off Picture In Picture, you need to call the provided OoyalaPlayer API

    - (void) buttonAction {
        [self.skinController.player togglePictureInPictureMode];
    }

This only works when you are using a device that supports PIP (Most new iPads)

# Implementing AVPictureInPictureControllerDelegate

To react to the PIP events, AVKit provides [AVPictureInPictureControllerDelegate](https://developer.apple.com/reference/avkit/avpictureinpicturecontrollerdelegate), which lets your application react before and after PIP is started or stopped.  This is not part of the PictureInPictureSampleApp yet, but is necessary to open up the correct video View/ViewController before PIP is stopped.

You can set your PIP Delegate within your OOOptions object when intitializing your OOOoyalaPlayer:

    OOOptions *options = [OOOptions new];
    options.pipDelegate = self;

# Other Considerations
* Advertisements are not supported
* The sample does not handle multiple pcodes, so most assets will not playback
* Memory profiling has not been performed, so leaks may exist.  If you see a leak, feel free to file an issue
* If you have any feedback on the API or development issues, contact your CSM or Support with information
* Pressing the "return from PIP" button in the PIP frame needs to go back to the PlayerViewController, which does not exist right now
* Going into PIP, then into the ListView, then selecting the same video, the video should resume in normal view (or PIP), however right now the video will restart in normal view
