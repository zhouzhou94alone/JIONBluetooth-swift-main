//
//  UIView+ACGesture.h
//  WineTalk
//
//  Created by wjc on 16/7/21.
//  Copyright © 2016年 Shansù. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ACGesture)
- (void)addTapGesture:(void (^)(UIView *))tapBlock forKey:(const void *)key  numberOfTaps:(NSInteger)taps;
- (void)addTapGesture:(void (^)(UIView *))tapBlock numberOfTaps:(NSInteger)taps;
- (void)addLongPressGesture:(void(^)(UIView *label)) longPressBlock;
- (void)removeGestureForKey:(const void *) key;

@end
