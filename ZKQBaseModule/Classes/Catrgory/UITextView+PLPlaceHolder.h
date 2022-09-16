//
//  UITextView+PLPlaceHolder.h
//  SmartPicc
//
//  Created by zrq on 2019/2/1.
//  Copyright © 2019年 cn.picclife. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (PLPlaceHolder)
@property (nonatomic, copy) NSString *placeHolder;
- (void)showPlaceHolder;
- (void)hiddenPlaceHolder;
@end

NS_ASSUME_NONNULL_END
