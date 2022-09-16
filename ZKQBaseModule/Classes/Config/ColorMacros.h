//
//  ColorMacros.h
//  LifeInsurance
//
//  Created by zrq on 2018/9/3.
//  Copyright © 2018年 cn.picclife.  All rights reserved.
//

#ifndef ColorMacros_h
#define ColorMacros_h
#import "UIColor+Add.h"
// 16进制->10进制, RGB颜色转换
#define kColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

///颜色
#define RGBA(r, g, b, a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]

///系统颜色
#define SystemColor [UIColor colorWithRed:255 / 255.0 green:75 / 255.0 blue:56 / 255.0 alpha:1 / 1.0]
///视图的背景颜色 EBEBF1
//#define SystemViewBgColor RGBA(0xeb, 0xeb, 0xf1, 1.0)
#define SystemViewBgColor RGBA(0xff, 0xff, 0xff, 1.0)
//融云使用
#define RCDLocalizedString(key) NSLocalizedStringFromTable(key, @"RongCloudKit", nil)
/** 标题 */
#define kFONT_COLOR_1 kColorFromRGB(0x222222)

//颜色设置
#define KNavColor [UIColor colorWithHexString:@"#f00d21"] //导航栏颜色

#define KBgColor [UIColor colorWithHexString:@"f8f8f8"]  //背景色
#define KRedColor [UIColor colorWithHexString:@"FF4B38"] //红色
//所有间隔线颜色
#define KLineColor [UIColor colorWithHexString:@"DDDDDD"]//ebebeb
#define KLineWidth 0.5
#define KColorHex(hexString) [UIColor colorWithHexString:hexString] //文字颜色
#define DarkColorHex(light,dark)  [UIColor colorWithLightColorStr:light DarkColor:dark]//暗黑模式
//主背景
#define KBackColorWhiteSwift DarkColorHex(kWhiteTitle,kColor_00)
////-------------TODO:适用于一般页面【暗黑模式下统一风格、切勿修改】
#define KBackColorSwift DarkColorHex(kColor_F5,kColor_00)//一般页面的背景色
#define KWhiteColorSwift DarkColorHex(kWhiteTitle,KColorView)//一般页面上的白色卡片、cell等
#define KLineColorSwift DarkColorHex(kColor_ee,KColorLine)//一般页面上分割线颜色
#define KTextColor33Swift DarkColorHex(kBlackTitle,kTipMark)//一般页面黑色字体
#define KTextColor66Swift DarkColorHex(kSystemTitle,kTipMark)//一般页面黑色字体
#define KPlaceHoldColorSwift DarkColorHex(kColor_99,KColorHold)//一般页面默认提示语\弹窗中默认提示语
#define KColorff4848Swift DarkColorHex(kColor_4848,KBlackff4848)///ff4848 颜色的暗黑状态


////-------------TODO:适用于弹窗【暗黑模式下统一风格、切勿修改】
#define kAlertBackColorSwift DarkColorHex(kWhiteTitle,KColorAlert)///弹窗底色
#define kAlertFeildBackColorSwift DarkColorHex(kColor_F5,KColorAlertLine)///输入框颜色
#define kAlertTitleColorSwift DarkColorHex(kBlackTitle,KColorAlertTitle)///弹窗文案颜色、取消、确定按钮颜色
#define kAlertTextFeildColorSwift DarkColorHex(kColorAlertFeildLine,KColorHold)////输入框分割线颜色
#define kAlertTextFeildLineColorSwift DarkColorHex(kColor_ee,KColorAlertLine)///分割线颜色

#define kOrange         @"FFAE35"   //橘黄色值
#define kSystem         @"FF4B48"   //人保红
#define kWhiteTitle     @"FFFFFF"   //字体默认白色
#define kSystemTitle    @"666666"   //系统字体
#define kTipMark        @"CCCCCC"   //提示字体\暗黑模式下字体
#define kBlackTitle     @"333333"   //加黑字体
#define kColor_F5     @"#F5F5F5"   //背景色
#define kColor_99     @"999999"//999
#define kColor_4848     @"#FF4848"//FF4B48 暗红色
#define kColorBlack    @"#000000" //黑色背景
#define kColor_00     @"#101010" //黑色背景
#define kColor_7bc8ff     @"#7bc8ff" //活动页导航背景色
#define kColor_dd     @"#DDDDDD" //线条颜色
#define kColor_ee     @"#EEEEEE" //线条颜色

#define KColorView @"#181818" //底色
#define KColorLine @"#202020" //分割线
#define KColorAlert @"#2c2c2c" //弹窗底色
#define KColorAlertTitle @"#9b9b9b" //弹窗提示文字色
#define KColorAlertLine @"#373737" //弹窗分割线色
#define KColorHold @"#555555" //默认提示语颜色
#define KBlackff4848 @"#e64848" //FF4B48 暗红色暗黑模式下
#define kColorAlertFeildLine @"#c0c0c0" //输入框中分割线颜色

//常用颜色生成
#define Color_Black [UIColor blackColor]
#define Color_White [UIColor whiteColor]
#define Color_Red   [UIColor redColor]
#define Color_Clear [UIColor clearColor]
#define Color_LabelGrayColor RGBA(102, 102, 102, 1)

#define Color_F5F5F5 [UIColor colorWithHexString:@"#F5F5F5"] //列表页面背景色
#define Color_999999 [UIColor colorWithHexString:@"#999999"] //保单变更列表状态灰色
#define Color_666666 [UIColor colorWithHexString:@"#666666"] //保单变更列表订单号title色值
#define Color_333333 [UIColor colorWithHexString:@"#333333"] //保单变更列表订单号value色值
#define Color_368BFE [UIColor colorWithHexString:@"#368BFE"] //蓝色字体
#define Color_DDDDDD [UIColor colorWithHexString:@"#DDDDDD"] // 标签背景颜色色值
///白银字体
#define Color_898989 [UIColor colorWithHexString:@"#898989"]
///黄金字体
#define Color_A2844D [UIColor colorWithHexString:@"#A2844D"]
///铂金字体
#define Color_8296A2 [UIColor colorWithHexString:@"#8296A2"]
///钻石字体
#define Color_909090 [UIColor colorWithHexString:@"#909090"]
///黑钻字体
#define Color_6F7275 [UIColor colorWithHexString:@"#6F7275"]
///红色字体
#define Color_FF4848 [UIColor colorWithHexString:@"#FF4848"]

#define Color_CCCCCC [UIColor colorWithHexString:@"#CCCCCC"]


#endif /* ColorMacros_h */
