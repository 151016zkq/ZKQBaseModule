//
//  NSString+Add.h
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef enum:NSUInteger {
    RegexPhone,           //电话
    RegexEmail,           //邮箱
    RegexMobile,          //手机
    RegexNumber,          //数字
    RegexInteger,         //整数
    RegexIntegerNegative, //负整数
    RegexIntegerPositive, //正整数
    RegexDouble,          //浮点数
    RegexDoubleNegative,  //负浮点数
    RegexDoublePositive,  //正浮点数
    RegexWord,            //字母
    RegexWordNum,         //字母+数字
    RegexSpecialSymbol,   //特殊符号
    RegexDateNormal,      //日期
    RegexUrl,             //URL
    RegexIP,              //IP
    RegexIDCardNo,        //身份证
    RegexOrgCode,
    RegexAge,         //年龄
    RegexZipCode,     //邮编
    RegexChineseName, //中文名称
    RegexBankCard,    //银行卡
    RegexPassword,    //密码
    RegexVistorName,  //专家姓名
    RegexRealName,    //真实姓名
    RegexNickName,    //用户昵称
    RegexDetailAddress, //详细地址，仅支持中文、英文、数字、特殊符号
    RegexBirthNo,//出生证
} RegexType;


@interface NSString (Add)

//时间戳转换成时间年月日
- (NSString *)timeStampToYearDate;
//时间戳变为格式时间
+(NSString *)ConvertStrToTime:(NSString *)timeStr;
//时间转时间戳的方法
- (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
//时间戳转换成时间年月日时分秒
- (NSString *)timeStampToHourDate;

//获取当地时间
+ (NSString *)getCurrentTime;

//将字符串转成NSDate类型
+ (NSDate *)dateFromString:(NSString *)dateString;

//传入今天的时间，返回明天的时间
+ (NSString *)getTomorrowDay:(NSDate *)aDate;

- (BOOL)evaluateStringWithType:(RegexType)type;
+ (BOOL)evaluateStringWithType:(RegexType)type WithString:(NSString *)string;

//固话校验 中间带-
- (BOOL)isTelephoneNum;
/**
 身份证正则判断
 */
- (BOOL)isValidateIdentity;
//判断是否是纯汉字
+ (BOOL)isChineseWithString:(NSString *)string;

#pragma mark 字典转json字符串方法
+ (NSString *)convertToJsonString:(NSDictionary *)dict;
#pragma mark JSON字符串转化为字典
+ (NSDictionary *)convertToDictionary:(NSString *)jsonString;

#pragma mark 判断后台返回的时间戳是否过期 YES过期
- (BOOL)isTimeExpiration;

//获取html 字符串里面的所有图片地址
- (NSArray *)filterImage;

//----正则----
- (BOOL)matchRegex:(NSString *)regex;


// 将str加密成本地保存的文件名
+ (NSString *)md5String:(NSString *)str;
- (NSString *)md5;

- (NSString *)firstPinYin;

//是否为空
- (BOOL)isEmpty;
/**
 compare two version
 @param sourVersion *.*.*.*
 @param desVersion *.*.*.*
 @returns No,sourVersion is less than desVersion; YES, the statue is opposed
 */
+ (BOOL)compareVerison:(NSString *)sourVersion withDes:(NSString *)desVersion;

//当前字符串是否只包含空白字符和换行符
- (BOOL)isWhitespaceAndNewlines;

///去除字符串前后的空白,不包含换行符
- (NSString *)trim;
+ (NSString *)trimWithString:(NSString *)string;

//去除字符串中所有空白
- (NSString *)removeWhiteSpace;
- (NSString *)removeNewLine;
//! 计算字符长度
- (NSInteger)unicodeLenth;
//将字符串以URL格式编码
- (NSString *)stringByUrlEncoding:(NSString *)encodeUrlString;


/*!
 @brief     大写第一个字符
 @return    格式化后的字符串
 */
- (NSString *)capitalize;

//以给定字符串开始,忽略大小写
- (BOOL)startsWith:(NSString *)str;
//以指定条件判断字符串是否以给定字符串开始
- (BOOL)startsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions;


//以给定字符串结束，忽略大小写
- (BOOL)endsWith:(NSString *)str;
//以指定条件判断字符串是否以给定字符串结尾
- (BOOL)endsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

//包含给定的字符串, 忽略大小写
- (BOOL)containsString:(NSString *)str;
//以指定条件判断是否包含给定的字符串
- (BOOL)containsString:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

//判断字符串是否相同，忽略大小写
- (BOOL)equalsString:(NSString *)str;


- (NSString *)emjoiText;


#pragma mark Hashing
#if kSupportGTM64
- (NSString *)base64Encoding;
#endif

- (NSString *)valueOfLabel:(NSString *)label;

- (NSString *)substringAtRange:(NSRange)rang;

// 是否带有表情符
- (NSUInteger)utf8Length;
- (BOOL)isContainsEmoji;

//! 计算字符长度
- (NSUInteger)charactorNumber;

//递归计算符合规定的文本长度
- (NSString *)cutBeyondTextInLength:(NSInteger)maxLenth;

- (CGSize)textSizeIn:(CGSize)size font:(UIFont *)font;
- (CGSize)textSizeIn:(CGSize)size font:(UIFont *)font breakMode:(NSLineBreakMode)breakMode;
- (CGSize)textSizeIn:(CGSize)size font:(UIFont *)font breakMode:(NSLineBreakMode)breakMode align:(NSTextAlignment)alignment;

// 将数字转为每隔3位整数由逗号“,”分隔的字符串   prefix可以是 @"￥"   suffix可以是 @"元"
- (NSString *)separateNumberUseCommaWithPrefix:(NSString *)prefix andSuffix:(NSString *)suffix;

/**
 *  拼音 -> pinyin
 */
- (NSString *)transformToPinyin;

/**
 *  拼音首字母 -> py
 */
- (NSString *)transformToPinyinFirstLetter;
/**
 URL编码

 @return <#return value description#>
 */
- (NSString *)URLEncodedString;

/// 字符串Unicode编码
/// @param string <#string description#>
+(NSString *) toUnicode:(NSString *)string;


/**
@param str 数字字符串
@return 筛选出数字字符串
*/
//获取文字里的数字字符串
+ (NSString *)getNumberFromStr:(NSString *)str;



/// 生成网络请求加密随机数
/// @param timestamp 时间戳
+(NSString *)getNetSecret:(NSString *)timestamp;

//8位字符串分隔成yyyy-mm-dd
+(NSString *)getDateString:(NSString *)numString;
///对应的是js中escape编码的解码方法
+ (NSString *)unesp:(NSString *)src;

//Escape加密
NSString *esp(NSString * src);
///根据url了解拼接的参数。返回一个字典
+(NSDictionary *)queryURLParams:(NSString *_Nullable)urlStr;
@end
NS_ASSUME_NONNULL_END
