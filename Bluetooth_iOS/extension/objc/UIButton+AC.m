//
//  UIButton+AC.m
//  ACCommonUtil
//
//  Created by ismallstar on 13-12-18.
//  Copyright (c) 2013年 Lim. All rights reserved.
//

#import "UIButton+AC.h"
#import <objc/runtime.h>
@implementation UIButton (AC)

//#if defined(__USE_SDWebImage__) && __USE_SDWebImage__
//- (void)setACImageURLString:(NSString *)anURLString {
//    [self setACImageURLString:anURLString forState:UIControlStateNormal];
//}
//
//- (void)setACImageURLString:(NSString *)anURLString forState:(UIControlState)state {
//    NSURL *URL = [NSURL URLWithString:anURLString];
//    UIImage *placeholderImage = [HMUtil drawPlaceholderWithSize:self.frame.size];
//    
//    __weak typeof(self) weakSelf = self;
//    [self sd_setImageWithURL:URL forState:state placeholderImage:placeholderImage
//                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
//    {
//        if (image && !error) {
//            UIImage *newImage = [HMUtil resizedImageWithImage:image size:weakSelf.frame.size];
//            [weakSelf setImage:newImage forState:state];
//        }
//    }];
//}
//
//- (void)setACBackgroundImageURLString:(NSString *) anURLString {
//    [self setACBackgroundImageURLString:anURLString forState:UIControlStateNormal];
//}
//
//- (void)setACBackgroundImageURLString:(NSString *) anURLString forState:(UIControlState)state {
//    NSURL *URL = [NSURL URLWithString:anURLString];
//    UIImage *placeholderImage = [HMUtil drawPlaceholderWithSize:self.frame.size];
//    
//    __weak typeof(self) weakSelf = self;
//    [self sd_setBackgroundImageWithURL:URL forState:state placeholderImage:placeholderImage
//                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image && !error) {
//            UIImage *newImage = [HMUtil resizedImageWithImage:image size:weakSelf.frame.size];
//            [weakSelf setBackgroundImage:newImage forState:state];
//        }
//    }];
//}
//#endif

- (void)addUpInside:(ACButtonBlock)acBlock {
    objc_setAssociatedObject(self, _cmd, acBlock, OBJC_ASSOCIATION_COPY);
    [self addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickButton:(UIButton *) sender {
    ACButtonBlock acBlock = objc_getAssociatedObject(self, @selector(addUpInside:));
    if (acBlock) {
        acBlock(sender);
    }
}

@end
