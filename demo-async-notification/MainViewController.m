//
//  MainViewController.m
//  demo-async-notification
//
//  Created by shoshino21 on 5/24/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "MainViewController.h"

#import "NotifyPoster.h"
#import "NotifyReceiverA.h"
#import "NotifyReceiverB.h"

@interface MainViewController () {
  NSTimer *timer;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self triggerTimer];

  NSLog(@"%@", kMyNotificationName);
}

- (void)triggerTimer {
  timer = [NSTimer timerWithTimeInterval:3.f
                                  target:self
                                selector:@selector(timerTick)
                                userInfo:nil
                                 repeats:YES];

  // 注意：
  // 使用 timerWithTimeInterval method 時必須手動將 timer 加入 runloop 當中
  // 否則 timer 是不會被啟動的
  // (這點和 scheduledTimerWithTimeInterval method 不同)
  // 加入 runloop 後 timer 就會自動 fire
  [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)timerTick {

}

@end
