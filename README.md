# Set Light and Dark Mode Wallpapers for iOS 13

This is a proof-of-concept app that allows you to set separate light and dark wallpapers, just like the Shortcuts app allowed, before it was removed.

This was achieved through reverse-engineering Apple's private frameworks. The relevant ones were: "SpringBoardFoundation.framework", and "SpringBoardUIServices.framework".

Basically the trick that took me forever to figure out was the missing private entitlement `com.apple.springboard.wallpaper-access`. Because that entitlement is required, this app can't be built and signed onto a real device, only the Simulator and Jailbroken devices :(

<img alt="App with light and dark wallpapers ready to be set" src="Set-Wallpaper-Screenshot.png" width="200">


## Installation Instructions (for jailbroken devices only):

I wasn't able to install this on a real device, as an ipa file. The only thing that seemed to work for me was to copy the .app into /Applications.

_I'm not responsible for anything bad that happens to your device. Only perform these steps if you know what you are doing. I'm just trying to share my work. You have been warned._

**In the following instructions please replace `Your-iPhone.local` with either your iPhone's name or IP address.**

Before doing these steps, install AppSync Unified from the https://cydia.akemi.ai/ repo in Cydia.

1. On your computer, unzip the downloaded release zip file containing the .app folder.

2. `scp` the .app folder into `/Applications` folder on your device, from your local computer. Run this command in the Terminal _(This is probably going to ask you for your password. By default, if you haven't changed it, it should be `alpine`)_:
	
	`scp -rp ~/Downloads/Set\ Wallpaper.app root@Your-iPhone.local:/Applications/`
	
3. SSH into your device, and chmod the .app directory to have correct permissions. Run these lines in the Terminal:

	`ssh root@Your-iPhone.local`
	`chmod -R g+w "/Applications/Set Wallpaper.app/"`
	
4. While still SSHed into your device, refresh your homescreen with the changes by running this line:

	`uicache`
	
5. Exit your SSH session by typing 
	
	`exit`
	
6. Check your homescreen, launch, have fun.

If you wish to uninstall Set Wallpaper in the future just ssh back into your device and run these lines:

  `rm -r /Applications/Set\ Wallpaper.app/`
  `uicache`
	
**Be very sure to copy the first line correctly, as you might blow away all your system applications, which would be very bad!**
