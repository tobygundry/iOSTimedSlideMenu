//
//  ViewController.m
//  Example
//
//  Created by Toby Gundry on 16/09/13.
//  Copyright (c) 2013 iOSTimedSlideMenu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
  [rightMenu setPosition:RightPosition];
  [super viewDidLoad];
}

- (IBAction)setDragThreshold:(id)sender
{
  NSLog(@"Setting drag threshold to: %@", [sender text]);
  
  leftMenu.dragThreshold = [[sender text] floatValue];
  rightMenu.dragThreshold = [[sender text] floatValue];
}

- (IBAction)setVisibleTime:(id)sender
{
  NSLog(@"Setting visible time to: %@", [sender text]);
  
  leftMenu.visibleTime = [[sender text] floatValue];
  rightMenu.visibleTime = [[sender text] floatValue];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

@end
