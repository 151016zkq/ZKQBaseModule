//
//  BaseUIViewController.h
//  LifeInsurance
//
//  Created by zrq on 2018/9/12.
//  Copyright © 2018年 cn.picclife.  All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PLEnumDefine.h"
#import "DimensMacros.h"
typedef enum : NSUInteger {
    From_ExpirationPayment, //满期金领取
    From_CancelInsurance, //退保
    From_WithdrawInsurance,//犹豫期撤保
} SourceFrom;
typedef void(^ViewDidDisappearBlcok)(BOOL animated);




@interface BaseUIViewController : UIViewController
@property (nonatomic, copy) ActiveTaskFinished taskFinished;
@property (nonatomic, copy) ViewDidDisappearBlcok viewDidDisappearBlcok;


@property (nonatomic, assign) SourceFrom sourceType; //来自于哪种类型的操作

/*** 是否移除水印 ***/
@property (nonatomic, assign) BOOL isRemoveWatermark;
@property (nonatomic, copy) NSDictionary *param;


///组件化创建vc方法
+ (id)createVC:(NSDictionary *)dict;

///强制旋转屏幕
- (void)orientationToPortrait:(UIInterfaceOrientation)orientation;

@end
