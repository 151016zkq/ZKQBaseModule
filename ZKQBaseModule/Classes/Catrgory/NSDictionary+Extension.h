//
//  NSDictionary+Extension.h
//  SmartPicc
//
//  Created by 李昂 on 2020/3/26.
//  Copyright © 2020 cn.picclife. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Extension)
- (NSString *)safeStringForKey:(id)key;
///处理推送过来的消息
- (NSMutableDictionary *)analysePushData;
///json字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end

NS_ASSUME_NONNULL_END
