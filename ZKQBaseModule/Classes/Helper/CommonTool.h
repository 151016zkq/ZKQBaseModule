//
//  CommonTool.h
//  LifeInsurance
//
//  Created by zrq on 2018/9/20.
//  Copyright © 2018年 cn.picclife.  All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUIViewController.h"
typedef enum : NSUInteger {
    CertType_IdentityCardOfResidents = 1, //居民身份证
    CertType_TaiwanPass, //台湾居民来往大陆通行证
    CertType_Officers, //军人身份证件
    CertType_Passport, //护照
    CertType_BirthCert, //出生医学证明
    CertType_HKMacaoResidentPass, //港澳居民来往大陆通行证
    CertType_HouseholdRegistrarionBook, //户口簿
    CertType_ArmedPoliceIdentify, //武装警察身份证
    CertType_PermanentResidencePermit, //永久居留证
} CERTTYPE;

@interface CommonTool : NSObject

///判断空数据
+ (BOOL)isBlank:(id)obj;
/**
 根据文本个数返回控件宽度

 @param string 输入文本
 @return 文本控制的宽度
 */
+ (CGFloat)calculateRowWidth:(NSString *)string titleFont:(CGFloat)fontSize;




///md5加密
+ (NSString *)rimMd5:(NSString *)src;



///存储数据
+ (void)setObject:(id)object forKey:(NSString *)key;
///获取数据
+ (id)getObjectForKey:(NSString *)key;
///移除数据
+ (void)removeObjectForKey:(NSString *)key;

///存储数据
+ (void)setBool:(BOOL)object forKey:(NSString *)key;
///获取数据
+ (BOOL)getBoolForKey:(NSString *)key;
/**
 获取下一相对控件X坐标

 @param view 相对控件
 @param offSetX 偏移量
 @return X坐标
 */
+ (CGFloat)getNextX:(UIView *)view withMargin:(CGFloat)offSetX;
/**
 获取下一相对控件Y坐标
 
 @param view 相对控件
 @param offSetY 偏移量
 @return Y坐标
 */
+ (CGFloat)getNextY:(UIView *)view withMargin:(CGFloat)offSetY;
/**
 图片转换为字符串对象

 @param image <#image description#>
 @return <#return value description#>
 */
+ (NSString *)imageTransfer:(UIImage *)image;
/**
 字符串转换为图片对象

 @param imageStr <#imageStr description#>
 @return <#return value description#>
 */
+ (UIImage *)stringTransfer:(NSString *)imageStr;
/**
 证件类型码表的转换

 @param typeDescription <#typeDescription description#>
 @return <#return value description#>
 */
+ (NSInteger)transformString:(NSString *)typeDescription;

/**
 字典转字符串

 @param dict <#dict description#>
 @return <#return value description#>
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict;
///码值转字符串
+ (NSString *)transformDescription:(NSNumber *)typeDescription;
///码表转换
+ (NSString *)transformAccident:(NSString *)description;
///取手机号字段 无取username
+ (NSString *)getMobileOrUserName;
/**
 文件存储最近浏览记录

 @param cataType 浏览数组
 @param folder 文件夹名
 @param fileNam 文件名
 */
+(void)prepare:(id)cataType folder:(NSString *)folder fileName:(NSString *)fileNam;
/**
 读取浏览记录文件

 @param folder <#folder description#>
 @param fileName <#fileName description#>
 @return <#return value description#>
 */
+ (id )readFolder:(NSString *)folder fileName:(NSString *)fileName type:(NSInteger)type;
/**
 删除浏览记录文件

 @param folder <#folder description#>
 @param fileName <#fileName description#>
 */
+ (void)deleteFolder:(NSString *)folder fileName:(NSString *)fileName;
/**
 是否存在文件

 @param folder <#folder description#>
 @param fileName <#fileName description#>
 @return <#return value description#>
 */
+ (BOOL)isExistFolder:(NSString *)folder fileName:(NSString *)fileName;
/**
 获取到当前所在控制器

 @param application <#application description#>
 @return <#return value description#>
 */
+ (UIViewController *)presentingVC:(UIApplication *)application;

/**
 @brief 获取当前的APPDelegate主窗口的根控制器

 @param application <#application description#>
 @return <#return value description#>
 */
+ (UIViewController *)getMainRootVC:(UIApplication *)application;


#pragma mark - /*** Common Methods ***/

/**
 @brief 根据证件号码获取出生日期

 @param certNum 证件号
 */
+ (NSString *)getTheBirthDayWithCertNumber:(NSString *)certNum;


