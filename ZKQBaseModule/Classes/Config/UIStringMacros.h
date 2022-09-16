//
//  UIStringMacros.h
//  SmartPicc
//
//  Created by dandan on 2019/11/15.
//  Copyright © 2019 cn.picclife. All rights reserved.
//

#ifndef UIStringMacros_h
#define UIStringMacros_h

///UI相关的字符串常量
#define NoMoreDataTips @"没有更多内容了~"
#define NoDataTips @"没有数据"

//人脸验证服务详情
#define kFaceTip @"以下人脸验证环节，由北京百度网讯科技有限公司（简称“百度网讯）”提供技术服务，您点击同意按钮即表示您同意中国人民人寿保险股份有限公司（以下简称我公司）及百度网讯获取并使用您的相关信息，在此环节收集的信息仅用于通过人脸识别验证您的身份。如您不同意我公司及百度网讯获取或使用您的相关信息，请不要进行后续操作。"

#define kAuthFaceTip  @"以下人脸验证环节，由北京百度网讯科技有限公司（简称“百度网讯”）及北京旷视科技有限公司（简称“旷视科技”）提供技术服务，您点击同意按钮即表示您同意中国人民人寿保险股份有限公司（以下简称我公司）及百度网讯、旷视科技获取并使用您的相关信息，在此环节收集的信息仅用于通过人脸识别验证您的身份，同时我司将采用完善的安全措施确保您的信息安全。如您不同意我公司及百度网讯、旷视科技获取或使用您的相关信息，请不要进行后续操作。"

#pragma mark - /*** 项目里的静态变量 ***/
static NSString *const Cert_LongTerm = @"长期";
static NSString *const Cert_LongTermParam = @"9999.12.31";
static NSString *const Cert_LongTermParamWithLine = @"9999-12-31";

static NSString *const baoquanRecCo = @"e8920ce0e384462d8e462d54be463bb4";
static NSString *const fenhongRecCo = @"1de24c255c7c4ed5a4a23676750051b9";
static NSString *const xuqiRecCo = @"99d38fb08a4e45e3a7345f46b7a23c1d";
static NSString *const lipeiRecCo = @"444010c0457f4a0ba95f39d13ab15fa6";

static NSString *const onlineKefuRecCo = @"7958a81b6e614b7ab3cc6422446eeca5";
static NSString *const wangDianSearchRecCo = @"8f0331fba3f04606ab2e70528c1cb99a";

static NSString *const tousujianyiRecCo = @"7958a81b6e614b7ab3cc6422446eeca5";///投诉建议的code-暂时客户端没用

static NSString *const zaiXianHuiFangRecCo = @"17bafa04b1f640c69f6ae2684183b0a2"; // 在线回访
static NSString *const lianXiZiLiaoRecCo = @"106827a2aa05420ab075eae457e06e3f"; /// 客户资料变更
#endif /* UIStringMacros_h */
