//
//  PLNetCondition.h
//  SmartPicc
//
//  Created by xu xiaodan on 2020/5/19.
//  Copyright © 2020 cn.picclife. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PLHostType_TEST = 0, /// 测试环境
    PLHostType_PRODUCT = 1, /// 生产环境
    PLHostType_RELEASE = 2, ///rel环境
    PLHostType_TESTNEW = 3,/// 测试环境 新域名
    PLHostType_PRODUCTNEW = 4 ,/// 生产环境 新域名
    PLHostType_RELEASENEW = 5,/// rel环境 新域名
    PLHostType_UAT = 6,///业务验收环境
} PLHostType;

NS_ASSUME_NONNULL_BEGIN

@interface PLNetCondition : NSObject

+(instancetype )sharedInstance;

///U+相关需求\团单保全
@property (nonatomic,copy) NSString *enterpriseService;
///基础链接
@property (nonatomic,copy) NSString *baseService;
///用户信息相关
@property (nonatomic,copy) NSString *userService;
@property (nonatomic,copy) NSString *lifeAppRelService;
///lifeapp-web
@property (nonatomic,copy) NSString *lifeAppWeb;
///只有域名
@property (nonatomic,copy) NSString *host;
///只有域名 ：h5页面域名
@property (nonatomic,copy) NSString *h5host;
///客户投诉服务、保全记录、理赔记录、分红记录、续期记录
@property (nonatomic,copy) NSString *baseH5URL;
///保险贷款项自动转账授权书、服务协议
@property (nonatomic,copy) NSString *URL;
///团险自动转账授权书
@property (nonatomic,copy) NSString *H5Payment;
///登录相关
@property (nonatomic,copy) NSString *login;
/// 保全修改客户信息 h5域名
@property (nonatomic, copy) NSString *h5HostApi;

///保全（费用类）接口文档 add by jins 2019.12.16
@property (nonatomic,copy) NSString *cost_service;

///智测保地址
@property (nonatomic,copy) NSString *bestProtect;

///客户经理详情h5地址
@property (nonatomic,copy) NSString *managerDetailService;


///听云key，tingYunKey在mian函数中配置的，main函数时tingYunKey是空，需要重写get方法获取key值
@property (nonatomic,copy) NSString *tingYunKey;

///高德地图appkey
@property (nonatomic,copy) NSString *gaodeMapKey;

///保全变更个险红利通知书
@property (nonatomic,copy) NSString *baseServicerelease;

///H5微信支付安全域名
@property (nonatomic,copy) NSString *h5WxpayReferer;

///直播设置
@property (nonatomic,copy) NSString *PLVLiveAppId;
@property (nonatomic,copy) NSString *PLVLiveUserId;
@property (nonatomic,copy) NSString *PLVLiveAppSecret;

/**
 测试包当前网络环境  0:测试环境 1:生产环境 2:release环境 3:测试环境2-web使用https://lifeapp-api-test.picclife.cn域名 5:release环境新域名
 生产包网络环境currentHostType== 1(旧域名)  或者 4（新域名），不可修改
*/

@property(nonatomic,assign) PLHostType currentHostType;

/// 前后端域名分离：使用的后端域名标记    1，是老域名；如果为2，是新域名
@property (nonatomic,copy) NSString *systemType;

/// 保单变更的h5
@property (nonatomic,copy) NSString *insuranceChangeH5;
///六一活动扫码签收
@property (nonatomic,copy) NSString *lifeapp_rel;

/// 我的保单健康险详情
@property (nonatomic,copy) NSString *healthDetailH5;
/// 我的页面信息披露链接，只有生产地址
@property (nonatomic,copy) NSString *informationURL;
/// 管家h5授权功能
@property (nonatomic,copy) NSString *authorizeH5;
/// 融云推送key
@property (nonatomic, copy) NSString *pushKey;
/// 融云推送secret
//@property (nonatomic, copy) NSString *pushSecret;

/// 融云推送nevi服务
@property (nonatomic, copy) NSString *pushNaviServer;
/// 融云推送file服务
@property (nonatomic, copy) NSString *pushFileServer;
/// 新增在线报案【理赔指南】
@property (nonatomic, copy) NSString *claimUrl;
/// 新增在线报案【分享空白页面】
@property (nonatomic, copy) NSString *claimShare;

///通用连接liftapp-rel and portal
///函件电子化
@property (nonatomic, copy) NSString *correspondence;
@end

NS_ASSUME_NONNULL_END
