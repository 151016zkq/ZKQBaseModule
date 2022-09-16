//
//  PLNetCondition.m
//  SmartPicc
//
//  Created by xu xiaodan on 2020/5/19.
//  Copyright © 2020 cn.picclife. All rights reserved.
//

#import "PLNetCondition.h"
#import "UIStringMacros.h"
#import "APIStringMacros.h"
#pragma mark -- 第三方应用生产和测试key值相同
///高德地图key
#define  KGaoDeMapKey @"92e843e3497e8c6eeabe4bc72a0cf33b"

#define INFORMATIONLink @"https://www.picclife.com/picclifewebsite//picclife/channel/ProductPayment_1200.html?id=8a07e6956c83bb6f016c94f6548e09fe"
#pragma mark -- 需要根据不同target区分的key
///听云测试Key
#define  KTestTingYunKey @"47a84b7ed5c0407a9afe1b3c7ee89011"

///听云生产Key
#define KProductTingYunKey @"5e6aacc65f1d462bb465076f32ed66cd"


#pragma mark -- 需要根据 currentHostType 类型判断的地址及Key
#pragma mark -- 测试环境
///测试地址
#define TESTNetHOST @"https://mtest.picclife.cn"
///测试环境新域名域名
#define TESTWEBHOST @"https://lifeapp-api-test.picclife.cn"
#define TESTWEBH5HOST @"https://lifeapp-test.picclife.cn"
#define TESTWEBH5NEWHOST @"https://mtest-api.picclife.cn"
//我的保单健康详情的h5
#define TESTHealthDetailH5HOST @"http://114.247.172.178:8081"
///测试环境智测保地址
#define TESTKBestProtect @"https://msstest-api.picclife.cn/ss/api/wisdomProtect/get-code?agentCode="


/// 保利威直播测试环境key
#define KTestPLVLiveAppId @"fpy0it0of3"
#define KTestPLVLiveUserId  @"6e9b136f7c"
#define KTestPLVLiveAppSecret  @"8e750419574246c2a29ce26ee0954d6a"
//测试环境客户经理详情地址
#define KTestManagerDetailService @"https://msstest.picclife.cn/msshop/#/callingCard?"

//融云公有云测试环境AppKey/Secret
#define TESTRongYunPushAppKey @"vnroth0kvl0ro";
#define TESTRongYunPushSecret @"QKJPOGGlvYhIp";

//融云私有云测试环境AppKey/Secret
#define TESTPrivateRongYunPushAppKey @"k51hidw1e2hvb"
#define TESTPrivateRongYunPushSecret @"tqy3Zwwi2PVn9"
#define TESTPrivateRongYunPushNaviServer @"https://test-imsp-util.picclife.cn:1444"
#define TESTPrivateRongYunPushPicServer  @"https://test-imsp-util.picclife.cn:1446"


#define KTESTClaimUrl @"https://mtest.picclife.cn/ucsp-rel-h5/#/claim-guide-document"//新增在线报案理赔指南url[测试地址]
#define KTESTClaimShareZeroUrl @"https://mtest.picclife.cn/portal-web/app_manager/download.html?shareClaim="//新增在线报案分享空白页url[测试地址]

#pragma mark --生产环境
///生产环境地址
#define PRODOCTNetHOST @"https://m.picclife.cn"
#define PRODOCTNetNewAPIHOST @"https://lifeapp-api.picclife.cn"
#define PRODOCTNetNewH5HOST @"https://lifeapp.picclife.cn"
#define PRODUCTNetNewestH5HOST @"https://m-api.picclife.cn"
//我的保单健康详情的h5
#define PRODUCTHealthDetailH5HOST @"https://m.picchealth.com"
///生产环境智测保地址
#define PKBestProtect @"https://mss-api.picclife.cn/ss/api/wisdomProtect/get-code?agentCode="




/// 保利威直播生产环境key
#define KProductPLVLiveAppId  @"frz1mu3d11"
#define KProductLVLiveUserId @"29fe557028"
#define KProductPLVLiveAppSecret  @"7b0a4835371b4c69a7e5435feccc90e0"
//生产环境客户经理详情地址
#define KProductManagerDetailService @"https://lifeapp.picclife.cn/msshop/#/callingCard?"

