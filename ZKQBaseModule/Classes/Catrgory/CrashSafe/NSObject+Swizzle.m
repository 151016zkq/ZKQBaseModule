//
//  NSObject+swizzle.m
//  SafeKitExample
//
//  Created by zhangyu on 14-3-13.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>
#import "SafeKitMacro.h"

@implementation NSObject(Swizzle)
#if CRASH_SAFE_ENABLED
+ (void)safe_swizzleMethod:(SEL)srcSel tarSel:(SEL)tarSel{
    Class clazz = [self class];
    [self safe_swizzleMethod:clazz srcSel:srcSel tarClass:clazz tarSel:tarSel];
}

+ (void)safe_swizzleMethod:(SEL)srcSel tarClass:(NSString *)tarClassName tarSel:(SEL)tarSel{
    if (!tarClassName) {
        return;
    }
    Class srcClass = [self class];
    Class tarClass = NSClassFromString(tarClassName);
    [self safe_swizzleMethod:srcClass srcSel:srcSel tarClass:tarClass tarSel:tarSel];
}

+ (void)safe_swizzleMethod:(Class)srcClass srcSel:(SEL)srcSel tarClass:(Class)tarClass tarSel:(SEL)tarSel{
    if (!srcClass) {
        return;
    }
    if (!srcSel) {
        return;
    }
    if (!tarClass) {
        return;
    }
    if (!tarSel) {
        return;
    }
    
    Method srcMethod = class_getInstanceMethod(srcClass,srcSel);
    Method tarMethod = class_getInstanceMethod(tarClass,tarSel);
    
    class_addMethod(srcClass,
                    srcSel,
                    class_getMethodImplementation(self, srcSel),
                    method_getTypeEncoding(srcMethod));
    class_addMethod(tarClass,
                    tarSel,
                    class_getMethodImplementation(self, tarSel),
                    method_getTypeEncoding(tarMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(srcClass, srcSel), class_getInstanceMethod(tarClass, tarSel));
}
#endif
@end
