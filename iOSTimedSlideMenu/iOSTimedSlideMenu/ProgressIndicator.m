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

#import "ProgressIndicator.h"

@implementation ProgressIndicator

- (id)initWithSuperview:(UIView *)view position:(enum StartPosition)position
{
    if (self = [super init])
    {
      superview = view;
    }
  
    return self;
}

- (void)loadView
{
  self.view = [[UIView alloc] init];
  
  float w = superview.frame.size.width;
  float h = 3.0;
  float x = 0;
  float y = superview.frame.size.height - h;
  
  self.view.frame = CGRectMake(x, y, w, h);
  self.view.backgroundColor = [UIColor whiteColor];
  self.view.layer.opacity = 0.7f;
  
  NSLog(@"loadView called %f %f %f %f", x, y, w, h);
  
  [self animateProgressIndicator];
}

- (void)animateProgressIndicator
{
  [UIView animateWithDuration:5.0
                   animations:^ { [self setProgressRetractFrame]; }
                   completion:nil];
}

- (void)setProgressRetractFrame
{
  self.view.frame = CGRectMake(self.view.frame.origin.x,
                          self.view.frame.origin.y,
                          0.0,
                          self.view.frame.size.height);
}

@end