// 融云公有云生产环境AppKey/Secret
#define PRODUCTRongYunPushAppKey @"m7ua80gbmegum"
#define PRODUCTRongYunPushAppSecret @"gYN4AFqsBssV6"
// 融云私有云生产环境AppKey/Secret/NaviServer/FileServer
#define PRODUCTPrivateRongYunPushAppKey @"c9kqb3rkvtn1j"
#define PRODUCTPrivateRongYunPushAppSecret @"k7ZEpN5w35"
#define PRODUCTPrivateRongYunPushNaviServer @"https://imsp-util.picclife.cn:1444"
#define PRODUCTPrivateRongYunPushPicServer  @"https://imsp-util.picclife.cn:1446"

#define KPRODUCTClaminUrl @"https://m.picclife.cn/ucsp/#/claim-guide-document"//新增在线报案理赔指南url[生产地址]
#define KPRODUCTClaimShareZeroUrl @"https://lifeapp.picclife.cn/portal/app_manager/download.html?shareClaim="//新增在线报案分享空白页url[生产地址]

///业务验收环境
#define UATAPIHOST @"https://lifeapp-api-uat.picclife.cn"
#define UATH5HOST  @"https://lifeapp-uat.picclife.cn"

#pragma mark -- 需要根据 currentHostType 类型判断的地址及Key

@implementation PLNetCondition

