//
//  NSDictionary+Extension.m
//  SmartPicc
//
//  Created by 李昂 on 2020/3/26.
//  Copyright © 2020 cn.picclife. All rights reserved.
//

#import "NSDictionary+Extension.h"



@implementation NSDictionary (Extension)
- (NSString *)safeStringForKey:(id)key
{
    if (key == nil) {
        return @"";
    }
    if ([[self allKeys] containsObject:key]) {
        id value = [self objectForKey:key];
        if (value == nil || value == NULL ||[value isKindOfClass:[NSNull class]]) {
            return @"";
        }
        return value;
    }
    return @"";
}


//解析推送数据
- (NSMutableDictionary *)analysePushData{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (id key in [self allKeys]) {
        NSLog(@"key = %@, value = %@", key, self[key]);
        if ([key isEqual:@"appData"]) {
            NSString * urlstr = [self objectForKey:@"appData"];
            NSDictionary * dic = [NSDictionary dictionaryWithJsonString:urlstr];
            for (NSString *key in dic.allKeys) {
                if ([key isEqualToString:@"activityUrl"]) {
                    [result setValue:dic[key] forKey:@"operate_link"];
                }else {
                    [result setValue:dic[key] forKey:key];
                }
                
            }
            
        }
        if ([key isEqualToString:@"aps"]) {
            
            NSString *body = self[@"aps"][@"alert"][@"body"]?:@"";
            [result setValue:body forKey:@"body"];
        }
        
    }
    return  result;
    
}
//1. JSON字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
