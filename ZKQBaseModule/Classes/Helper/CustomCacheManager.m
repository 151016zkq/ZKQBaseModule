//
//  CustomCacheManager.m
//  labor
//
//  Created by 张凯强 on 2022/9/1.
//  Copyright © 2022 ZKWQY. All rights reserved.
//

#import "CustomCacheManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation CustomCacheManager
+ (BOOL)needRequest:(NSString *)url parameter:(nullable NSDictionary *) param isRefresh:(BOOL)isRefresh isReadCash:(BOOL)isReadCash{
    //设置了缓存,如果没有设置缓存时间,默认3分钟缓存时间
    NSString *path = [CustomCacheManager cacheFilePath:url paramet:param];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //检测文件路径存不存在
    BOOL isFileExist = [fileManager fileExistsAtPath:path isDirectory:nil];
    
    //如果没达到指定日期返回-1，刚好是这一时间，返回0，否则返回1
    NSInteger time = [CustomCacheManager compareCurrentTime:[CustomCacheManager getCurrentTime:24 * 60] withFileCreatTime:[CustomCacheManager getFileCreateTime:url paramet:param]];
//    强制刷新需要重新请求
    if (isRefresh) {
        return true;
    }
    //    不读取缓存需要重新请求
    if (!isReadCash) {
        return true;
    }
//    文件不存在需要重新请求
    if (!isFileExist) {
//        文件不存在需要重新请求
        return true;
    }
//    不需要重新刷新，文件存在。但是超过了缓存时间
    if (isFileExist && !isRefresh  && time == 1) {
        //        不需要重新请求
        return true;
    }


    return false;

}





/**
 将数据存储到本地,验证是否符合json字段类型
 
 @param responseData 网络请求获取的数据
 */
+(void)saveCashDataForArchiver:(id)responseData jsonValidator:(nullable id)jsonValidator hostUrl:(NSString *)hostUrl paramet:(nullable NSDictionary *)paramet{
    NSString *path = [CustomCacheManager cacheFilePath:hostUrl paramet:paramet];
    if (responseData != nil) {
        @try {
            if (jsonValidator) {
                //如果有格式验证就进行验证
                BOOL result = [CustomCacheManager validateJSON:responseData withValidator: jsonValidator];
                if (result) {
                    //字段验证成功,进行缓存
                    if ([responseData isKindOfClass:[NSDictionary class]]) {
                        
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseData options:0 error:nil];
                        [jsonData writeToFile:path atomically:true];
                    }else if ([responseData isKindOfClass:[NSData class]]) {
                        [responseData writeToFile:path atomically:true];
                    }
                }else{
                    //格式不正确
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    //检测文件路径存不存在
                    BOOL isFileExist = [fileManager fileExistsAtPath:path isDirectory:nil];
                    if (isFileExist) {
                        //如果文件存在,肯定是老数据,把文件删掉
                        NSError *error = nil;
                        [fileManager removeItemAtPath:path error:&error];
                    }
                }
            }else{
                //没有验证直接存储
                if ([responseData isKindOfClass:[NSDictionary class]]) {
                    
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseData options:0 error:nil];
                    [jsonData writeToFile:path atomically:true];
                }else if ([responseData isKindOfClass:[NSData class]]) {
                    [responseData writeToFile:path atomically:true];
                }
            }
        } @catch (NSException *exception) {
            NSLog(@"Save cache failed, reason = %@", exception.reason);
        }
    }
}

//获取新的数据
+ (nullable NSDictionary*)getNewDataForCash:(NSString *)path param:(nullable id)param{
//    获取labor中的最新数据
//    首先判断是否需要重新请求
    //设置了缓存,如果没有设置缓存时间,默认3分钟缓存时间
    NSString *filePath = [CustomCacheManager cacheFilePath:path paramet:param];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //检测文件路径存不存在
    BOOL isFileExist = [fileManager fileExistsAtPath:filePath isDirectory:nil];
    
    if (isFileExist) {
//        文件存在
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return  result;
    }else {
        return nil;
    }

    
}
//获取当前时间
+ (NSDate *)getCurrentTime:(NSInteger)cashTime{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    NSTimeInterval time = (cashTime == 0 ? 3 * 60 : cashTime * 60);
    NSDate *currentTime = [date dateByAddingTimeInterval:-time];
    return currentTime;
}
//获取文件夹创建时间
+ (NSDate *)getFileCreateTime:(NSString *)hostUrl paramet:(nullable NSDictionary *)paramet{
    NSString *path = [CustomCacheManager cacheFilePath:hostUrl paramet:paramet];
    NSError * error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //通过文件管理器来获得属性
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:&error];
    NSDate *fileCreateDate = [fileAttributes objectForKey:NSFileCreationDate];
    return fileCreateDate;
}