+(instancetype )sharedInstance{
    static PLNetCondition *condition = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        condition = [[PLNetCondition alloc] init];
    });
    return condition;
}
// release环境 1.ucsp-web换成ucsp-rel 2.portal-web换成portal-rel-web 3.ep-web/换成ep-rel-web/
- (void)setCurrentHostType:(PLHostType)currentHostType{
    _currentHostType = currentHostType;
    ///高德地图key
    self.gaodeMapKey = KGaoDeMapKey;
    
    ///我的页面信息披露链接，只有生产地址
    self.informationURL = INFORMATIONLink;

    /// 生产环境
    if (currentHostType == PLHostType_PRODUCT || currentHostType == PLHostType_PRODUCTNEW) {
        ///PLVLiveAppId
        self.PLVLiveAppId = KProductPLVLiveAppId;
        self.PLVLiveUserId = KProductLVLiveUserId;
        self.PLVLiveAppSecret = KProductPLVLiveAppSecret;
        ///智测保地址
        self.bestProtect = PKBestProtect;
        ///客户经理详情h5地址
        self.managerDetailService = KProductManagerDetailService;
        
        self.h5HostApi = PRODOCTNetHOST;
        
        if (currentHostType == PLHostType_PRODUCT) {//生产环境
            ///域名
            self.host = PRODOCTNetHOST;
            self.h5host = PRODOCTNetHOST;
        }
        else if (currentHostType == PLHostType_PRODUCTNEW) {//生产环境
            
            ///域名
            self.host = PRODOCTNetNewAPIHOST;
            self.h5host = PRODOCTNetNewH5HOST;
        }
        
        self.insuranceChangeH5 = [NSString stringWithFormat:@"%@/ucsp",self.h5host];
        ///U+相关需求\团单保全
        self.enterpriseService = [NSString stringWithFormat:@"%@/enterprise/",self.host];
        ///基础链接
        self.baseService = [NSString stringWithFormat:@"%@/ucsp",self.host];
        
        ///用户信息相关
        self.userService =  [NSString stringWithFormat:@"%@/portal",self.host];
        /// lifeapp-rel
        self.lifeAppRelService = [NSString stringWithFormat:@"%@/lifeapp",self.host];

        ///lifeapp-web
        self.lifeAppWeb = [NSString stringWithFormat:@"%@/lifeapp-web",self.host];
        ///六一活动扫码签收
        self.lifeapp_rel      = [NSString stringWithFormat:@"%@/lifeapp-rel",self.host];
        ///客户投诉服务、保全记录、理赔记录、分红记录、续期记录协议
        self.baseH5URL = [NSString stringWithFormat:@"%@/ucsp",self.h5host];
        ///保险贷款项自动转账授权书、服务协议，这个链接没有新域名，使用旧域名
        self.URL = [NSString stringWithFormat:@"%@/Life-H5",PRODOCTNetHOST];
        
        ///登录相关
        self.login = [NSString stringWithFormat:@"%@/lifeapp-uic",self.host];
        
        //保全（费用类）接口文档 add by jins 2019.12.16，没有使用
        self.cost_service =  [NSString stringWithFormat:@"%@/uis",self.host];
        

        ///保全变更个险红利通知书
        self.baseServicerelease =  [NSString stringWithFormat:@"%@/ucsp",self.h5host];
        ///团单自动授权书，直播h5地址,U+建管服务h5链接入口
        self.H5Payment = [NSString stringWithFormat:@"%@/portal",self.h5host];

        // 管家授权h5 服务
        self.authorizeH5 = [NSString stringWithFormat:@"%@/vxcs-web",self.h5HostApi];
        //我的保单健康险详情的域名
        self.healthDetailH5 = PRODUCTHealthDetailH5HOST;
        
        //新增在线报案理赔指南url[生产地址]
        self.claimUrl = KPRODUCTClaminUrl;
        //新增在线报案分享空白页url[生产地址]
        self.claimShare = KPRODUCTClaimShareZeroUrl;
        
        self.correspondence = [NSString stringWithFormat:@"%@/lifeapp-web", self.h5host];
    }
    else{
        ///PLVLiveAppId
        self.PLVLiveAppId = KTestPLVLiveAppId;
        self.PLVLiveUserId = KTestPLVLiveUserId;
        self.PLVLiveAppSecret = KTestPLVLiveAppSecret;
        ///客户经理详情h5地址
        self.managerDetailService = KTestManagerDetailService;

        ///智测保地址
        self.bestProtect = TESTKBestProtect;
        self.h5HostApi = TESTWEBH5NEWHOST;
        
        //新增在线报案理赔指南url[
        self.claimUrl = KTESTClaimUrl;
        //新增在线报案分享空白页url
        self.claimShare = KTESTClaimShareZeroUrl;
        

        if (currentHostType == PLHostType_TEST ||  currentHostType == PLHostType_TESTNEW) { ///测试环境
            ///域名
            self.host = currentHostType == PLHostType_TEST ? TESTNetHOST :TESTWEBHOST;
            self.h5host = currentHostType == PLHostType_TEST ? TESTNetHOST : TESTWEBH5HOST;
            ///U+相关需求\团单保全
            self.enterpriseService = [NSString stringWithFormat:@"%@/ep-web/",self.host];
            
            ///基础链接
            self.baseService = [NSString stringWithFormat:@"%@/ucsp-web",self.host];

            ///用户信息相关
            self.userService =  [NSString stringWithFormat:@"%@/portal-web",self.host];
            /// lifeapp-rel
            self.lifeAppRelService = [NSString stringWithFormat:@"%@/lifeapp-rel",self.host];
            ///lifeapp-web
            self.lifeAppWeb = [NSString stringWithFormat:@"%@/lifeapp-rel",self.host];
            ///客户投诉服务、保全记录、理赔记录、分红记录、续期记录协议
            self.baseH5URL = [NSString stringWithFormat:@"%@/ucsp",self.h5host];
            ///保险款项自动转账授权书、服务协议，这个链接没有新域名，使用旧域名
            self.URL = [NSString stringWithFormat:@"%@/Life-H5",TESTNetHOST];
            
            ///登录相关
            self.login = [NSString stringWithFormat:@"%@/lifeapp-uic",self.host];
            
            //保全（费用类）接口文档 add by jins 2019.12.1，没有使用
            self.cost_service = [NSString stringWithFormat:@"%@/uis",self.host];
            
            
            ///六一活动扫码签收
            self.lifeapp_rel      = [NSString stringWithFormat:@"%@/lifeapp-rel",self.host];
            ///保全变更个险红利通知书
            self.baseServicerelease =  [NSString stringWithFormat:@"%@/ucsp-rel",self.h5host];
            
            ///团单自动授权书,直播h5地址,U+建管服务h5链接入口
            self.H5Payment = [NSString stringWithFormat:@"%@/lifeapp-h5",self.h5host];
            /// 管家授权h5 服务
            self.authorizeH5 = [NSString stringWithFormat:@"%@/vxcs-web",self.h5HostApi];

            self.correspondence = [NSString stringWithFormat:@"%@/lifeapp-rel",self.host];

        }
        else if (currentHostType == PLHostType_RELEASE || currentHostType == PLHostType_RELEASENEW || currentHostType == PLHostType_UAT) {///release环境

            ///域名
            if (currentHostType == PLHostType_UAT) {
                self.host = UATAPIHOST;
                self.h5host = UATH5HOST;
            }
            else{
                self.host = currentHostType == PLHostType_RELEASE ? TESTNetHOST:TESTWEBHOST;
                self.h5host = currentHostType == PLHostType_RELEASE ? TESTNetHOST : TESTWEBH5HOST;
            }
            ///U+相关需求\团单保全
            self.enterpriseService = [NSString stringWithFormat:@"%@/ep-rel-web/",self.host];
            
            ///基础链接
            self.baseService = [NSString stringWithFormat:@"%@/ucsp-rel",self.host];

            ///用户信息相关
            self.userService =  [NSString stringWithFormat:@"%@/portal-rel-web",self.host];

            /// lifeapp-rel
            self.lifeAppRelService = [NSString stringWithFormat:@"%@/lifeapp-rel",self.host];
            ///lifeapp-web
            self.lifeAppWeb = [NSString stringWithFormat:@"%@/lifeapp-rel",self.host];


            ///六一活动扫码签收
            self.lifeapp_rel      = [NSString stringWithFormat:@"%@/lifeapp-rel",self.host];
            ///客户投诉服务、保全记录、理赔记录、分红记录、续期记录协议
            self.baseH5URL = [NSString stringWithFormat:@"%@/ucsp-rel-h5",self.h5host];
            ///保险款项自动转账授权书、服务协议，这个链接没有新域名，使用旧域名
            self.URL = [NSString stringWithFormat:@"%@/Life-H5",TESTNetHOST];
            
            ///登录相关
            self.login = [NSString stringWithFormat:@"%@/lifeapp-uic-rel",self.host];
            
            //保全（费用类）接口文档 add by jins 2019.12.1，没有使用
            self.cost_service = [NSString stringWithFormat:@"%@/uis",self.host];
            
        
            self.baseServicerelease =  [NSString stringWithFormat:@"%@/ucsp-rel",self.h5host];
                        
            ///团单自动授权书,直播h5地址,U+建管服务h5链接入口
            self.H5Payment = [NSString stringWithFormat:@"%@/lifeapp-h5",self.h5host];
            /// 管家授权h5 服务
            self.authorizeH5 = [NSString stringWithFormat:@"%@/vxcs-web",self.h5HostApi];

            self.correspondence = [NSString stringWithFormat:@"%@/lifeapp-rel", self.host];
        }
        self.insuranceChangeH5 = [NSString stringWithFormat:@"%@/ucsp-rel-h5",self.h5host];
        //我的保单健康险详情的域名
        self.healthDetailH5 = TESTHealthDetailH5HOST;
    }
}


