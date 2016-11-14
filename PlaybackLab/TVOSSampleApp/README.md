# TVOSSampleApp

This App is a work-in-progress project which demostrates the feature capabilities of our tvOS integration.

While our tvOS integration cannot use the same Skin UI as our Android and iOS libraries, our tvOS integration uses an open sourced UI that is in the [native-skin github repo](https://github.com/ooyala/native-skin).

This app requires the tvOS Pulse SDK library to run.  In order to get this you must:

1. Go to [help.ooyala.com/downloads](help.ooyala.com/downloads)
1. Download "tvOS 2.x SDK framework"
1. Take the resulting Pulse-tvos.framework and paste it in `TVOSSampleApp/VendorLibraries
1. Rename Pulse-tvos.framework to Pulse.framework
1. Within the Pulse.framework folder, Rename Pulse-tvos to Pulse
1. Run the application
