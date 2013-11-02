#!/usr/bin/env bash -xe

export DROPBOX_ID=$1
export SCREENSHOT_PATH=~/Dropbox/Public/screenshots
export INSTALL="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $INSTALL

# ensure screenshots are stored in the right folder
mkdir -p $SCREENSHOT_PATH

chmod u+x dropbox-screenshots  # make sure it's executable

# the generated .plist file simply says "Whenever ~/Dropbox/Public/screenshots, launch dropbox-screenshot"
# launchd loads all scripts in ~/Library/LaunchAgents on startup
export LAUNCH_AGENT=~/Library/LaunchAgents/com.github.dergachev.dropbox-screenshots.plist
rm $LAUNCH_AGENT
while read LINE; do
  /usr/libexec/PlistBuddy -c "$LINE" $LAUNCH_AGENT 
done <<EOT
Add :Label string com.github.dergachev.dropbox-screenshots
Add :WatchPaths array
Add :WatchPaths:0 string $SCREENSHOT_PATH
Add :ProgramArguments array
Add :ProgramArguments:0 string $INSTALL/dropbox-screenshots
Add :ProgramArguments:1 string $DROPBOX_ID
EOT
# Add :StandardOutPath string $INSTALL/launchd.stdout.log
# Add :StandardErrorPath string $INSTALL/launchd.stderr.log

# launch this now, instead of next login; `launchctl unload ...` to unload script.
launchctl unload $LAUNCH_AGENT
launchctl load $LAUNCH_AGENT

# ensure OSX stores all screenshots in ~/Dropbox/Public/screenshots
defaults write com.apple.screencapture location $SCREENSHOT_PATH
killall SystemUIServer

# Misc commands:
#  launchctl list
#  launchctl getenv PATH
