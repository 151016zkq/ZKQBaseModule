//
//  NSDate+Add.m
//  LifeInsurance
//
//  Created by zrq on 2018/11/1.
//  Copyright © 2018年 cn.picclife.  All rights reserved.
//

#import "NSDate+Add.h"


@implementation NSDate (Add)
#pragma mark - 获取当前的时间 精确到时分秒
+ (NSString *)currentDateString {
    return [self currentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
#pragma mark - 获取当前的时间 精确到天
+ (NSString *)currentDateDayString {
    return [self currentDateStringWithFormat:@"yyyy-MM-dd"];
}
#pragma mark - 按指定格式获取当前的时间
+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr {
    // 获取系统当前时间
    NSDate *currentDate = [self date];
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = formatterStr;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    // 输出currentDateStr
    return currentDateStr;
}

+ (NSString *)currentDateStringWithFormat:(NSString *)formatterStr afterDay:(NSInteger)day {
    // 获取系统当前时间
    NSDate *currentDate = [[self alloc] initWithTimeInterval:day * 24 * 3600 sinceDate:[self date]];
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = formatterStr;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    // 输出currentDateStr
    return currentDateStr;
}


+ (NSString *)getTimeNow {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    return date;
}
- (NSString *)getDateStr {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    return [format stringFromDate:self];
}
+(int)compareOneDay:(NSString *)oneDayStr withAnotherDay:(NSString *)anotherDayStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
//    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
//        NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){//A<B
        //NSLog(@"Date1 is in the past");
        return -1;
    }
//    NSLog(@"Both dates are the same");
    return 0;
    
}
+(int)compareTime:(NSString *)oneDayStr withAnotherTime:(NSString *)anotherDayStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    //    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

#pragma mark - 获取两个日期之间的所有日期数组
+ (NSArray*)getDatesWithStartDate:(NSString *)startDate endDate:(NSString *)endDate {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    
    //字符串转时间
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = @"yyyy-MM-dd";
    NSDate *start = [matter dateFromString:startDate];
    NSDate *end = [matter dateFromString:endDate];
    
    NSDate *mydate = [matter dateFromString:startDate];
    [matter setDateFormat:@"yyyy"];
    NSString *startDateString = [matter stringFromDate:mydate];
    NSMutableArray *componentAarray = [NSMutableArray array];
    NSComparisonResult result = [start compare:end];
    NSDateComponents *comps;
    while (result != NSOrderedDescending) {
//        comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitWeekday fromDate:start];
        comps = [calendar components:NSCalendarUnitYear fromDate:start];
//        [componentAarray addObject:start];
        [componentAarray addObject:startDateString];
        
        //后一天
//        [comps setDay:([comps day]+1)];
        [comps setYear:[comps year]+1];
        start = [calendar dateFromComponents:comps];
        startDateString = [matter stringFromDate:start];
        
        //对比日期大小
        result = [start compare:end];
    }
    NSArray *arrayReverse = [[componentAarray reverseObjectEnumerator] allObjects];//逆序
    if (arrayReverse.count<4) {//小于4就从起始年份开始递减4个年份
        NSMutableArray *array = [NSMutableArray array];
        NSDateFormatter *matter = [[NSDateFormatter alloc] init];
        matter.dateFormat = @"yyyy-MM-dd";
        NSDate *mydate = [matter dateFromString:startDate];
        [matter setDateFormat:@"yyyy"];
        NSString *startDateString = [matter stringFromDate:mydate];
        NSInteger year = [startDateString integerValue];
        for (int i = 4; i > 0; i--) {
            [array addObject:[NSString stringWithFormat:@"%ld",year]];
            year--;
        }
        return array;
    }
    return arrayReverse;
}

+ (BOOL)judgeAgeIsEnought:(int)tagetAge birth:(NSString *)birthdate{
    NSString *currentDate = [self currentDateDayString];
    NSArray<NSString *> *currentDataArr = [currentDate componentsSeparatedByString:@"-"];
    NSArray<NSString *> *birthDataArr = [birthdate componentsSeparatedByString:@"-"];
    if (currentDataArr.count == 3 && birthDataArr.count == 3) {
        int currentyear = [currentDataArr[0] intValue];
        int currentMonth = [currentDataArr[1] intValue];
        int currentDay = [currentDataArr[2] intValue];
        
        int birthYear = [birthDataArr[0] intValue];
        int birthMonth = [birthDataArr[1] intValue];
        int birthDay = [birthDataArr[2] intValue];
        if ((currentyear - birthYear) > tagetAge) {
            return true;
        }else if (currentyear - birthYear == tagetAge) {
            if (currentMonth > birthMonth) {
                return  true;
            }else if (currentMonth == birthMonth){
                if (currentDay > birthDay) {
                    return  true;
                }else {
                    return  false;
                }
            }else {
                return  false;
            }
            
        }else {
            return false;
        }


    }else {
        return  false;
    }
}

@end
