//
//  NotifyReceiver.m
//  demo-async-notification
//
//  Created by shoshino21 on 5/25/17.
//  Copyright © 2017 shoshino21. All rights reserved.
//

#import "NotifyReceiver.h"

@implementation NotifyReceiver {
  NSString *_identifier;
}

#pragma mark - Initialize

- (instancetype)initWithIdentifier:(NSString *)aIdentifier {
  self = [super init];
  if (self) {
    _identifier = aIdentifier;

    // 註冊接收通知的 observer
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotify:)
                                                 name:kMyNotificationName
                                               object:nil];
  }
  return self;
}

- (instancetype)init {
  return [self initWithIdentifier:@"Untitled"];
}

- (void)dealloc {
  // 移除 observer
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Methods

- (void)receiveNotify:(NSNotification *)noti {
  NSString *message = [NSString stringWithFormat:@"%@ 接收到通知", _identifier];
  NSLog(@"%@", message);
}

@end
