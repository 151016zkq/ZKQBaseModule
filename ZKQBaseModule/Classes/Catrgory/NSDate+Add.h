//
//  NSDate+Add.h
//  LifeInsurance
//
//  Created by zrq on 2018/11/1.
//  Copyright © 2018年 cn.picclife.  All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSDate (Add)
/** 获取当前的时间 精确到时分秒*/
+ (NSString *)currentDateString;
///获取当前的时间 精确到天
+ (NSString *)currentDateDayString;
///获取当前时间精确到毫秒
+ (NSString *)getTimeNow;
///date 转字符串
- (NSString *)getDateStr;
///根据格式获取对应的时间
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr;
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr afterDay:(NSInteger)day;
///日期比较大小
+(int)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr;
///时间比较大小
+(int)compareTime:(NSString *)oneDayStr withAnotherTime:(NSString *)anotherDayStr;
///获取两个日期之间的所有日期数组
+ (NSArray*)getDatesWithStartDate:(NSString *)startDate endDate:(NSString *)endDate;
///判断年龄满足规定的年龄
+ (BOOL)judgeAgeIsEnought: (int)tagetAge birth: (NSString *)birthdate;
@end

NS_ASSUME_NONNULL_END
