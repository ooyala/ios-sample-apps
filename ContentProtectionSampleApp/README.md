#Content Protection Sample App

The app is meant to demonstrate how to implement some key integrations around Content Protection features supported by Ooyala.

*NOTE* This application's test cases will not run by default. To run, you will need to configure your specific test case based on the PlayerViewController you are using

## OoyalaPlayerTokenPlayerViewController

You will need: 
1. An embed code/content ID from your provider (set in the ListViewControler)
1. Your Provider code (PCode) (set in the ListViewControler)
1. Your user's API Key and Secret (set in the OoyalaPlayerTokenViewController

This Player will demonstrate how to generate a client-side Ooyala Player Token, and pass it into the Ooyala Player. This will satisfy the needs to sucessfully authorize, assuming your asset has OPT enabled and all other restrictions pass

*NOTE* It is not safe to store your API Secret in your code, even just in git! This Player is designed to show you how to debug using clent side tokens, and show you how to use OPTs with the Ooyala Player. You will likely need to create a service that generates and signs OPTs serverside, and then provides them to your client applications, 

## FairplayPlayerViewController

You need the same information as in the OoyalaPlayerTokenPlayerViewController, however there are some code changes.

You need to create a SecureURLGenerator, and pass that in as an Option into your OoyalaPlayer. This secure URL Generator is used to sign the license request that is necessary for Fairplay playback 
