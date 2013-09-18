//
//  DragTab.h
//  iOSTimedSlideMenu
//
//  Created by Toby Gundry on 17/09/13.
//  Copyright (c) 2013 Toby Gundry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Position.h"

@interface DragTab : UIView
{
  UIView *superview;  // The TimedSlideMenu the DragTab belongs to
}

// The DragTab will be created using the dimensions from the TimedSlideMenu
- (id)initWithSuperview:(UIView *)view position:(enum StartPosition)position;

@end
