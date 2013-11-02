# dropbox-screenshots

OS X daemon and ruby script to have OSX screenshots automatically
go to Dropbox, and their public URL be copied to clipboard.

![](https://dl.dropbox.com/u/29440342/screenshots/YXKORVYG-2013.11.01-21-53-02.png)

Dropbox.app recently added the same feature, but our approach is better:

* clicking on notification opens the image in Preview.app, for easy annotations
* the copied URL links directly to the image (rather than a landing page),
  which allows embedding images in markdown.
* The generated image URL is renamed from `Screen Shot 2013-11-01 at 3.10.13 PM.png`
  to `KDJSAJNN-2013.11.01-15.10.13.png` which is shorter and harder to guess.
* on retina displays, screenshots are automatically resized to 50%

This was only tested on OSX 10.9, though should also work with 10.8.

## Installation

First, get your Dropbox user ID, as follows:

* In Finder, right-click on any file under `~/Dropbox/Public`
* choose "Dropbox > Copy Public Link". 
* You'll have a link in your clipboard like http://dl.dropbox.com/u/12345678/mycoolpic.jpg
* 12345678 is the user ID. 

<img src="https://dl.dropbox.com/u/29440342/screenshots/YCOJCG-Screen_Shot_2012.12.8-12.40.53.png" width="50%">

Having done this, simply run the following:

```
# install dependent terminal-notifier gem
which terminal-notifier || sudo gem install terminal-notifier

# get the code
git clone https://github.com/dergachev/dropbox-screenshots.git ~/code/dropbox-screenshots
cd ~/code/dropbox-screenshots

# run the installer
bash install.sh 12345678     # replace 12345678 with your dropbox user ID
```

## TODO

* Consider making a custom icon for notifications.
* Investigate error in /var/log/system.log: `Throttling respawn: Will start in 6 seconds`. 
  [Related thread](http://apple.stackexchange.com/questions/63482/can-launchd-run-programs-more-frequently-than-every-10-seconds)

## Dev notes

* https://developer.apple.com/library/mac/documentation/macosx/conceptual/bpsystemstartup/Chapters/CreatingLaunchdJobs.html
* http://paul.annesley.cc/2012/09/mac-os-x-launchd-is-cool/
* https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man5/launchd.plist.5.html
* https://github.com/adamyonk/dotfiles/blob/484c3498671c5f5a62a8bb4d287bc71adb70ba6a/bin/snapr
* https://github.com/adamyonk/dotfiles/blob/484c3498671c5f5a62a8bb4d287bc71adb70ba6a/system/launchagents/com.adamyonk.snapr.plist
