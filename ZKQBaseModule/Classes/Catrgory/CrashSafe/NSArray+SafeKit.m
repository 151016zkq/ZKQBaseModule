//
//  NSArray+SafeKit.m
//  SafeKitExample
//
//  Created by zhangyu on 14-2-28.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "NSArray+SafeKit.h"
#import "NSObject+swizzle.h"

@implementation NSArray (SafeKit)
#if CRASH_SAFE_ENABLED

- (instancetype)initWithObjects_safe:(id *)objects count:(NSUInteger)cnt {
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!objects[i]) {
            continue;
        }
        newCnt++;
    }
    self = [self initWithObjects_safe:objects count:newCnt];
    return self;
}

- (id)safe_objectAtIndex:(NSUInteger)index {
    NSLog(@"___function__%s",__func__);

    if (index >= [self count])
    {
        NSLog(@" 你的 NSArray数组已经越界了 safe_objectAtIndex 但是已经帮你处理好了  %ld   %ld", index, self.count);
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

- (NSArray *)safe_arrayByAddingObject:(id)anObject {
    NSLog(@"___function__%s",__func__);
    if (!anObject) {
        NSLog(@" 插入空数据 但是已经帮你处理好了  %@", anObject);
        return self;
    }
    return [self safe_arrayByAddingObject:anObject];
}

- (id)safeNSArrayI_objectAtIndex:(NSUInteger)index {
    NSLog(@"___function__%s",__func__);

    if (index >= [self count])
    {
        NSLog(@" 你的 NSArray数组已经越界了 safe_objectAtIndex 但是已经帮你处理好了  %ld   %ld", index, self.count);
        return nil;
    }
    return [self safeNSArrayI_objectAtIndex:index];
}

//add by jins 2020.4.16 fix 听云闪退 *** -[__NSArrayM objectAtIndexedSubscript:]: index 3 beyond bounds for empty array
- (NSArray *)safeNSArrayI_arrayByAddingObject:(id)anObject {
    NSLog(@"___function__%s",__func__);
    if (!anObject) {
        NSLog(@" 插入空数据 但是已经帮你处理好了  %@", anObject);
        return self;
    }
    return [self safeNSArrayI_arrayByAddingObject:anObject];
}

- (id)safeNSSingleObjectArrayI_objectAtIndex:(NSUInteger)index {

    if (index >= [self count])
    {
        NSLog(@" 你的 NSArray数组已经越界了 %s 但是已经帮你处理好了  %ld   %ld", __func__, index, self.count);
        return nil;
    }
    return [self safeNSSingleObjectArrayI_objectAtIndex:index];
}

//add by jins 2020.4.16 fix 听云闪退 *** -[__NSArrayM objectAtIndexedSubscript:]: index 3 beyond bounds for empty array
- (NSArray *)safeNSSingleObjectArrayI_arrayByAddingObject:(id)anObject {
    if (!anObject) {
        NSLog(@" 插入空数据 %s 但是已经帮你处理好了 %@", __func__,anObject);
        return self;
    }
    return [self safeNSSingleObjectArrayI_arrayByAddingObject:anObject];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(initWithObjects_safe:count:) tarClass:@"__NSPlaceholderArray" tarSel:@selector(initWithObjects:count:)];
        
        [self safe_swizzleMethod:@selector(safeNSArrayI_objectAtIndex:) tarClass:@"__NSArrayI" tarSel:@selector(objectAtIndex:)];
        [self safe_swizzleMethod:@selector(safeNSArrayI_arrayByAddingObject:) tarClass:@"__NSArrayI" tarSel:@selector(arrayByAddingObject:)];
        
        //add by jins 2020.4.16 fix 听云闪退 *** -[__NSArrayM objectAtIndexedSubscript:]: index 3 beyond bounds for empty array
        [self safe_swizzleMethod:@selector(safe_objectAtIndex:) tarClass:@"__NSArray0" tarSel:@selector(objectAtIndex:)];
        [self safe_swizzleMethod:@selector(safe_arrayByAddingObject:) tarClass:@"__NSArray0" tarSel:@selector(arrayByAddingObject:)];
        
        [self safe_swizzleMethod:@selector(safeNSSingleObjectArrayI_objectAtIndex:) tarClass:@"__NSSingleObjectArrayI" tarSel:@selector(objectAtIndex:)];
        [self safe_swizzleMethod:@selector(safeNSSingleObjectArrayI_arrayByAddingObject:) tarClass:@"__NSSingleObjectArrayI" tarSel:@selector(arrayByAddingObject:)];
    });
}

#endif
@end
