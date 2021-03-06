//
//  TimedSlideMenu.h
//  iOSTimedSlideMenu
//
//  Created by Toby Gundry on 12/09/13.
//  Copyright (c) 2013 iOSTimedSlideMenu. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ProgressIndicator.h"
#import "DragTab.h"
#import "Position.h"

@interface TimedSlideMenu : UIView
{
  CGRect originalFrame;             // The original frame as set in IB
  
  float initialTouchX;              // Where the initial touch occured on drag
  
  BOOL isExpanded;                  // Flag for menu being full expended
  
  enum TabPosition tabPosition;
}

@property (nonatomic, retain) DragTab *dragTab;
@property (nonatomic, retain) ProgressIndicator *progress;

@property (nonatomic) float cornerRadius;

@property (nonatomic) float visibleTime;
@property (nonatomic) float dragThreshold;

// Set the position where the drag tab appears LeftPosition|RightPosition
- (void)setPosition:(enum TabPosition)position;

// Expand the menu from its tabbed position to its original position
- (void)expandMenu;

// Retract the menu from its original position to its tabbed position
- (void)retractMenu;

// Reset the TimedSlideMenu back to its original unretracted position
- (void)reset:(id)sender;

@end
