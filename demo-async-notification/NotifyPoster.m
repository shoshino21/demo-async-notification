//
//  NotifyPoster.m
//  demo-async-notification
//
//  Created by shoshino21 on 5/24/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "NotifyPoster.h"

@implementation NotifyPoster {
  NSTimer *timer;
  NSNotificationQueue *notifyQueue;
}

- (instancetype)init {
  self = [super init];
  if (self) {
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

    notifyQueue = [[NSNotificationQueue alloc]
                   initWithNotificationCenter:[NSNotificationCenter defaultCenter]];
  }
  return self;
}

- (void)timerTick {
  NSNotification *noti = [NSNotification notificationWithName:kMyNotificationName
                                                       object:nil
                                                     userInfo:nil];

  NSLog(@"通知即將發送");

  [notifyQueue enqueueNotification:noti
                      postingStyle:NSPostASAP
                      coalesceMask:NSNotificationCoalescingOnName | NSNotificationCoalescingOnSender
                          forModes:nil];

  NSLog(@"通知發送完成");
}

@end
