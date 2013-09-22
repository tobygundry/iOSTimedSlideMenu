iOSTimedSlideMenu
=================

iOSTimedSlideMenu turns a View into a tab on the side of the screen that users can 
drag causing it to fully expand. The menu is displayed for a length of time while 
a progress indicator retracts back toward the side of the screen, when the progress 
indicator fully retracts, the menu returns to its original tab state.

![Screenshot 1](/Screenshots/screenshot-1.png "Screenshot 1")
![Screenshot 2](/Screenshots/screenshot-2.png "Screenshot 2")

Setup
=====

Clone the repository at https://github.com/tobygundry/iOSTimedSlideMenu and drag
the iOSTimedSlideMenu Xcode project into your project.

In your project, in the Build Phases tab of your target, add iOSTimedSlideMenu 
to your target dependencies, and libiOSTimedSlideMenu.a to Link Binary With 
Libraries.

Set the following linker flags in Build Settings:

1.  -ObjC
2.  -all_load

Include TimedSlideMenu.h in the View Controller where you want to use it:

\#import \<iOSTimedSlideMenu/TimedSlideMenu\.h\>

Usage
=====

Create a view on the screen that fills the width of the screen, this view should
be exactly as you want it to be seen when the menu is fully expanded.

Change the type of the view to TimedSlidedMenu, when the App is run, the view
will be hidden with only the tab shown

To change the menu to the right side:
-------------------------------------

Create a reference to your TimedSlideMenu in your view controller from IB, i.e.

IBOutlet TimedSlideMenu *timedSlideMenu;

Link the TimedSlideMenu to the timedSlideMenu reference, and call:

[timedSlideMenu setPosition:RightPosition];

iOS Timed Slide Menu can't be used with constraints, after setting a view to be 
of type TimedSlideMenu, unselect 'Use Autolayout'.

License
=======
iOSTimedSlideMenu is licensed under [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)