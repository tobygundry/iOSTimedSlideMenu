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
    
    position = RightPosition;
    
    if(position==RightPosition)
    {
      [self offsetSubviews];
    }
    
    dragTab = [[DragTab alloc] initWithSuperview:self position:position];
    
    [self addSubview:dragTab];
    
    [self retractMenu];
  }
  
  return self;
}

- (void)offsetSubviews
{
  float offsetBy = dragTab.frame.size.width;
  
  NSArray *subviews = [self subviews];
  
#ifdef DEBUG
  NSLog(@"Subviews to be offset: %d", [subviews count]);
#endif
  
  for(UIView *view in subviews)
  {
    view.frame = CGRectMake(view.frame.origin.x + offsetBy,
                            view.frame.origin.y,
                            view.frame.size.width,
                            view.frame.size.height);
  }
}

- (void)expandMenu
{
  [self toggleExpandedFlag];
  
  [UIView animateWithDuration:0.3f
                        delay:0.0f
                      options:0
                   animations:^{
                     if(position == LeftPosition)
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

-(void)addProgressIndicator
{
  _progress = [[ProgressIndicator alloc] initWithSuperview:self
                                                  position:position];
  
  [self addSubview:_progress.view];
}

- (void)retractMenu
{
  float x = (position==LeftPosition)
  
    ? originalFrame.size.width * -1
  
    : originalFrame.size.width - dragTab.frame.size.width;
 
  float y = originalFrame.origin.y;
  float w = originalFrame.size.width + dragTab.frame.size.width;
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
  
  if(touchX > (initialTouchX + 50) && position==LeftPosition)
  {
    [self expandMenu];
    
    return;
  }
  else if(touchX < (initialTouchX - 50) && position==RightPosition)
  {
    [self expandMenu];
    
    return;
  }
  
  float newX = (position==LeftPosition)
  
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
  
#ifdef DEBUG
  NSLog(@"touchesEnded:withEvent: x = %f", touchX);
#endif
  
  if(touchX < initialTouchX + 50)
  {
    [self retractMenu];
  }
}

@end