//
//  ProgressIndicator.h
//  iOSTimedSlideMenu
//
//  Created by Toby Gundry on 14/09/13.
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
#import "Position.h"

@interface ProgressIndicator : UIViewController
{
  UIView *superview;  // The TimedSlideMenu the ProgressIndicator belongs to
  
  enum TabPosition tabPosition;
  
  float decreaseSpeed;
}

// The ProgressBar will be created using the dimensions from the TimedSlideMenu
- (id)initWithSuperview:(UIView *)view
               position:(enum TabPosition)pos
                  speed:(float)speed;

@end