- (NSString *)tingYunKey{
    NSString *bundleName = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleName"];
    
    if ([bundleName isEqualToString:ProductBundleName] ) {
        
        return KProductTingYunKey;
    } else if ([bundleName isEqualToString:DevelopmentBundleName] || [bundleName isEqualToString:TestflightBundleName]) {
        
        return KTestTingYunKey;
    }
    return @"";
}
- (NSString *)systemType{
    if (self.currentHostType == PLHostType_TESTNEW || self.currentHostType == PLHostType_PRODUCTNEW || self.currentHostType == PLHostType_RELEASENEW || self.currentHostType == PLHostType_UAT) {
        return @"2";
    }
    else{
        return @"1";
    }
}
- (NSString *)pushKey {
    if (self.currentHostType == PLHostType_PRODUCT || self.currentHostType == PLHostType_PRODUCTNEW) {
        return PRODUCTPrivateRongYunPushAppKey;
    }else {
        return TESTPrivateRongYunPushAppKey;
    }
}
- (NSString *)pushSecret {
    if (self.currentHostType == PLHostType_PRODUCT || self.currentHostType == PLHostType_PRODUCTNEW) {
        return PRODUCTRongYunPushAppSecret;
    }else {
        return TESTRongYunPushSecret;
    }
}
- (NSString *)pushNaviServer {
    if (self.currentHostType == PLHostType_PRODUCT || self.currentHostType == PLHostType_PRODUCTNEW) {
        return PRODUCTPrivateRongYunPushNaviServer;
    }else {
        return TESTPrivateRongYunPushNaviServer;
    }
}

- (NSString *)pushFileServer {
    if (self.currentHostType == PLHostType_PRODUCT || self.currentHostType == PLHostType_PRODUCTNEW) {
        return PRODUCTPrivateRongYunPushPicServer;
    }else {
        return TESTPrivateRongYunPushPicServer;
    }
}
@end
