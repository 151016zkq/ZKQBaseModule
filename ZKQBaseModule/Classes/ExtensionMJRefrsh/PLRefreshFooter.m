//
//  PLRefreshFooter.m
//  SmartPicc
//
//  Created by 李昂 on 2019/11/21.
//  Copyright © 2019 cn.picclife. All rights reserved.
//

#import "PLRefreshFooter.h"
#import "UIColor+Add.h"
@implementation PLRefreshFooter

- (void)prepare
{
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:@"refresh_animation1"];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_animation%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    //     设置字体
    self.stateLabel.font = [UIFont systemFontOfSize:12];
    //     设置颜色
    self.stateLabel.textColor = [UIColor colorWithHexString:@"C0C0C0"];
}

@end