//根据url和参数创建路径
+ (NSString *)cacheFilePath:(NSString *)hostUrl paramet:(nullable NSDictionary *)paramet{
    NSString *cacheFileName = [CustomCacheManager cacheFileName:hostUrl paramet:paramet];
    NSString *path = [CustomCacheManager cacheBasePath];
    path = [path stringByAppendingPathComponent:cacheFileName];
    return path;
}

//将请求路径和参数拼接成文件名称
+ (NSString *)cacheFileName:(NSString *)hostUrl paramet:(nullable NSDictionary *)paramet{
    NSString *requestInfo = [NSString stringWithFormat:@"%@%@",hostUrl, (paramet == nil) ? @{}:paramet];
    return [CustomCacheManager md5StringFromString:requestInfo];
}
///创建根路径 -文件夹
+ (NSString *)cacheBasePath {
    //放入cash文件夹下,为了让手机自动清理缓存文件,避免产生垃圾
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"labor"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
    return path;
}
//创建文件夹
+(void)createBaseDirectoryAtPath:(NSString *)path{
    NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
}


// 是否wifi
//+ (BOOL)isEnableWIFI{
//    
//    BOOL iswifi = NO;
//    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi){
//        
//        iswifi = YES;
//    }
//    return iswifi;
//}
//
//// 是否3G
//+ (BOOL)isEnableWWAN{
//    
//    BOOL noNet = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable;
//    
//    BOOL wifi = [AFNetworkReachabilityManager sharedManager].isReachableViaWWAN;
//    
//    if (noNet && wifi)//有网且不是wifi
//        return YES;
//    else
//        return NO;
//    
//    
//}
////网络是否可用
//+ (BOOL)isNoNet{
//    
//    BOOL noNet = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable;
//    if (noNet) {
//        return YES;
//    }
//    else
//        return NO;
//}


//md5加密
+ (NSString *)md5StringFromString:(NSString *)string {
    NSParameterAssert(string != nil && [string length] > 0);
    
    const char *value = [string UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

//如果没达到指定日期返回-1，刚好是这一时间，返回0，否则返回1
+ (NSInteger)compareCurrentTime:(NSDate *)currentTime withFileCreatTime:(NSDate *)fileCreatTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:currentTime];
    NSString *anotherDayStr = [dateFormatter stringFromDate:fileCreatTime];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"currentTime : %@, fileCreatTime : %@", currentTime, fileCreatTime);
    NSInteger aa = 0;
    if (result == NSOrderedDescending) {
        //文件创建时间超过当前时间,刷新数据
        aa = 1;
    }
    else if (result == NSOrderedAscending){
        //文件创建时间小于当前时间,返回缓存数据
        aa = -1;
    }
    //NSLog(@"Both dates are the same");
    return aa;
    
}

//json字段检验
+ (BOOL)validateJSON:(id)json withValidator:(id)jsonValidator {
    if ([json isKindOfClass:[NSDictionary class]] &&
        [jsonValidator isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dict = json;
        NSDictionary * validator = jsonValidator;
        BOOL result = YES;
        NSEnumerator * enumerator = [validator keyEnumerator];
        NSString * key;
        while ((key = [enumerator nextObject]) != nil) {
            id value = dict[key];
            id format = validator[key];
            if ([value isKindOfClass:[NSDictionary class]]
                || [value isKindOfClass:[NSArray class]]) {
                result = [self validateJSON:value withValidator:format];
                if (!result) {
                    break;
                }
            } else {
                if ([value isKindOfClass:format] == NO &&
                    [value isKindOfClass:[NSNull class]] == NO) {
                    result = NO;
                    break;
                }
            }
        }
        return result;
    } else if ([json isKindOfClass:[NSArray class]] &&
               [jsonValidator isKindOfClass:[NSArray class]]) {
        NSArray * validatorArray = (NSArray *)jsonValidator;
        if (validatorArray.count > 0) {
            NSArray * array = json;
            NSDictionary * validator = jsonValidator[0];
            for (id item in array) {
                BOOL result = [self validateJSON:item withValidator:validator];
                if (!result) {
                    return NO;
                }
            }
        }
        return YES;
    } else if ([json isKindOfClass:jsonValidator]) {
        return YES;
    } else {
        return NO;
    }
}


@end
