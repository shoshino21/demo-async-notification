//
//  MainViewController.m
//  demo-async-notification
//
//  Created by shoshino21 on 5/24/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "MainViewController.h"

#import "NotifyPoster.h"
#import "NotifyReceiver.h"

@interface MainViewController () {
  NSTimer *_timer;
  NotifyPoster *_poster;
  NotifyReceiver *_receiverA;
  NotifyReceiver *_receiverB;
}

@end

@implementation MainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  _poster = [NotifyPoster new];
  _receiverA = [[NotifyReceiver alloc] initWithIdentifier:@"ReceiverA"];
  _receiverB = [[NotifyReceiver alloc] initWithIdentifier:@"ReceiverB"];

  [self triggerTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];

  // 在 viewDidDisappear 就要釋放 timer (而非 dealloc)，避免 retain cycle
  [_timer invalidate];
  _timer = nil;
}

#pragma mark - Methods

- (void)triggerTimer {
  _timer = [NSTimer timerWithTimeInterval:3.f
                                   target:self
                                 selector:@selector(timerTick)
                                 userInfo:nil
                                  repeats:YES];

  // 使用 timerWithTimeInterval method 時必須手動將 timer 加入 runloop 當中，否則 timer 是不會被啟動的
  // (這點與 scheduledTimerWithTimeInterval method 不同)
  // 加入 runloop 後 timer 就會自動 fire
  [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)timerTick {
  [_poster triggerNotify];
}

@end
