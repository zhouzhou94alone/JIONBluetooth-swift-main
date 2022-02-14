//
//  UIButton+AC.h
//  ACCommonUtil
//
//  Created by ismallstar on 13-12-18.
//  Copyright (c) 2013年 Lim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ACButtonBlock)(UIButton *button);

@interface UIButton (AC)

//#if defined(__USE_SDWebImage__) && __USE_SDWebImage__
//- (void)setACImageURLString:(NSString *) anURLString;
//- (void)setACImageURLString:(NSString *) anURLString forState:(UIControlState)state;
//
//- (void)setACBackgroundImageURLString:(NSString *) anURLString;
//- (void)setACBackgroundImageURLString:(NSString *) anURLString forState:(UIControlState)state;
//#endif

- (void)addUpInside:(ACButtonBlock) acBlock;

@end
