//
//  UIFont+YYAdaptive.m
//  YiYo
//
//  Created by lq on 2017/6/8.
//  Copyright © 2017年 YiYo. All rights reserved.
//

#import "UIFont+YYAdaptive.h"
#import <objc/runtime.h>


@implementation UIFont (YYAdaptive)

+ (void)load {
    Method newMethod = class_getClassMethod([self class], @selector(adjustFontWithName:size:));
    Method method = class_getClassMethod([self class], @selector(fontWithName:size:));
    // 交换方法
    method_exchangeImplementations(newMethod, method);

    Method newSystemMethod = class_getClassMethod([self class], @selector(adjustSystemFontSize:));
    Method systemMethod = class_getClassMethod([self class], @selector(systemFontOfSize:));
    // 交换方法
    method_exchangeImplementations(newSystemMethod, systemMethod);

    Method newBoldMethod = class_getClassMethod([self class], @selector(adjustBoldSystemFontOfSize:));
    Method boldMethod = class_getClassMethod([self class], @selector(boldSystemFontOfSize:));
    // 交换方法
    method_exchangeImplementations(newBoldMethod, boldMethod);
}

//+ (UIFont *)adjustFontWithName:(NSString *)fontName size:(CGFloat)FontSize {
//    return [UIFont adjustFontWithName:fontName size:FontSize];
//}
//
//+ (UIFont *)adjustSystemFontSize:(CGFloat)fontSize {
//    
//    if ([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height) {
//        return [UIFont adjustSystemFontSize:fontSize];
//    }
//    return [UIFont adjustSystemFontSize:(fontSize * [UIScreen mainScreen].bounds.size.width / 375)];
//}
//
//+ (UIFont *)adjustBoldSystemFontOfSize:(CGFloat)fontSize {
//    
//    if ([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height) {
//        return [UIFont adjustSystemFontSize:fontSize];
//    }
//    return [UIFont adjustBoldSystemFontOfSize:(fontSize * [UIScreen mainScreen].bounds.size.width / 375)];
//}

@end
