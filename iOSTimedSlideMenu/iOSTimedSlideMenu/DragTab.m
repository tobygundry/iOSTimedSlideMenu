//
//  DragTab.m
//  iOSTimedSlideMenu
//
//  Created by Toby Gundry on 17/09/13.
//  Copyright (c) 2013 Toby Gundry. All rights reserved.
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

#define DRAG_ICON @"drag-icon.png"

#import "DragTab.h"
#import <QuartzCore/QuartzCore.h>

const float w = 54.0f;
const float h = 44.0f;
const float x = 0.0f;
const float y = 0.0f;

@implementation DragTab

- (id)initWithSuperview:(UIView *)view position:(enum TabPosition)position
{
  if(self = [super init])
  {
    superview = view;

    if(position==LeftPosition)
    {
      [self setLeftPositionFrame];
    }
    else // RightPosition
    {
      [self setRightPositionFrame];
    }
    
    [self addDragIcon];
  }
  
  return self;
}

- (void)setLeftPositionFrame
{
  self.frame = CGRectMake(superview.frame.size.width,
                          y,
                          w,
                          superview.frame.size.height);
}

- (void)setRightPositionFrame
{
  self.frame = CGRectMake(x, y, w, superview.frame.size.height);
}

- (void)addDragIcon
{
  UIImageView *img = [self getDragIcon];
  
  img.center =
    CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
  
  [self addSubview:img];
}

- (UIImageView *)getDragIcon
{
  return [[UIImageView alloc] initWithImage:[UIImage imageNamed:DRAG_ICON]];
}

@end
