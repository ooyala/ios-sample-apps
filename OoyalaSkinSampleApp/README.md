# OoyalaSkinSampleApp

This Sample app demonstrates integration with the Ooyala Skin SDK, the new UI for the OoyalaPlayer

# How to try the Sample Application

To try the new Sample Application, simply open the xcodeproj and run the application.

# How to Perform Simple Customizations to the Sample Application

### Modify the Skin Config

This will allow you to modify some of the configurations allowed by the Skin Config.  For more information, check out the [skin-config repo](https://github.com/ooyala/skin-config) README.

1. Open OoyalaSkinSampleApp.xcodeproj
2. Modify skin-config/skin.json
3. Re-run the application

### Add your own test assets to the Sample App

Just like all other sample applications, you can modify the ListViewController with your own embed codes to see how your videos work.  Note that your assets may require additional configuration of the application to work.

1. Open OoyalaSkinSampleApp.xcodeproj
2. Modify OoyalaSkinSampleApp/players/BasicTestsListViewController.m
3. Re-run the application


# How to Update an Existing Application with the iOS Skin

By this point, you should have an understanding of how the iOS Skin works. Here are the steps to integrate the iOS Skin into your own application.

If you'd like to take another extra step, try _following these steps to update the BasicPlaybackSampleApp_ as proof of the process

1. Download [OoyalaSDK-iOS](http://support.ooyala.com/resources/mobile-and-client-sdks), which contains:
    * Ooyala SDK (link binary with this library)
2. Download [OoyalaSkinSDK-iOS](https://ooyala.box.com/ios-skin-prerelease), which contains:
    * __NOTE:__ the framework in the download link will always point to the most up to date commit in the 'stable' branch (when the branch is created).
    * iOS Skin SDK (link binary with this library)
    * Alice font (Add to bundle. Then in Info.plist, add "alice.ttf" to "Fonts Provided by Application")
    * (temporary) FontAwesome font (Add to bundle. Then in Info.plist, add "fontawesome-webfont.ttf" to "Fonts Provided by Application")
    * Default localization files (Add to app bundle)
    * Default skin-config.json (Add to app bundle)
    * main.jsbundle (Add to app bundle)
3. Link JavascriptCore library to your binary
4. In Build Settings, ensure the Other Linker Flag "-ObjC" is enabled

5. Modify your PlayerViewController to use the new OOSkinViewController

    Replace the OoyalaPlayerViewController in your application to this new class.  Below is an example of what this could look like

        NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main"
                                                        withExtension:@"jsbundle"];
        OOSkinOptions *skinOptions = [[OOSkinOptions alloc] initWithDiscoveryOptions:nil
                                                                      jsCodeLocation:jsCodeLocation
                                                                      configFileName:@"skin"
                                                                     overrideConfigs:nil];
        self.skinController = [[OOSkinViewController alloc] initWithPlayer:ooyalaPlayer
                                                               skinOptions:skinOptions
                                                                    parent:_videoView
                                                             launchOptions:nil];
        [self addChildViewController:self.skinController];

5. Double Check your app.  The following is a list of all known requirements for Ooyala Skin SDK to work in your application

    - Ooyala SDK
        * Should be linked
    - Ooyala Skin SDK
        * Should be linked
        * SDK Version in the Skin package's VERSION file should match the VERSION file in the Ooyala SDK
    - Alice Font
        * Should be bundled
        * Should be part of Info.plist
    - FontAwesome Font
        * Should be bundled
        * Should be part of Info.plist
    - Localization Files (en.json, zh.json, etc.)
        * Should be bundled
    - skin-config.json
        * Should be bundled
    - main.jsbundle
        * Should be bundled
    - Ojbective-C code
        * Should use the OOSkinViewController
        * Should use main.jsbundle as the jsCodeLocaiton
    - JavascriptCore
        * Should be linked
    - Other Linker Flags
        * Should have -ObjC

