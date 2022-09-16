//
//  UITextField+Add.h
//  LifeInsurance
//
//  Created by zrq on 2018/10/17.
//  Copyright © 2018年 cn.picclife.  All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UITextField (Add)


/**
 @brief 获取当前光标的位置
 @author add by jins 2019.12.9
 
 @return 返回光标位置
 */
- (NSRange)selectedRange;


/**
 @brief 设置当前光标的位置
 @author add by jins 2019.12.9
 
 @param range 位置range
 */
- (void)setSelectedRange:(NSRange)range;


@end

NS_ASSUME_NONNULL_END