//注册两个键盘将出现和将隐藏的通知事件
+ (void)KeyboardWillShowSelector:(SEL)keyboardWillShow KeyboardWillHideNotificationSelector:(SEL)keyboardWillHide andWhichVC:(id)paramVC;

//移除键盘监听通知
+ (void)removeNotificationsOfKeyboardWithWhichVC:(id)paramVC;

/**
 @brief 是否包含中文

 @param string 原生字符串
 @return 包含中文为yes，否则为no
 */
+ (BOOL)containChinese:(NSString *)string;


/**
 @brief 获取纯字符字符串

 @param string 鱼龙混杂的字符串
 @return 纯字符去掉中文的字符串
 */
+ (NSString *)getTheCharacterString:(NSString *)string;

/**
 @brief 获取当前时间

 @return 返回当前时间戳
 */
+ (NSString *)getCurrentDateTime;


///计算一个人的生日距离今天的天数
+(NSString*)getDaysWithBithdateFromToday:(NSString *)bithdate;

//计算今年生日
+(NSString*)getDateStringWithBithdateOfCurYear:(NSString *)bithdate;

///计算一个人的年龄
+(NSString *)getAgeWithBirthdate:(NSDate *)bornDate compareDate:(NSDate *)compareDate;
///计算时间差
+ (NSString *)compareWith:(NSString *)startTime end:(NSString *)endTime;

//比较用户是否在今年过过生日
+ (NSInteger)getUserIsHadBirthDay:(NSDate *)birthDate compareDate:(NSDate *)compareDate;


#pragma mark - /*** 关于项目中加密处理的方法 ***/

//手机号密文显示
+ (NSString *)showPhoneStr:(NSString *)phoneStr;
//身份证密文显示
+ (NSString *)showIDCardStr:(NSString *)IDCardStr;
//银行卡密文显示1111*****1111
+ (NSString *)showBindCardStr:(NSString *)BindCardStr;
//密文显示，自定义开始、结束
+ (NSString *)showIDCardToEndStr:(NSString *)IDCardStr start:(NSInteger)startNum end:(NSInteger)endNum;

/**
 @brief 真实姓名密文显示

 @param realName 实名认证的真实姓名
 @return 加密后的真实姓名
 */
+ (NSString *)showSecretRealNameStr:(NSString *)realName;

+ (NSString *)checkRealNameIsAviable:(NSString *)realName;
///联系人校验
+ (NSString *)checkContactNameIsAviable:(NSString *)contactName;

 
/*1.时间今天返回 11：15 否则返回2. type是0(服务助手) 显示02-02 否则3.显示2020-02-02 11:15*/
+ (NSString *)getMessageShowDate:(NSString *)dateStr type:(NSString *)type;


/// 将日期转成年月日格式
/// @param dateStr 日期
/// @param type 类型
+ (NSString *)getMessageShowYMDDate:(NSString *)dateStr type:(NSString *)type;
#pragma mark - /*** 关于跳转h5链接地址里拼接符号处理 ***/

/**
 @brief 处理接口返回的链接h5中包含是否包含拼接符号的问题
 @author add by jins 2020.3.4
 
 @param originURL 接口返回的最原始的链接地址url
 @return 拼接后的链接地址
 */
+ (NSString *)getH5LinkAfterSigned:(NSString *)originURL;
+ (NSComparisonResult)compareNum1:(NSString *)num1 num2:(NSString *)num2;
/**
小写转大写方法
 */
+(NSString *)stringToUpper:(NSString *)str;

///时间格式转字符串格式
+(NSString*)getStrFromeDate:(NSDate *)date;

#pragma mark - /*** 融云获取token所需参数处理 ***/
//获取随机数
+(NSString *)getRandomNonce;

//获取时间戳 从1970年
+(NSString *)getTimestamp;

//sha1 加密
+(NSString *)sha1WithKey:(NSString *)key;

///获取入参加密后的str
+ (NSString *)getASEStringWithDict:(NSDictionary *)dict;

///我的礼包判断姓名是否正确
+(NSString*)checkNameFalse:(NSString *)text;
///判断输入手机号是否错误(type=1是机构特别奖，type= 2 是领取实物)
+ (NSString *)checkPhoneFalse:(NSString *)text index:(NSString *)index type: (int)type;

///解析url中的参数，生成NSMutableDictionary
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

//返回首页
+ (void)goBackHome:(BaseUIViewController *)currentVC;

//DES 加密,供减龄小程序用
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key;

@end
