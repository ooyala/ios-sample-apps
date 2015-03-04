Ooyala SDK for iOS Sample Apps
==================================

This is a repository of sample applications for the Ooyala SDK for iOS.

# Provided Sample Apps

Below is a short description of the sample applications provided in the repository.

## BasicPlaybackSampleApp

This application is designed to illustrate very basic video playback

## AdvancedPlaybackSampleApp

This application was designed to illustrate some advanced functionality you can add into a Player Activity through the OoyalaSDK.

## FreewheelSampleApp

This application was designed to illustrate how correctly configured Freewheel assets play back using the Ooyala SDK.

## IMASampleApp

This application was designed to illustrate how correctly configured Google IMA assets play back using the Ooyala SDK.

## OptionsSampleApp

This application was designed to illustrate how correctly configured Options assets play back using the Ooyala SDK.

## ContentProtectionSampleApp

This application was designed to illustrate various content protection methods that can be used by the Ooyala SDK.

## CompleteSampleApp

The CompleteSampleApp is a compilation of all of the other sample apps in the repo.  You must view this project through SampleApps.xcworkspace to run without modification

# Make commands

The different commands available for you:

## `make get-latest-rc`

`make get-latest-rc` will:

1. delete existing librarys in `vendor` folder
2. download the latest release candidate packages for the iOS SDK into the `vendor` folder
3. All applications will point to the newly updated vendor folder

## `make get-latest-release`

`make get-latest-release` will:

1. delete existing librarys in `vendor` folder
2. download the latest release package for the iOS SDK into the `vendor` folder
3. All applications will point to the newly updated vendor folder

# How to Create a New Sample App
1. Duplicate an originally existing sample app in Finder (use cp --preserve=links)
2. Open that newly copied app's .xcodeproj
3. Rename the project's:
  1. Project name
  2. Target names (both the App target and Source Library target)
  3. Folder names in Finder (You will have to fix the Xcode references to the folder)
  4. Group names in Xcode
  5. The ListsViewController
  6. The Text in Base.lproj/LaunchScreen.xib
  7. The Custom Class of the Master Scene's master View in Main.Storyboard
4. In the SampleApp Target's General tab, choose the plist for your sample app (The folder name was changed)
5. In the SampleappSource target's build phases, make sure that in the "CompileSources" step, your ListViewController and PlayerViewControllers are compiled into the library
6. Drag the project from Xcode's Sidebar into the Sample App Workspace's Xcode Sidebar
7. Close both XCode windows, reopen the Sample App Workspace window
8. In the CompleteSampleApp's target's build phases, Add your New Sample App's Source Code Library to your "Link Binary with Libraries" phases
9. open up the Lists/CompleteSampleAppViewController.
10. Add your new project as a ListSelectionOption to the List generation method


# To Add a New Vendor Library to your Sample App
1. Ensure the library is in the Vendor folder.
2. Symlink that library into the VendorLibraries folder of your sample app in Finder
3. Drag that symlink into the VendorLibraries group of your sample app in XCode
4. Symlink that library into the VendorLibraries folder of the CompleteSampleApp in Finder
5. Drag that symlink into the VendorLibraries group of the CompleteSampleApp in XCode
6. Reference some class from the library in CompleteSampleApp's AppDelegate ([someobject class]).  Without this, the library will not be linked

# How to Create a New View for a Player
1. Create the nib file in the <repo_root>/Shared/Views folder, with the file owner as the SampleAppPlayerViewController
2. Drag this file from Finder into the Shared/Views group in your sample app, as well as in the CompleteSampleApp.
3. When you need to add a new IBOutlet, add the IBOutlet to the SampleAppPlayerViewController
4. When you need a new IBAction, add the IBAction the the SampleAppPlayerViewController.h, and add a blank implementation into the .m file
5. Then you can reference that IBOutlet or override the IBAction method in your Player to use it.

# How to Create a New Test Case for an Existing Sample App
## If you need can reuse an existing PlayerViewController.
1. Go into the ListViewController of your sample app. 
2. Add a PlayerSelectionOption to the list of PlayerSelectionOptions that already exists there.

## If you need a new PlayerViewController
1. Create a new PlayerViewController class in your Players Xcode group (ensure the file goes into *SampleApp/*SampleApp/Players folder in Finder).  Either copy an existing player or create a new one.
2. Add the import into your ListViewController.
3. Reference the new PlayerViewController in one of the PlayerSelectionOptions in the ListViewController
4. You do not need to change anything in the CompleteSampleApp

TODO:
Check to see how this works with xcodebuild
Figure out Nibs, and how they can be shared yet usable.
