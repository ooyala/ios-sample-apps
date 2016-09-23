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

For More detailed information on how to update an existing application with the iOS Skin, consult either the Ooyala Support documentation, or the [dev-docs in the native-skin repo](https://github.com/ooyala/native-skin/blob/stable/dev_docs/README-ios.md)
