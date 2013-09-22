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

#define DEFAULT_VISIBLE_TIME    5.0f
#define DEFAULT_DRAG_THRESHOLD  50.0f

#define EXPAND_DELAY            0.0f
#define EXPAND_SPEED            0.3f

#define RETRACT_DELAY           0.0f
#define RETRACT_SPEED           0.3f

#import "TimedSlideMenu.h"

@implementation TimedSlideMenu

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  
  if (self)
  {
    originalFrame = self.frame;
    
    isExpanded = NO;
    
    _visibleTime = DEFAULT_VISIBLE_TIME;
    
    _dragThreshold = DEFAULT_DRAG_THRESHOLD;
    
    [self setPosition:LeftPosition];
  }
  
  return self;
}

- (void)setPosition:(enum TabPosition)position
{
  tabPosition = position;
  
  if(tabPosition == RightPosition)
    [self offsetSubviews];
  
  if(dragTab)
    [dragTab removeFromSuperview];
  
  dragTab = [[DragTab alloc] initWithSuperview:self position:tabPosition];
  
  [self addSubview:dragTab];
  [self retractMenu];
}

- (void)offsetSubviews
{
  float offsetBy = dragTab.frame.size.width;
  
  NSArray *subviews = [self subviews];
  
  for(UIView *view in subviews)
  {
    view.frame = CGRectMake(view.frame.origin.x + offsetBy,
                            view.frame.origin.y,
                            view.frame.size.width,
                            view.frame.size.height);
  }
}

-(void)addProgressIndicator
{
  progress = [[ProgressIndicator alloc] initWithSuperview:self
                                                  position:tabPosition
                                                    speed:_visibleTime];
  
  [self addSubview:progress.view];
}

- (void)expandMenu
{
  [self toggleExpandedFlag];
  
  [UIView animateWithDuration:EXPAND_SPEED
                        delay:EXPAND_DELAY
                      options:NO
                   animations:^{
                     if(tabPosition == LeftPosition) // move into method
                     {
                       self.frame = originalFrame;
                     }
                     else
                     {
                       self.frame = CGRectMake(originalFrame.origin.x
                                               - dragTab.frame.size.width,
                                               originalFrame.origin.y,
                                               originalFrame.size.width
                                               + dragTab.frame.size.width,
                                               originalFrame.size.height);
                     }
                   }
                   completion:^(BOOL complete)
                   {
                     [self scheduleReset];
                   }];
  
  [self addProgressIndicator];
}

- (void)retractMenu
{
  float x = (tabPosition == LeftPosition)
  
    ? originalFrame.size.width * -1
  
    : originalFrame.size.width - dragTab.frame.size.width;
 
  float y = originalFrame.origin.y;
  float w = originalFrame.size.width + dragTab.frame.size.width;
  float h = originalFrame.size.height;
  
  self.frame = CGRectMake(x, y, w, h);
}

- (void)scheduleReset
{
  [NSTimer scheduledTimerWithTimeInterval:_visibleTime
                                   target:self
                                 selector:@selector(reset:)
                                 userInfo:nil
                                  repeats:NO];
}

- (void)toggleExpandedFlag
{
  isExpanded = !isExpanded;
}

- (void)reset:(id)sender
{
  [UIView animateWithDuration:RETRACT_SPEED
                        delay:RETRACT_DELAY
                      options:NO
                   animations:^{
                     [self retractMenu];
                   }
                   completion:^(BOOL complete) {
                     [self toggleExpandedFlag];
                   }];
}

#pragma mark UIResponder methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  initialTouchX = [[touches anyObject] locationInView:self.superview].x;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  if(isExpanded) return;
  
  float touchX = [[touches anyObject] locationInView:self.superview].x;
  
  if(touchX > (initialTouchX + _dragThreshold)
     && tabPosition == LeftPosition)
  {
    [self expandMenu];
    
    return;
  }
  else
  if(touchX < (initialTouchX - _dragThreshold)
     && tabPosition == RightPosition)
  {
    [self expandMenu];
    
    return;
  }
  
  float newX = (tabPosition == LeftPosition)
  
    ? touchX - self.frame.size.width
  
    : touchX;
  
  self.frame = CGRectMake(newX,
                          self.frame.origin.y,
                          self.frame.size.width,
                          self.frame.size.height);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  if(isExpanded) return;
  
  float touchX = [[touches anyObject] locationInView:self.superview].x;
  
  if(touchX < initialTouchX + _dragThreshold)
  {
    [self retractMenu];
  }
}

@end