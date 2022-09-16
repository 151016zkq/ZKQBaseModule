//
//  NSDictionary+SafeKit.m
//  SafeKitExample
//
//  Created by 张宇 on 16/2/19.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import "NSDictionary+SafeKit.h"
#import "NSObject+swizzle.h"

@implementation NSDictionary (SafeKit)
#if CRASH_SAFE_ENABLED

-(instancetype)initWithObjects_safe:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    
    id safeObjects[cnt];
    id safeKeys[cnt];
    
    NSUInteger newCnt = 0;
    
    for (NSUInteger i = 0; i < cnt; i++) {
        
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        
        if (!obj) {
            obj = [NSNull null];
        }
        
        safeKeys[newCnt] = key;
        safeObjects[newCnt] = obj;
 
        newCnt++;
    }
    self = [self initWithObjects_safe:safeObjects forKeys:safeKeys count:newCnt];
    return self;
}

- (void)dictionaryWithObjects_safe:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    
    id safeObjects[cnt];
    id safeKeys[cnt];
    
    NSUInteger newCnt = 0;
    
    for (NSUInteger i = 0; i < cnt; i++) {
        
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        safeKeys[newCnt] = key;
        safeObjects[newCnt] = obj;
        
        newCnt++;
    }
    return [self dictionaryWithObjects_safe:safeObjects forKeys:safeKeys count:newCnt];
    
}


+ (void) load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(initWithObjects_safe:forKeys:count:) tarClass:@"__NSPlaceholderDictionary" tarSel:@selector(initWithObjects:forKeys:count:)];
        
        [self safe_swizzleMethod:@selector(dictionaryWithObjects_safe:forKeys:count:) tarClass:@"__NSPlaceholderDictionary" tarSel:@selector(dictionaryWithObjects:forKeys:count:)];
        
    });
}
#endif
@end
