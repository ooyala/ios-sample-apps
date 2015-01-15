

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
5. Drag the project from Xcode's Sidebar into the Sample App Workspace's Xcode Sidebar
6. Close both XCode windows, reopen the Sample App Workspace window
7. In the CompleteSampleApp's target's build phases, Add your New Sample App's Source Code Library to your "Link Binary with Libraries" phases
8. open up the Lists/CompleteSampleAppViewController.
9. Add your new project as a ListSelectionOption to the List generation method

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
