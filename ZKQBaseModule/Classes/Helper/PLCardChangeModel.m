//
//  PLCardChangeModel.m
//  SmartPicc
//
//  Created by 李昂 on 2019/12/23.
//  Copyright © 2019 cn.picclife. All rights reserved.
//

#import "PLCardChangeModel.h"
#import "UIStringMacros.h"
//@interface PLCardChangeModel()
///** 识别出来的证件号码 */
//@property (nonatomic, copy) NSString *recognizedCarNumber;
///** 识别出来的证件有效期 */
//@property (nonatomic, copy) NSString *recognizedValidity;
///** 识别出来的姓名 */
//@property (nonatomic, copy) NSString *recognizedName;
//
///** 填写的证件号码 */
//@property (nonatomic, copy) NSString *filledCarNumber;
///** 填写的证件有效期 */
//@property (nonatomic, copy) NSString *filledValidity;
///** 填写的名字 */
//@property (nonatomic, copy) NSString *filledName;
//@end

@implementation PLCardChangeModel

+ (NSError *)checkChangeErrorWithRecognizedName:(NSString *)recognizedName recognizedCarNumber:(NSString *)recognizedCarNumber recognizedValidity:(NSString *)recognizedValidity filledName:(NSString *)filledName filledCarNumber:(NSString *)filledCarNumber filledValidity:(NSString *)filledValidity
{
    
    if (![self checkfilledValidity:filledValidity]) {
        return [NSError errorWithDomain:@"" code:7 userInfo:@{NSLocalizedDescriptionKey:@"您的证件不在有效期内，请提供有效证件。"}];
    }
    
//    if (filledName.length != recognizedName.length) {
//        return [NSError errorWithDomain:@"" code:0 userInfo:@{NSLocalizedDescriptionKey:@"姓名不能删除或增加字体,您可重新拍摄识别。"}];
//    }
    
    if ([self changeCountBetween:recognizedName and:filledName] > 1) {
        return [NSError errorWithDomain:@"" code:1 userInfo:@{NSLocalizedDescriptionKey:@"姓名最多可修改一个汉字,您可重新拍摄识别。"}];
    }
    
    
    
    if (![self isIDCardNumber:filledCarNumber]) {
        return [NSError errorWithDomain:@"" code:5 userInfo:@{NSLocalizedDescriptionKey:@"您的证件号码有误,您可重新拍摄识别。"}];
    }
    
    if (![recognizedValidity containsString:Cert_LongTerm] && [filledValidity containsString:Cert_LongTerm]) {
        ///您的身份证有效期止期有误，请核实。@"您的证件不在有效期内，请提供有效证件"
        return [NSError errorWithDomain:@"" code:6 userInfo:@{NSLocalizedDescriptionKey:@"您的身份证有效期止期有误，请核实。"}];
    }
    
    
    if ([self changeCountBetween:[recognizedCarNumber substringWithRange:NSMakeRange(6, 8)] and:[filledCarNumber substringWithRange:NSMakeRange(6, 8)]] > 2) {
        return [NSError errorWithDomain:@"" code:2 userInfo:@{NSLocalizedDescriptionKey:@"生日位（第7至第14位）最多修改2位，您可重新拍摄识别。"}];
    }
    if ([self changeCountBetween:[recognizedCarNumber substringWithRange:NSMakeRange(14, 4)] and:[filledCarNumber substringWithRange:NSMakeRange(14, 4)]] > 1) {
        return [NSError errorWithDomain:@"" code:3 userInfo:@{NSLocalizedDescriptionKey:@"最后四位最多可修改1位数字或字母，您可重新拍摄识别。"}];
    }
    if ([self changeCountBetween:recognizedCarNumber and:filledCarNumber] > 5) {
        return [NSError errorWithDomain:@"" code:4 userInfo:@{NSLocalizedDescriptionKey:@"证件号码最多可修改5位数字或字母，您可重新拍摄识别。"}];
    }
    if (![self checkValidity:filledValidity isAviableWithBirthday:[filledCarNumber substringWithRange:NSMakeRange(6, 8)]]) {
        //"@"您的身份证有效期止期有误，请核实。"
        return [NSError errorWithDomain:@"" code:6 userInfo:@{NSLocalizedDescriptionKey:@"您的身份证有效期止期有误，请核实。"}];
    }
    
    
    
    
    return nil;
}
///实时提示身份证姓名字段
+ (NSError *)showError:(NSString *)recognizedName textFieldString:(NSString *)filledName
{
    if ([self changeCountBetween:recognizedName and:filledName] > 1)
    {
        return [NSError errorWithDomain:@"" code:1 userInfo:@{NSLocalizedDescriptionKey:@"姓名最多可修改一个汉字,您可重新拍摄识别。"}];
    }
    return nil;
}
///实时提示证件号字段
+ (NSError *)showNumberError:(NSString *)recognizedCarNumber textFieldString:(NSString *)filledCarNumber
{
   /*
    1.证件号码生日位的8位中，最多修改2位，7-14
    2.最后4位，最多修改一位 15-18
    3.累计修改最多五位
    */
    if (filledCarNumber.length >= 6 && filledCarNumber.length <= 18)
    {
      NSString *compareString = [filledCarNumber substringWithRange:NSMakeRange(0, filledCarNumber.length)];
        NSString *numString = [recognizedCarNumber substringWithRange:NSMakeRange(0, recognizedCarNumber.length)];
        int diffFlag = 0;
        for (int i = 0 ; i < compareString.length; i ++) {
            unichar numCharactor = [numString characterAtIndex:i];
            unichar compareCharactor = [compareString characterAtIndex:i];
            NSString *numString = [NSString stringWithFormat:@"%C", numCharactor];
             NSString *compareString = [NSString stringWithFormat:@"%C", compareCharactor];
            if (![numString isEqualToString:compareString]) {
                //标记累加
                diffFlag += 1;
            }
        }
        if (diffFlag > 5) {
             return [NSError errorWithDomain:@"" code:4 userInfo:@{NSLocalizedDescriptionKey:@"证件号码最多可修改5位数字或字母，您可重新拍摄识别。"}];
        }
    }
    if (filledCarNumber.length >= 7 && filledCarNumber.length <= 18) {
      NSString *compareString = [filledCarNumber substringWithRange:NSMakeRange(6, filledCarNumber.length - 6)];
      NSString *numString = [recognizedCarNumber substringWithRange:NSMakeRange(6, recognizedCarNumber.length -6)];
        int diffFlag = 0;
        for (int i = 0 ; i < compareString.length; i ++) {
            unichar numCharactor = [numString characterAtIndex:i];
            unichar compareCharactor = [compareString characterAtIndex:i];
            NSString *numString = [NSString stringWithFormat:@"%C", numCharactor];
             NSString *compareString = [NSString stringWithFormat:@"%C", compareCharactor];
            if (![numString isEqualToString:compareString]) {
                //标记累加
                diffFlag += 1;
            }
        }
        if (diffFlag > 2) {
            return [NSError errorWithDomain:@"" code:2 userInfo:@{NSLocalizedDescriptionKey:@" 生日位（第7至第14位）最多修改2位，您可重新拍摄识别。"}];
        }
    }
    
    if (filledCarNumber.length >= 15 && filledCarNumber.length <= 18) {
      NSString *compareString = [filledCarNumber substringWithRange:NSMakeRange(14, filledCarNumber.length - 14)];
        NSString *numString = [recognizedCarNumber substringWithRange:NSMakeRange(14, 4)];
        int diffFlag = 0;
        for (int i = 0 ; i < compareString.length; i ++) {
            unichar numCharactor = [numString characterAtIndex:i];
            unichar compareCharactor = [compareString characterAtIndex:i];
            NSString *numString = [NSString stringWithFormat:@"%C", numCharactor];
             NSString *compareString = [NSString stringWithFormat:@"%C", compareCharactor];
            if (![numString isEqualToString:compareString]) {
                //标记累加
                diffFlag += 1;
            }
        }
        if (diffFlag > 1) {
            return [NSError errorWithDomain:@"" code:3 userInfo:@{NSLocalizedDescriptionKey:@"最后四位最多可修改1位数字或字母，您可重新拍摄识别。"}];
        }
    }
    return nil;
}
+ (BOOL)checkfilledValidity:(NSString *)Validity
{
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy.MM.dd"];
    NSArray *Validitys = [Validity componentsSeparatedByString:@"-"];
    NSDate *startDate = [dateFormatter1 dateFromString:Validitys.firstObject];
    NSDate *endDate = [dateFormatter1 dateFromString:Validitys.lastObject];
    NSDate *now = [NSDate date];
    if ([[now earlierDate:endDate] isEqual:endDate]) {
        return NO;
    }
    if ([[now earlierDate:startDate] isEqual:now]) {
        return NO;
    }
    return YES;
}

