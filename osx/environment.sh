#!/bin/bash

# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" == darwin* ]] || return 1

heading 'Configuring  OS X'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Bash                                                                        #
###############################################################################

# Change the default shell to bash v4
if [ -e "$(brew --prefix bash)/bin/bash" ] && ! grep "$(brew --prefix bash)/bin/bash" /etc/shells; then
  echo "$(brew --prefix bash)/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "$(brew --prefix bash)/bin/bash";
  info 'Default shell changed to bash v4'
fi;

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Set appearance to dark
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Set UI Chrome Appearance to Graphite
/usr/bin/defaults write -g 'AppleAquaColorVariant' -int 6
# Set highlight color to graphite
defaults write NSGlobalDomain AppleHighlightColor -string "0.780400 0.815700 0.858800"

# Set highlight color to green
#defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

 # Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Menu bar: hide the Time Machine, Volume, User, and Bluetooth icons
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
	defaults write "${domain}" dontAutoLoad -array \
		"/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
		"/System/Library/CoreServices/Menu Extras/Volume.menu" \
		"/System/Library/CoreServices/Menu Extras/User.menu"
done
defaults write com.apple.systemuiserver menuExtras -array \
	"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
	"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
	"/System/Library/CoreServices/Menu Extras/Battery.menu" \
	"/System/Library/CoreServices/Menu Extras/Clock.menu"

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "us"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
defaults write NSGlobalDomain AppleMetricUnits -bool false

 # Set the timezone; see `systemsetup -listtimezones` for other values
systemsetup -settimezone "America/Chicago" > /dev/null

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Users                                                                       #
###############################################################################

# Hide puppet from the login screen
sudo defaults write /Library/Preferences/com.apple.loginwindow HiddenUsersList -array-add puppet

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Map `click or tap with two fingers` to the secondary click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 0

# Enable 3-finger drag. (Moving with 3 fingers in any window "chrome" moves the window.)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

### Move content in the direction of finger movement when scrolling or navigating (natural)
defaults write -g com.apple.swipescrolldirection -bool true

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Enable dragging a window by clicking anywhere within it while holding ctrl-opt-cmd: https://twitter.com/nibroc/status/963088893758259200
defaults write -g NSWindowShouldDragOnGesture YES

# Use all F1, F2, etc. keys as standard function keys
defaults write -g com.apple.keyboard.fnState -bool true

### Launchpad: no
/usr/bin/defaults write com.apple.dock 'showLaunchpadGestureEnabled' -bool false

### Show Desktop: yes
/usr/bin/defaults write com.apple.dock 'showDesktopGestureEnabled' -bool true

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

### Modifier Keys… > Apple Internal Keyboard / Trackpad > Caps Lock ( ⇪) Key: No Action
defaults -currentHost write -g 'com.apple.keyboard.modifiermapping.1452-566-0' -array '<dict><key>HIDKeyboardModifierMappingDst</key><integer>-1</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>'

### Modifier Keys… > Apple Keyboard [External] > Caps Lock ( ⇪) Key: No Action
defaults -currentHost write -g 'com.apple.keyboard.modifiermapping.1452-544-0' -array '<dict><key>HIDKeyboardModifierMappingDst</key><integer>-1</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>'

# Disable Mission Control Keyboard Shortcut since it conflicts with WebStorm (ctrl + up)
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 32 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 34 "<dict><key>enabled</key><false/></dict>"

# Disable Application Windows Keyboard Shortcut since it conflicts with WebStorm (ctrl + down)
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 33 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 35 "<dict><key>enabled</key><false/></dict>"

###############################################################################
# Finder                                                                      #
###############################################################################

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Select text in a Quick Look preview window
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array ""

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

### Don't Show Dashboard as a space
/usr/bin/defaults write com.apple.dock 'dashboard-in-overlay' -bool false

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

# Disable two-finger swipe gestures
defaults write com.google.Chrome.plist AppleEnableSwipeNavigateWithScrolls -bool FALSE

###############################################################################
# iTunes                                                                      #
###############################################################################

# Stop Apple Photos from Auto Launching when a phone is plugged into USB
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES

###############################################################################
# Git                                                                         #
###############################################################################

# Make the diff-highlight script available for diffs, etc
ln -sf "$(brew --prefix git)/share/git-core/contrib/diff-highlight/diff-highlight" ~/bin/diff-highlight

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

#TERM_PROFILE='Travi xterm-256color';
#CURRENT_PROFILE="$(defaults read com.apple.terminal 'Default Window Settings')";
#if [ "${CURRENT_PROFILE}" != "${TERM_PROFILE}" ]; then
    #open "$HOME/.files/osx/Travi.terminal";
    #sleep 1; # Wait a bit to make sure the theme is loaded
    #defaults write com.apple.terminal 'Default Window Settings' -string "${TERM_PROFILE}";
    #defaults write com.apple.terminal 'Startup Window Settings' -string "${TERM_PROFILE}";
    #killall "Terminal"
#fi

osascript <<EOD

tell application "Terminal"

    local allOpenedWindows
    local initialOpenedWindows
    local windowID
    set themeName to "Travi"

    (* Store the IDs of all the open terminal windows. *)
    set initialOpenedWindows to id of every window

    (* Open the custom theme so that it gets added to the list
        of available terminal themes (note: this will open two
        additional terminal windows). *)
        do shell script "open '$HOME/.files/osx/" & themeName & ".terminal'"

    (* Wait a little bit to ensure that the custom theme is added. *)
    delay 1

    (* Set the custom theme as the default terminal theme. *)
    set default settings to settings set themeName

    (* Get the IDs of all the currently opened terminal windows. *)
    set allOpenedWindows to id of every window

    repeat with windowID in allOpenedWindows

        (* Close the additional windows that were opened in order
            to add the custom theme to the list of terminal themes. *)
        if initialOpenedWindows does not contain windowID then
            close (every window whose id is windowID)

        (* Change the theme for the initial opened terminal windows
            to remove the need to close them in order for the custom
            theme to be applied. *)
        else
            set current settings of tabs of (every window whose id is windowID) to settings set themeName
        end if

    end repeat

end tell

EOD

###############################################################################
# Transmission                                                                #
###############################################################################
# Use `~/Documents/Torrents` to store incomplete downloads
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Documents/Torrents"

# Don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool false

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false
# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Dock" "Finder" "Safari" "SystemUIServer" "cfprefsd"; do
	killall "${app}" > /dev/null 2>&1
done

echo "Done. Note that some of these changes require a logout/restart to take effect."
