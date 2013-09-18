//
//  DragTab.m
//  iOSTimedSlideMenu
//
//  Created by Toby Gundry on 17/09/13.
//  Copyright (c) 2013 Toby Gundry. All rights reserved.
//

#import "DragTab.h"
#import <QuartzCore/QuartzCore.h>

const float w = 44.0;
const float h = 44.0;
const float x = 0;
const float y = 0;

@implementation DragTab

- (id)initWithSuperview:(UIView *)view position:(enum StartPosition)position
{
  if(self = [super init])
  {
    superview = view;
    self.backgroundColor = [UIColor redColor];
    if(position==LeftPosition)
    {
      self.frame = CGRectMake(superview.frame.size.width, y, w,
                              superview.frame.size.height);
    }
    else // RightPosition
    {
      self.frame = CGRectMake(x, y, w, superview.frame.size.height);
    }
    
    [self addSubview:[self getDragIcon]];
  }
  
  return self;
}

- (UIView *)getDragIcon
{
  float w = 42.0;
  float h = 4.0 * 4.0;
  
  UIView *dragIcon = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
  
  [dragIcon addSubview:[self getRectPart:CGPointMake(0,4)]];
  [dragIcon addSubview:[self getRectPart:CGPointMake(0,12)]];
  [dragIcon addSubview:[self getRectPart:CGPointMake(0,20)]];
  
  return dragIcon;
}

- (UIView *)getRectPart:(CGPoint)point
{
  CGRect dragFrame = CGRectMake(0.0, point.y, 38.0, 4.0);
  
  UIView *dragPart = [[UIView alloc] initWithFrame:dragFrame];
  
  dragPart.backgroundColor = [UIColor grayColor];
  dragPart.layer.cornerRadius = 4.0;
  // dragRect.layer.shadowColor = CGColor
  
  return dragPart;
}

@end
