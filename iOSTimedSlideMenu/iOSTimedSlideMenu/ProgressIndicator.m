//
//  ProgressIndicator.m
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

#define BAR_HEIGHT  3.0f
#define BAR_OPACITY 0.7f
#define EXPAND_X    0.0f
#define RETRACT_X   0.0f

#import "ProgressIndicator.h"

@implementation ProgressIndicator

- (id)initWithSuperview:(UIView *)view
               position:(enum TabPosition)position
                  speed:(float)speed
{
    if (self = [super init])
    {
      superview = view;
      tabPosition = position;
      decreaseSpeed = speed;
    }
  
    return self;
}

- (void)loadView
{
  self.view = [[UIView alloc] init];
  
  float w = superview.frame.size.width;
  float h = BAR_HEIGHT;
  float x = EXPAND_X;
  float y = superview.frame.size.height - h;
  
  self.view.frame = CGRectMake(x, y, w, h);
  self.view.backgroundColor = [UIColor whiteColor];
  self.view.layer.opacity = BAR_OPACITY;
  
  [self animateProgressIndicator];
}

- (void)animateProgressIndicator
{
  [UIView animateWithDuration:decreaseSpeed
                   animations:^ {
                     [self setProgressRetractFrame];
                   }
                   completion:^ (BOOL complete) {
                     [self.view removeFromSuperview];
                   }];
}

- (void)setProgressRetractFrame
{
  if(tabPosition==LeftPosition)
    [self setLeftRetractFrame];
  else
    [self setRightRetractFrame];
}

- (void)setLeftRetractFrame
{
  self.view.frame = CGRectMake(self.view.frame.origin.x,
                               self.view.frame.origin.y,
                               RETRACT_X,
                               self.view.frame.size.height);
}

- (void)setRightRetractFrame
{
  self.view.frame = CGRectMake(self.view.frame.size.width,
                               self.view.frame.origin.y,
                               RETRACT_X,
                               self.view.frame.size.height);
}

@end
