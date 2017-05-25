//
//  NotifyPoster.m
//  demo-async-notification
//
//  Created by shoshino21 on 5/24/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "NotifyPoster.h"

@implementation NotifyPoster {
  NSNotificationQueue *_notifyQueue;
}

#pragma mark - Initialize

- (instancetype)init {
  self = [super init];
  if (self) {
    // 初始化 notification queue
    _notifyQueue = [[NSNotificationQueue alloc]
                    initWithNotificationCenter:[NSNotificationCenter defaultCenter]];
  }
  return self;
}

#pragma mark - Methods

- (void)triggerNotify {
  NSNotification *noti = [NSNotification notificationWithName:kMyNotificationName
                                                       object:nil
                                                     userInfo:nil];

  NSLog(@"通知即將發送");

  // 將通知加入 queue 後即可達成 async 效果，系統會找機會發送
  // 依 postingStyle 決定何時進行發送
  // 並依 coalesceMask 設定將多個通知合而為一
  // 若有設定 forModes，則會在特定的 runloop mode 時才進行發送
  [_notifyQueue enqueueNotification:noti
                       postingStyle:NSPostASAP
                       coalesceMask:NSNotificationCoalescingOnName |
                                    NSNotificationCoalescingOnSender
                           forModes:nil];

  NSLog(@"通知發送完成");
}

@end
