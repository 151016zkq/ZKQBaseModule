//
//  PLEnumDefine.h
//  PLBasicModule
//
//  Created by Mac on 2020/6/8.
//

#ifndef PLEnumDefine_h
#define PLEnumDefine_h

#pragma mark - /*** 枚举类型 ***/
typedef enum : NSUInteger {
    BuryingFrom_Home,       //首页
    BuryingFrom_HoverBtn,   //悬浮按钮
    BuryingFrom_Healthy,    //健康
} BuryingPointFromWhere;



typedef enum : NSUInteger {
    ///默认的数据
    LinkTypeDefault = 0,
    ///! 移动端点击该数据后跳转到普通h5页面
    LinkTypeH5 = 1,
    ///! 移动端点击该数据后跳转到小程序里
    LinkTypeMiniProgram = 2,
    ///! 跳转到活动h5页面
    LinkTypeActivity = 3,
    ///! 跳转到线上投保产品h5页面
    LinkTypeProductOnline = 4,
    ///跳转到预约投保产品h5页面。预约投保跳转h5产品页面，需要拼接字段agentCode=代理人工号&userName=用户姓名&userSex=用户性别（F为女 M为男）&userPhone=用户手机号
    LinkTypeProductOffline = 5,
    ///特殊活动,需要上传活动id
    LinkTypeSpecialActive = 6,
    ///! 双录产品，根据类型值判断跳转hyperlinks 或者hyperlinktwins
    LinkTypeProductAppointment = 8,
    ///!跳转视频医生页面
    LinkTypeVideoDoctor = 9,
    ///闪垫付
    LinkTypeLighting = 10,
    ///我的保单原生页面
    LinkType_NativeMyInsuranceCtrl = 101,
    ///保单变更原生页面
    LinkType_NativePolicyChangeListCtrl = 102,
    ///保单下载原生页面
    LinkType_NativePolicyDownloadCtrl = 103,
    ///自助理赔原生页面
    LinkType_NativeThumbTranslationCtrl = 104,
    ///理赔记录原生页面
    LinkType_NativeMyClaimCtrl = 105,
    ///同心抗疫原生页面
    LinkType_NativeContentricEpidemicCtrl = 106,
    ///518客户节原生页面
    LinkType_NativeCustomersDayCtrl = 107,
    ///投保资料原生页面
    LinkType_NativeInsuranceCtrl = 108,
    ///保险商城原生页面
    LinkType_NativeShoppingMallCtrl = 109,
    /// 直播列表原生页面
    LinkType_NativeLive = 110,
    ///首页-更多
    LinkType_HomeMore = 111,
    ///活动-活动列表
    LinkType_ActiveList = 112,

    //保单选择列表（万能账户查询）
    LinkType_NativePoliciesList = 113,
    
   
    //U+相关 +200
    /*
     4    寿险：直接购买 204
     5    寿险：预约投保
     8    寿险：双路产品
     11    健康险：直接购买
     12    健康险：预约投保
     13    财险：直接购买
     14    财险：预约投保
     */
    LinkType_U_LifeBuy = 204,
    LinkType_U_LifeBook = 205,
    LinkType_U_LifeDouble = 208,
    LinkType_U_HealthyBuy = 211,
    LinkType_U_HealthyBook = 212,
    LinkType_U_PropertyBuy = 213,
    LinkType_U_PropertyBook = 214,
    
} LinkType;

#endif /* PLEnumDefine_h */
