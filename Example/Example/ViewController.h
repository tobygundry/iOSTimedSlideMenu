//
//  ViewController.h
//  Example
//
//  Created by Toby Gundry on 16/09/13.
//  Copyright (c) 2013 iOSTimedSlideMenu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iOSTimedSlideMenu/TimedSlideMenu.h>

@interface ViewController : UIViewController
{
  IBOutlet TimedSlideMenu *leftMenu;
  IBOutlet TimedSlideMenu *rightMenu;
  
  IBOutlet UITextField *dragThreshold;
  IBOutlet UITextField *visibleTime;
}

- (IBAction)setDragThreshold:(id)sender;

@end
