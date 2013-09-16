//
//  TimedSlideMenu.m
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

#import "TimedSlideMenu.h"

@implementation TimedSlideMenu

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  
  if (self)
  {
    originalFrame = self.frame;
    
    isExpanded = NO;
    
    [self retractMenu];
  }
  
  return self;
}

- (void)slideOut
{
  [self toggleExpandedFlag];
  
  [UIView animateWithDuration:0.3f
                        delay:0.0f
                      options:0
                   animations:^{ self.frame = originalFrame; }
                   completion:^(BOOL complete) { [self scheduleReset]; }];
  
  [self addProgressIndicator];
}

-(void)addProgressIndicator
{
  _progress = [[ProgressIndicator alloc] initWithSuperview:self];
  
  [self addSubview:_progress.view];
}

- (void)retractMenu
{
  float x = originalFrame.size.width * -1;
  float y = originalFrame.origin.y;
  float w = originalFrame.size.width + 44.0;
  float h = originalFrame.size.height;
  
  self.frame = CGRectMake(x, y, w, h);
}

- (void)scheduleReset
{
  [NSTimer scheduledTimerWithTimeInterval:5.0
                                   target:self
                                 selector:@selector(reset:)
                                 userInfo:nil
                                  repeats:NO];
}

- (void)toggleExpandedFlag
{
  isExpanded = !isExpanded;
  
#ifdef DEBUG
  NSLog(@"toggleExpandedFlag called, new isExpanded value: %d", isExpanded);
#endif
}

- (void)reset:(id)sender
{
  [UIView animateWithDuration:0.3f
                        delay:0.0f
                      options:0
                   animations:^{ [self retractMenu]; }
                   completion:^(BOOL complete) { [self toggleExpandedFlag]; }];
}

#pragma mark UIResponder methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  initialTouchX = [[touches anyObject] locationInView:self.superview].x;
  
#ifdef DEBUG
  NSLog(@"touchesBegan:withEvent: initalTouchX = %f", initialTouchX);
#endif
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  if(isExpanded) return;
  
  float touchX = [[touches anyObject] locationInView:self.superview].x;
  
#ifdef DEBUG
  NSLog(@"touchesMoved:withEvent: x = %f", touchX);
#endif
  
  if(touchX > (initialTouchX + 50))
  {
    [self slideOut];
    
    return;
  }
  
  self.frame = CGRectMake(touchX - self.frame.size.width,
                          self.frame.origin.y,
                          self.frame.size.width,
                          self.frame.size.height);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  if(isExpanded) return;
  
  float touchX = [[touches anyObject] locationInView:self.superview].x;
  
#ifdef DEBUG
  NSLog(@"touchesEnded:withEvent: x = %f", touchX);
#endif
  
  if(touchX < initialTouchX + 50)
  {
    [self retractMenu];
  }
}

@end