+ (BOOL)isIDCardNumber:(NSString *)number
{
    if (number.length != 18) return NO;
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|[Xx])$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityStringPredicate evaluateWithObject:number];
}

+ (NSInteger)changeCountBetween:(NSString *)string1 and:(NSString *)string2
{
    NSInteger count = 0;
    NSInteger nunber1 = string1.length;
    NSInteger nunber2 = string2.length;
    count = labs(nunber1-nunber2);
    if (count > 1) {
        return count;
    }
    NSInteger shortlen = (nunber1+nunber2-count)/2;
    for (int i=0; i<shortlen; i++) {
        if (![[string1 substringWithRange:NSMakeRange(i, 1)] isEqualToString:[string2 substringWithRange:NSMakeRange(i, 1)]]) {
            count++;
        }
    }
    return count;
}

+ (BOOL)checkValidity:(NSString *)Validity isAviableWithBirthday:(NSString *)birthday
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *birthday_date = [dateFormatter dateFromString:birthday];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy.MM.dd"];
    NSArray *Validitys = [Validity componentsSeparatedByString:@"-"];
    NSDate *startDate = [dateFormatter1 dateFromString:Validitys.firstObject];
    NSDate *endDate = [dateFormatter1 dateFromString:Validitys.lastObject];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *delta_birth = [calendar components:unit fromDate:birthday_date toDate:startDate options:0];
    NSLog(@".......delta_birth:%@",delta_birth);
    if ([Validity containsString:Cert_LongTerm]) {
        return delta_birth.year>=46;
    }
    
    NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    NSLog(@".......delta:%@",delta);
    if (delta_birth.year < 16) {
        return delta.year <= 4 || (delta.year==5&&(delta.month+delta.day) == 0);
    }else if (delta_birth.year >= 16 && delta_birth.year <= 25) {
        return delta.year <= 9 || (delta.year==10&&(delta.month+delta.day) == 0);
    }else if (delta_birth.year >= 26 && delta_birth.year <= 45) {
        return delta.year <= 19 || (delta.year==20&&(delta.month+delta.day) == 0);
    }else{
        return [Validity containsString:Cert_LongTerm];
    }
}
+ (BOOL)DataValidityTime:(NSString *)startTimer end:(NSString *)endTimer{
    
    /*
     1、开始时间小于等于当前时间，结束时间大于等于当前时间
     2、结束时间 !<= 开始时间
     3、开始时间小于结束时间
     */
    if([startTimer isEqualToString:endTimer]){
        
        return NO;
    }
    
    NSString * start = [startTimer stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSString * end = [endTimer stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSDate  *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger year=[components year];
    NSInteger month=[components month];
    NSInteger day=[components day];
    
    NSString * dayStr = [NSString stringWithFormat:@"%02ld",day];
    NSString * monthStr = [NSString stringWithFormat:@"%02ld",month];
    NSString * dateStr = [NSString stringWithFormat:@"%ld%@%@",year,monthStr,dayStr];
        
    if([start intValue] > [dateStr intValue]){
        return NO;
    }
    
    if([endTimer isEqualToString:Cert_LongTerm]){
        return YES;
    }else{
        if([start intValue] >= [end intValue]){
            return NO;
        }
        
        if([end intValue] < [dateStr intValue]){
            return NO;
        }
    }
    return YES;
}
@end
