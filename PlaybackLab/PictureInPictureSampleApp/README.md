# PictureInPictureSampleApp

This is a sample app showing the current state of the Picture-In-Picture (PIP) functionality.

There is no button in the direct UI of the application, only the functionality to enable the button to work.

The important parts are:

# Maintaining a global OoyalaPlayer

The PIP layer only exists for the life of the OoyalaPlayer.  Most of our samples create an OoyalaPlayer in the PlayerActivity. In this app, we create the Player in the AppDelegate, and reference it in our PlayerActivities.

# Calling togglePictureInPictureMode

To actually fire off Picture In Picture, you need to call the provided OoyalaPlayer API

    - (void) buttonAction {
        [self.skinController.player togglePictureInPictureMode];
    }

This only works when you are using a device that supports PIP (Most new iPads)


# Other Considerations
* Advertisements are not supported
* The sample does not handle multiple pcodes, so most assets will not playback
* Memory profiling has not been performed, so leaks may exist.  If you see a leak, feel free to file an issue
* If you have any feedback on the API or development issues, contact your CSM or Support with information

