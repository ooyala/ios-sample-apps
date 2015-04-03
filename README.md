Ooyala SDK for iOS Sample Apps
==================================

# Introduction

This is a repository of sample applications for the Ooyala SDK for iOS. Here you can try a bunch of different examples of Ooyala Mobile SDK usage, and see the code required to perform these tasks.  

In order to be successful using these applications, you should have the following experience:

1. Experience with XCode, Objective-C, and iOS Development.
2. Understanding of the use case of Ooyala and Ooyala's Mobile SDKs. 

This repository is meant to be supplementary to our Developer Documentation.  Take a look at the docs here: http://support.ooyala.com/

# Getting Started

All applications in this repository should be automatically importable, compilable, and runnable.  A good place to start is to try the Basic Playback Sample App.

1. Clone this repository onto your computer: `git clone https://github.com/ooyala/ios-sample-apps.git`
1. Open the repository directory, and navigate to ios-sample-apps/BasicPlaybackSampleApp
1. Open BasicPlaybackSampleApp.xcodeproj
1. Navigate to android-sample-apps/BasicPlaybackSampleApp. Press Choose, or OK
1. Observe the target is set to "BasicPlaybackSampleApp". Select either a connected device or simulator to run on
1. Press the play button to run the application
1. When the application loads, you will have a list of videos to choose from.  Pick any of them to view video playback

# Complete Sample App

The Complete Sample App is a project that combines all of the sample apps in the repository into a single runnable application.  You can open ios-sample-apps/SampleApps.xcworkspace.  This workspace contains all of the sample apps, and a Complete Sample App.  If you select CompleteSampleApp as the target, You will be able to view all of the other sample apps through one application.

Note: Opening "CompleteSampleApp.xcodeproj" will not work, as it requires all of the other projects in the workspace.  


# Using the Sample App Repository for filing support issues

If you have a bug within your own application, the Sample App Repository is a great way to help isolate the issue to Ooyala code. we recommend the following steps.

1. Isolate the bug to the Ooyala Sample App repo.
    1. Clone the repository onto your computer
    1. Modify one of the sample apps as necessary to simulate your application's behavior.
1. If you were able to successfully isolate the issue to our sample app, provide us the repo with your changes
    1. Fork this repository into your own Github account.
    1. Make modifications to the code and push these changes to your fork.
    1. Provide the link to your fork when you create a ticket to Support

This is the absolute fastest way for Support and Engineering to reproduce without question, and solve your issues as fast as possible.
  
When reproducing in sample apps, you should *Never* commit your API Secret into any repository.  If you have done so accidentally, you should either force-remove that commit from your history, or contact Technical Support to reset your API Secret.

# Reporting bugs with the Sample App Repo

If you find issues with one of the examples, or find issues with video playback.  Please file a bug with Ooyala Support through the Ooyala Support Portal http://support.ooyala.com/.

If you find bugs around the sample app that are not about video playback (i.e. unable to compile or build), you can file an issue through Github. If you file a Github Issue, we reserve the right to redirect your issue to Ooyala Support.

# Notes When Starting your own Application

Be sure to use your own Provider Code in your Ooyala Player initialization.  If you fail to do so, your viewing analytics will be lost in the process. 

# Caveats

Not all of the Ooyala SDK's functionality is represented in this repository; We are constantly adding and updating, with the intention of demonstrating as many of our features as possible.  If you would like to see something added, speak to your Ooyala contact or Technical Support 

Some of the more complicated samples may not be playable out of the box. These samples usually require customer-specific information that cannot be simulated with a demo application

You should *Never* commit your API Secret into any repository.  If you have done so accidentally, you should either force-remove that commit from your history, or contact Technical Support to reset your API Secret

Our Sample App Repository is designed to be automatically updated as we release new versions.  Our repository uses a 'candidate' branch, which will be updated for every release candidate we create.  These candidates, and the git tags ending in 'RC#' are for testing, and not intended to be used for customer applications.  

We do not recommend testing on any branch that is not master. These branches are not verified to be working as expected.  

Thank you for reading!
