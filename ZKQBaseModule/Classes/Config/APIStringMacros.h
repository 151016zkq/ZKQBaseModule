
//
//  APIStringMacros.h
//  LifeInsurance
//
//  Created by zrq on 2018/9/3.
//  Copyright © 2018年 cn.picclife.  All rights reserved.
//

#ifndef APIStringMacros_h
#define APIStringMacros_h
#define Token @"picc-m-sid"//PICC-M-SID
#define Platform @"8"
#define SIDKEY @"sid-in-header"
#define SID @"1"
#define DeviceType @"ios"
// iOS系统版本
#define SystemVersion     [[UIDevice currentDevice] systemVersion]


///秘钥
#define Screct @"ba2e0b"
/// AES加密key
#define AESSecretKey @"ce37eec143ca4c04"

///AES用户登录信息接口certi_code，login_name，real_name，user_name，mobile字段解密偏移量
#define AESLogInSecretIV @"A-16-Byte-String"

//! 昵称
#define userNam @"user_name"
#define userI @"user_id"
//! 出生日期
#define userBirthday @"birthday"
//! 证件编码
#define userCertiCode @"certi_code"
//! 是否认证 1已认证 0未认证
#define userIsAuth @"is_auth"
//! 手机号
#define userMobile @"mobile"
//! 头像
#define userHeadImage @"head_image"
//! 性别 F 女 M 男
#define userGender @"gender"
//! 证件类型
#define userCertiType @"certi_type"
//! 真实姓名
#define userRealName @"real_name"
//! 是否绑定保单
#define userIsBind @"is_bind"

///重疾绿通
#define severeIllness @“”
///卡单激活

//!客服电话
static NSString *const ServiceNumber = @"95518" ;

///缓存的最近访问记录缓存文件
#define FileFolder @"RecentlyUsed"
#define FileName @"item.plist"
///搜索记录最近缓存文件
#define SearchFolder @"Search"
#define SearchFile @"list.plist"
#define ActivityFolder @"Activity"
#define ActivityFile @"list.plist"
#define UComWelfareFolder @"UComWelfare"
#define UComWelfareFile @"list.plist"
#define UInsuranceShopFolder @"UInsuranceShop"
#define UInsuranceShopFile @"list.plist"

///不同target 工程名CFBundleName
#define ProductBundleName @"人保寿险管家"
#define DevelopmentBundleName @"SmartPiccDev"
#define TestflightBundleName @"SmartPiccTestflight"


/****************打包必读***********************
//1.测试环境打包使用 smartPiccdev
//2.生产环境打包使用 smartPicc
//3.打包发布的版本不要用DEBUG,使用RELEASE
//4.打包之后检查dSYMs目录下生成符号文件
//#ifdef DEBUG
*********************************************/

#endif /* APIStringMacros_h */





