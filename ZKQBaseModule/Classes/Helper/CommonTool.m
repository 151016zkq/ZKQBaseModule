//
//  CommonTool.m
//  LifeInsurance
//
//  Created by zrq on 2018/9/20.
//  Copyright © 2018年 cn.picclife.  All rights reserved.
//

#import "CommonTool.h"
#import "BaseNavBarController.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"
#import "AESCipher.h"
#import <CommonCrypto/CommonCryptor.h>
#import "MJRefresh.h"
#import "APIStringMacros.h"
#import "NSString+Add.h"
#import "NSObject+Add.h"
@interface CommonTool ()
//按钮点击
@property (nonatomic, copy) void (^reloadBlock)(UIButton *sender);
@end


@implementation CommonTool
+ (CGFloat)calculateRowWidth:(NSString *)string titleFont:(CGFloat)fontSize {
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

/**
 *  判断空类型
 */
+ (BOOL)isBlank:(id)obj {
    if (obj == nil || obj == NULL) {
        return YES;
    }
    if ([obj isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = obj;
        if (array.count == 0) {
            return YES;
        }
    }
    //fix by liuyi: 输入为空的没判断
    if ([obj isKindOfClass:[NSString class]]) {
        if ([[obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
            return YES;
        }
    }

    return NO;
}
//存储数据
+ (void)setObject:(id)object forKey:(NSString *)key {
    if ([CommonTool isBlank:key])
    {
        return;
    }
    
    if ([object isKindOfClass:[NSNull class]]) {
        object = @"";
    }
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获取数据
+ (id)getObjectForKey:(NSString *)key
{
    if ([CommonTool isBlank:key])
    {   //修复听云上的闪退+[CommonTool getObjectForKey:] (CommonTool.m:0) 对key值为nil做防护
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
//移除数据
+ (void)removeObjectForKey:(NSString *)key
{
    if ([CommonTool isBlank:key])
    {   //修复听云上的闪退+[CommonTool getObjectForKey:] (CommonTool.m:0) 对key值为nil做防护
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//存储BOOL类型
+ (void)setBool:(BOOL)object forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//获取BOOL类型
+ (BOOL)getBoolForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}
+ (NSString *)rimMd5:(NSString *)src {
    if (src == nil) {
        return @"";
    }
    const char *cStr = [src UTF8String];
    unsigned char result[16];
    size_t len = strlen(cStr);
    CC_MD5(cStr, (uint32_t)len, result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}



+ (CGFloat)getNextX:(UIView *)view withMargin:(CGFloat)offSetX {
    return view.mj_x + view.mj_w + offSetX;
}
+ (CGFloat)getNextY:(UIView *)view withMargin:(CGFloat)offSetY {
    return view.mj_y + view.mj_h + offSetY;
}
+ (NSString *)imageTransfer:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+ (UIImage *)stringTransfer:(NSString *)imageStr {
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:imageData];
}
///证件码表的转换
+ (NSInteger)transformString:(NSString *)typeDescription{
    /////1为身份证，2为军官证，3为护照，4为户口本，5港澳台回乡证，6出生证，7外国人永久居留身份证
    if ([typeDescription isEqualToString:@"居民身份证"]) {
        return 1;
    }else if ([typeDescription isEqualToString:@"军官证"]) {
        return 2;
    }else if ([typeDescription isEqualToString:@"护照"]) {
        return 3;
    }else if ([typeDescription containsString:@"户口"]) {
        return 4;
    }else if ([typeDescription isEqualToString:@"港澳台回乡证"]) {
        return 5;
    }else if ([typeDescription isEqualToString:@"出生证"]) {
        return 6;
    }else{
        ///外国人永久居留身份证
        return 7;
    }
}
///码值转字符串
+(NSString *)transformDescription:(NSNumber *)number{
    if ([number integerValue] == 1) {
        return @"居民身份证";
    }else if ([number integerValue] == 2){
        return @"军人身份证件";
    }else if ([number integerValue] == 3){
        return @"护照";
    }else if ([number integerValue] == 4){
        return @"出生医学证明";
    }else if ([number integerValue] == 5){
        return @"异常身份证";
    }else if ([number integerValue] == 6){
        return @"港澳居民来往内地通行证";
    }else if ([number integerValue] == 7){
        return @"户口薄";
    }else if ([number integerValue] == 8){
        return @"武装警察身份证件";
    }else if ([number integerValue] == 9){
        return @"其它";
    }else if ([number integerValue] == 10){
        return @"台湾居民来往大陆通行证";
    }else if ([number integerValue] == 11){
        return @"外国人永久居留身份证";
    }else{
        return @"";
    }
}

//+ (NSString *)transformDescription:(NSNumber *)typeDescription{
//    if ([typeDescription isEqual:@(1)]) {
//        return @"居民身份证";
//    }else if ([typeDescription isEqual:@(2)]) {
//        return @"军官证";
//    }else if ([typeDescription isEqual:@(3)]) {
//        return @"护照";
//    }else if ([typeDescription isEqual:@(4)]) {
//        return @"户口本";
//    }else if ([typeDescription isEqual:@(5)]) {
//        return @"港澳台回乡证";
//    }else if ([typeDescription isEqual:@(6)]) {
//        return @"出生证";
//    }else{
//        ///外国人永久居留身份证
//        return @"外国人永久居留身份证";
//    }
//}
+ (NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        NSLog(@"%@", error);
        
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0, jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0, mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}
///码表转换
+ (NSString *)transformAccident:(NSString *)description{
    NSString *resultStr;
    resultStr = [description stringByReplacingOccurrencesOfString:@"A1" withString:@"意外医疗门诊"];
    resultStr = [resultStr stringByReplacingOccurrencesOfString:@"A2" withString:@"意外医疗津贴"];
    resultStr = [resultStr stringByReplacingOccurrencesOfString:@"A3" withString:@"意外医疗住院"];
    resultStr = [resultStr stringByReplacingOccurrencesOfString:@"B1" withString:@"非意外医疗住院"];
    resultStr = [resultStr stringByReplacingOccurrencesOfString:@"B2" withString:@"非意外医疗津贴"];
    return resultStr;
}
+ (NSString *)getMobileOrUserName{
  return   [self getObjectForKey:userMobile]?[self getObjectForKey:userNam]:[self getObjectForKey:userMobile];
}
+(void)prepare:(id)cataType folder:(NSString *)folder fileName:(NSString *)fileNam{
    //创建文件夹的路径
    NSString *testPath = [kPathDocument stringByAppendingPathComponent:folder];
    //创建目录
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL rest = [fileManager createDirectoryAtPath:testPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (rest) {
        NSLog(@"文件夹创建成功:%@",testPath);
    }else{
        NSLog(@"文件夹创建失败");
    }
    NSString *fileName = [testPath stringByAppendingPathComponent:fileNam];
    BOOL res = [fileManager createFileAtPath:fileName contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功");
    }else{
        NSLog(@"文件创建失败");
    }
    BOOL result = [cataType writeToFile:fileName atomically:true];
    if (result) {
        NSLog(@"文件写入成功");
    }else{
        NSLog(@"文件写入失败");
    }
}
+ (id )readFolder:(NSString *)folder fileName:(NSString *)fileName type:(NSInteger)type{
    NSString *testDirectory = [kPathDocument stringByAppendingPathComponent:folder];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:fileName];
    id result;
    if (type == 0) {
        result = [NSDictionary dictionaryWithContentsOfFile:testPath];
    }else{
        result = [NSArray arrayWithContentsOfFile:testPath];
    }
    return result;
}
+ (void)deleteFolder:(NSString *)folder fileName:(NSString *)fileName{
    NSString *testDirectory = [kPathDocument stringByAppendingPathComponent:folder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [testDirectory stringByAppendingPathComponent:fileName];
    BOOL res=[fileManager removeItemAtPath:filePath error:nil];
    if (res) {
        NSLog(@"文件删除成功");
    }else
        NSLog(@"文件删除失败");
    NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:filePath]?@"YES":@"NO");
}
+ (BOOL)isExistFolder:(NSString *)folder fileName:(NSString *)fileName{
    NSString *testDirectory = [kPathDocument stringByAppendingPathComponent:folder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [testDirectory stringByAppendingPathComponent:fileName];
    // YES 存在   NO 不存在
    BOOL isYES = [fileManager fileExistsAtPath:filePath];
    return isYES;
}

//获取到当前所在的视图
+ (UIViewController *)presentingVC:(UIApplication *)application{
    UIWindow * window = application.keyWindow;
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[BaseNavBarController class]]) {
        result = [(BaseNavBarController *)result topViewController];
    }
    return result;
}

+(UIViewController *)getMainRootVC:(UIApplication *)application
{
    UIWindow * window = application.keyWindow;
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    return result;
}


#pragma mark - /*** Common Methods ***/

/**
 @brief 根据证件号码获取出生日期
 
 @param certNum 证件号
 */
+ (NSString *)getTheBirthDayWithCertNumber:(NSString *)certNum
{
    NSString *birth = @"";
    if (certNum.length == 18)
    {
        birth = [NSString stringWithFormat:@"%@-%@-%@",[certNum substringWithRange:NSMakeRange(6, 4)],[certNum substringWithRange:NSMakeRange(10, 2)],[certNum substringWithRange:NSMakeRange(12, 2)]];
    }
    return birth;
}

//注册两个键盘将出现和将隐藏的通知事件
+ (void)KeyboardWillShowSelector:(SEL)keyboardWillShow KeyboardWillHideNotificationSelector:(SEL)keyboardWillHide andWhichVC:(id)paramVC{
    //注册键盘弹起与收起通知
    [[NSNotificationCenter defaultCenter] addObserver:paramVC
                                             selector:keyboardWillShow
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:paramVC
                                             selector:keyboardWillHide
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

+ (void)removeNotificationsOfKeyboardWithWhichVC:(id)paramVC
{
    [[NSNotificationCenter defaultCenter] removeObserver:paramVC name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:paramVC name:UIKeyboardWillHideNotification object:nil];
}


+ (BOOL)containChinese:(NSString *)string
{
    for(int i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

//获取纯英文字符串
+ (NSString *)getTheCharacterString:(NSString *)string
{
    NSString *theEndStr = @"";
    NSString *temp = nil;

    for(int i = 0; i < [string length]; i++){
        
        int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            continue;
        }
        temp = [string substringWithRange:NSMakeRange(i, 1)];
        theEndStr = [theEndStr stringByAppendingString:temp];
    }
    return theEndStr;
}

+ (NSString *)getCurrentDateTime
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [format stringFromDate:[NSDate date]];
}
+(NSDate*)getdateFromDateStr:(NSString*)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
    
}
///时间格式转字符串格式
+(NSString*)getStrFromeDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
    
}
///计算一个人的生日距离今天的天数
+(NSString*)getDaysWithBithdateFromToday:(NSString *)bithdate{
    
    NSRange range=[bithdate rangeOfString:@"-"];
    if (range.length>0) {
        bithdate=[bithdate stringByReplacingOccurrencesOfString:@"-" withString:@"-"];
    }
    NSDate *today=[NSDate date];

    NSString *todaystr=[CommonTool getStrFromeDate:today];
    today = [CommonTool getdateFromDateStr:todaystr];
    
    NSString *year=[todaystr componentsSeparatedByString:@"-"][0];
    
    NSArray *bithdateArr=[bithdate componentsSeparatedByString:@"-"];
    
    NSString *futuredatestr=[NSString stringWithFormat:@"%@-%@-%@",year,bithdateArr[1],bithdateArr[2]];
    NSDate  *futuredate=[CommonTool getdateFromDateStr:futuredatestr];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:futuredate];
    futuredate = [futuredate  dateByAddingTimeInterval: interval];
    
    NSInteger intervaltoday = [zone secondsFromGMTForDate:today];
    today = [today  dateByAddingTimeInterval: intervaltoday];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents    * comp = [calendar components:NSCalendarUnitDay
                                             fromDate:today
                                               toDate:futuredate
                                              options:NSCalendarWrapComponents];
    
    
    
    NSString *days=[NSString stringWithFormat:@"%ld",comp.day];
    return days;
    
    
}

+(NSString *)getDateStringWithBithdateOfCurYear:(NSString *)bithdate
{
    NSRange range=[bithdate rangeOfString:@"-"];
    if (range.length>0) {
        bithdate=[bithdate stringByReplacingOccurrencesOfString:@"-" withString:@"-"];
    }
    NSDate *today=[NSDate date];
    
    NSString *todaystr=[CommonTool getStrFromeDate:today];
    
    NSString *year=[todaystr componentsSeparatedByString:@"-"][0];
    
    NSArray *bithdateArr=[bithdate componentsSeparatedByString:@"-"];
    
    NSString *futuredatestr=[NSString stringWithFormat:@"%@-%@-%@",year,bithdateArr[1],bithdateArr[2]];
//    NSDate  *futuredate=[CommonTool getdateFromDateStr:futuredatestr];
    return futuredatestr;
}

+(NSString *)getAgeWithBirthdate:(NSDate *)bornDate compareDate:(NSDate *)compareDate{
    
    //获得当前系统时间
    
    NSDate *currentDate = compareDate; //创建日历(格里高利历)
    NSCalendar *calendar = [NSCalendar currentCalendar]; //设置component的组成部分
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ; //按照组成部分格式计算出生日期与现在时间的时间间隔
    NSDateComponents *date = [calendar components:unitFlags fromDate:bornDate toDate:currentDate options:0]; //判断年龄大小,以确定返回格式
    if( [date year] > 0) {
        return [NSString stringWithFormat:(@"%ld"),(long)[date year]];
    }else
        
        return [NSString stringWithFormat:@"0"];
    
    
}

+(NSInteger)getUserIsHadBirthDay:(NSDate *)birthDate compareDate:(NSDate *)compareDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMdd"];
    NSString *birthDay = [formatter stringFromDate:birthDate];
    
    NSString *curDay = [formatter stringFromDate:compareDate];
    
    return birthDay.intValue > curDay.intValue ? -1 : 0;
}

+ (NSString *)compareWith:(NSString *)startTime end:(NSString *)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    
    [date setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *endD = [date dateFromString:endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = end - start;
    
    int second = (int)value %60;//秒
    
    int minute = (int)value /60%60;
    
    int house = (int)value / (24 *3600)%3600;
    
    int day = (int)value / (24 *3600);
    
    NSString *str;
    
    if (day != 0) {
        
        str = [NSString stringWithFormat:@"%d",day];
        
    }else if (day==0 && house !=0) {
        
        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
        
    }else if (day==0 && house==0 && minute!=0) {
        
        str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
        
    }else{
        
        str = [NSString stringWithFormat:@"耗时%d秒",second];
        
    }
    return str;
}

+ (NSString *)showPhoneStr:(NSString *)phoneStr{
    NSString *newStr;
    if (phoneStr.length > 0) {
        //空格先去掉
        phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (phoneStr.length>10) {
            //分两节123 4567 8900
            NSString *strFirst = [phoneStr substringToIndex:3];
            NSString *strLast = [phoneStr substringFromIndex:7];
            //*号****
            newStr = [NSString stringWithFormat:@"%@%@%@",strFirst,@"****",strLast];
           }else{
               newStr = phoneStr;
           }
    }else{
        return @"";
    }
    return newStr;
}
+ (NSString *)showIDCardStr:(NSString *)IDCardStr{
    NSString *newStr;
    if (IDCardStr.length > 0) {
        //空格先去掉
        IDCardStr = [IDCardStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (IDCardStr.length> 4) {

             NSString *strFirst = [IDCardStr substringToIndex:IDCardStr.length - 4];
             newStr = [NSString stringWithFormat:@"%@%@",strFirst,@"****"];
           }else{
               newStr = IDCardStr;
           }
    }else{
        return @"";
    }
    return newStr;
}
+ (NSString *)showIDCardToEndStr:(NSString *)IDCardStr start:(NSInteger)startNum end:(NSInteger)endNum{
    NSString *newStr;
    if (IDCardStr.length > 0) {
        //空格先去掉
        IDCardStr = [IDCardStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (IDCardStr.length > 2) {

            NSRange r2 = NSMakeRange(startNum, endNum);
            NSString *strFirst = [IDCardStr substringWithRange:r2];
            NSString * star = @"";
            for (int i = 0; i < strFirst.length; i++) {
                star = [star stringByAppendingString:@"*"];
            }
            newStr = [IDCardStr stringByReplacingOccurrencesOfString:strFirst withString:star];
           }else{
               newStr = IDCardStr;
           }
    }else{
        return @"";
    }
    return newStr;
}
+ (NSString *)showBindCardStr:(NSString *)BindCardStr{
    NSString *newStr;
    if (BindCardStr.length > 0) {
        //空格先去掉
        BindCardStr = [BindCardStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (BindCardStr.length>8) {

            for(int i =0; i < [BindCardStr length]; i++)
            {
                if (i>3 && i< BindCardStr.length - 4) {
                    BindCardStr = [BindCardStr stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
                
                }
            }
            //*号****
            newStr = BindCardStr;
           }else{
               newStr = BindCardStr;
           }
    }else{
        return @"";
    }
    return newStr;
}

+ (NSString *)showSecretRealNameStr:(NSString *)realName
{
    NSString *newStr;
    if (realName.length > 0)
    {
        //空格先去掉
        realName = [realName stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if (realName.length > 1)
        {
            for (int i = 1; i < realName.length; i++)
            {
                realName = [realName stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
            }
            newStr = realName;
        }else
        {
            newStr = realName;
        }
    }else
    {
        return @"";
    }
    return newStr;
}

+ (NSString *)checkRealNameIsAviable:(NSString *)realName
{
    if (realName.length > 18) {
        return @"姓名长度不可超过18位";
    }
    if (realName.length < 2) {
        return @"姓名长度不可少于2位";
    }
    NSString *regex = @"^[a-zA-z\u4e00-\u9fa5•· ]{2,18}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![predicate evaluateWithObject:realName]) {
        return @"姓名首尾位置仅能录入汉字或字母，仅姓名中间位置可录入中间点，缩写点或空格！";
    }
    if ([realName hasPrefix:@"•"] || [realName hasPrefix:@"·"] || [realName hasSuffix:@"•"] || [realName hasSuffix:@"·"] || [realName containsString:@"••"] || [realName containsString:@"··"] || [realName hasPrefix:@" "] || [realName hasSuffix:@" "] || [realName containsString:@"  "]) {
        return @"姓名首尾位置仅能录入汉字或字母，仅姓名中间位置可录入中间点，缩写点或空格！";
    }
    
    //如果姓名里面不同位置嵌入多个点也给阻断回来 add by jins 2020.2.15
    NSArray *arrBigDot = [realName componentsSeparatedByString:@"·"];
    NSArray *arrSmallDot = [realName componentsSeparatedByString:@"•"];
    if ((arrBigDot.count  > 2) || arrSmallDot.count > 2 || (arrBigDot.count + arrSmallDot.count > 3))
    {
        return @"姓名首尾位置仅能录入汉字或字母，仅姓名中间位置可录入中间点，缩写点或空格！";
    }
    
    return @"";
}

+ (NSString *)checkContactNameIsAviable:(NSString *)contactName
{
    if (contactName.length > 10) {
        return @"联系人姓名不可超过10位";
    }
    if (contactName.length < 1) {
        return @"请输入联系人姓名";
    }
    NSString *regex = @"^[\u4e00-\u9fa5a-zA-Z•·]{1,10}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![predicate evaluateWithObject:contactName]) {
        return @"联系人姓名仅支持汉字、字母和中间点";
    }
    return @"";
}

///判断输入姓名是否错误(存在错误的情况下返回提示语句)
+(NSString*)checkNameFalse:(NSString *)text {
    if (!text) {
        return @"姓名不能为空";
    }
    

    if (text.length > 10) {
        return @"姓名不可超过10位";
    }
    NSString *nameError = [CommonTool checkContactNameIsAviable:text];
    if (nameError.length > 0) {
        return @"姓名仅支持汉字、字母和中间点";
    }
    return nil;
}
///判断输入手机号是否错误(type=1是机构特别奖，type= 2 是领取实物)
+ (NSString *)checkPhoneFalse:(NSString *)text index:(NSString *)index type: (int)type {
    if (!text || text.length != 11) {
        NSString *msg = [NSString stringWithFormat:@"%@录入的手机号码位数必须为11位数字",index];
        if (index.length == 0) {
            if (type == 1) {
                msg = @"联系方式位数必须为11位数字";
            }
            if (type == 2) {
                msg = @"电话位数必须为11位数字";
            }
        }
        return msg;
    }
    //判断后9位是否一样
    NSString *subText = [text substringFromIndex:2];
    NSString *firstStr = [subText substringToIndex:1];
    BOOL isEqual = true;
    for (int i = 0; i < subText.length; i++) {
        NSString *indexStr = [subText substringWithRange:NSMakeRange(i, 1)];
        if (![indexStr isEqualToString:firstStr]) {
            isEqual = false;
        }
    }
    if (isEqual) {
        NSString *msg = [NSString stringWithFormat:@"%@录入的手机号码后9位不得全部相同",index];
        if (index.length == 0) {
            if (type == 1) {
                msg = @"联系方式后9位不得全部相同";
            }
            if (type == 2) {
                msg = @"电话后9位不得全部相同";
            }
        }
        return msg;
    }
    if (![text evaluateStringWithType:RegexMobile]){
        NSString *msg = nil;
        if (type == 1) {
            msg = @"联系方式校验失败，请重新输入";
        }
        if (type == 2) {
            msg = @"电话校验失败，请重新输入";
        }
        return msg;
    }
    return nil;
}

/*type 2:首页-服务头条显示2010-10-10*/
/*1.时间今天返回 11：15 否则返回2. type是0 显示02-02 否则3.显示2020-02-02 11:15*/
/*type 0:服务助手 1:生活服务列表*/
+ (NSString *)getMessageShowDate:(NSString *)dateStr type:(NSString *)type{
    if (!dateStr) {
        return @"";
    }
    if (dateStr.length>10) {
        //2020-02-28 09:58 date格式
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];

        if ([type intValue] == 2){
            //02-02
            NSRange range = NSMakeRange(0, 10);
            return [dateStr substringWithRange:range];
        }
        
        NSString *todayStr = [dateFormatter stringFromDate:[NSDate date]];
        if ([dateStr containsString:todayStr]) {
            //09:58 截取空格之后
            return [dateStr substringFromIndex:10];
        }
        if ([type intValue] == 0){
            //02-02
            NSRange range = NSMakeRange(5, 5);
            return [dateStr substringWithRange:range];
        }
        if ([type intValue] == 1){
            return dateStr;
        }
        
    }
    return dateStr;
}

+ (NSString *)getMessageShowYMDDate:(NSString *)dateStr type:(NSString *)type{
    if (!dateStr) {
        return @"";
    }
    if (dateStr.length>10) {
        //2020-02-28 09:58 date格式
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        
        NSString *todayStr = [dateFormatter stringFromDate:[NSDate date]];
        
        NSRange Yrange = NSMakeRange(4, 1);
        NSRange Mrange = NSMakeRange(7, 1);
        NSRange Drange = NSMakeRange(10, 1);
        
        dateStr = [dateStr stringByReplacingCharactersInRange:Yrange withString:@"年"];
        dateStr = [dateStr stringByReplacingCharactersInRange:Mrange withString:@"月"];
        dateStr = [dateStr stringByReplacingCharactersInRange:Drange withString:@"日"];

        NSMutableString* str1=[[NSMutableString alloc]initWithString:dateStr];//存在堆区，可变字符串
        [str1 insertString:@" "atIndex:11];//把一个字符串插入另一个字符串中的某一个位置
        
        if ([str1 containsString:todayStr]) {
            //09:58 截取空格之后
            return [str1 substringFromIndex:11];
        }
        if ([type intValue] == 0){
            //02-02
            NSRange range = NSMakeRange(5, 5);
            return [str1 substringWithRange:range];
        }
        if ([type intValue] == 1){
            return str1;
        }
        if ([type intValue] == 2){
            //02-02
            NSRange range = NSMakeRange(0, 10);
            return [str1 substringWithRange:range];
        }
        
    }
    return dateStr;
}

#pragma mark - /*** 关于跳转h5链接地址里拼接符号处理 ***/

/**
 @brief 处理接口返回的链接h5中包含是否包含拼接符号的问题
 
 @param originURL 接口返回的最原始的链接地址url
 @return 拼接后的链接地址
 */
+ (NSString *)getH5LinkAfterSigned:(NSString *)originURL
{
    NSString *strURL = originURL;
    NSRange range = [strURL rangeOfString:@"?"];
    //如果接口返回的链接地址里有拼接"?"
    if ((range.location != NSNotFound))
    {
        //如果接口返回的链接地址里拼接的问好“?”在最后一位，则直接返回链接地址
        if (range.location == strURL.length - 1)
        {
            return strURL;
        }else
        {
            //如果接口返回的链接地址里拼接的问好“?”不在最后一位，则在链接地址后面拼接上与&符合
            //判断最后一位是否是&
            if (![strURL hasSuffix:@"&"]) {
                //没有&的情况下拼接
                return [strURL stringByAppendingString:@"&"];
            }
            //有&的情况下
            return  strURL;
        }
    }
    //如果接口返回的链接地址里没有拼接问号则需要再链接地址最后拼上问号“?”返回
    return [strURL stringByAppendingString:@"?"];
}

+ (NSComparisonResult)compareNum1:(NSString *)num1 num2:(NSString *)num2{
    NSDecimalNumber *one = [NSDecimalNumber decimalNumberWithString:num1];
    NSDecimalNumber *two = [NSDecimalNumber decimalNumberWithString:num2];
    NSComparisonResult result = [one compare:two];
    return result;
}

+(NSString *)stringToUpper:(NSString *)str{
    for(NSInteger i =0 ; i < str.length ; i++){
        if([str characterAtIndex:i] >='a'&[str characterAtIndex:i] <='z') {
            char temp = [str characterAtIndex:i] -32;
            NSRange range =NSMakeRange(i,1);
            str = [str stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%c",temp]];
        }
    }
    return str;
}


//获取随机数6位
+(NSString *)getRandomNonce
{
    NSInteger randomValue = (NSInteger)(100000 + (arc4random() % (999999 - 100001)));
    return  [NSString stringWithFormat:@"%ld",randomValue];
}


//获取时间戳 从1970年
+(NSString *)getTimestamp
{
    NSDate *date = [NSDate date];
    NSTimeInterval times =  [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",times];
}

//sha1 加密
+(NSString *)sha1WithKey:(NSString *)key
{
        const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
        NSData *data = [NSData dataWithBytes:cstr length:key.length];
        
        uint8_t digest[CC_SHA1_DIGEST_LENGTH];
        
        CC_SHA1(data.bytes, data.length, digest);
        
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
        
        for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
            [output appendFormat:@"%02x", digest[i]];
        }
        
        return output;
}


//获取入参加密后的str
+ (NSString *)getASEStringWithDict:(NSDictionary *)dict{
    //加密
    NSString *AESstr = [CommonTool convertToJsonData:dict];
    NSLog(@"入参加密前：%@",AESstr);
    AESstr = [AESCipher aesEncryptString:AESstr key:AESSecretKey];
    AESstr = [AESstr stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    NSLog(@"入参加密后：%@",AESstr);

    return AESstr;
}



#pragma mark - 解析url中的参数，生成NSMutableDictionary
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

//返回首页
+ (void)goBackHome:(BaseUIViewController *)currentVC{
    
    for (UIViewController *vc in currentVC.navigationController.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(@"PLHomeModule.PLServiceViewController")]) {
            [currentVC.navigationController popToViewController:vc animated:YES];
        }
    }
}

//DES 加密
+ (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

@end
