//
//  NSMutableArray+SafeKit.m
//  SafeKitExample
//
//  Created by zhangyu on 14-3-13.
//  Copyright (c) 2014年 zhangyu. All rights reserved.
//

#import "NSMutableArray+SafeKit.h"
#import "NSObject+swizzle.h"

@implementation NSMutableArray (SafeKit)
#if CRASH_SAFE_ENABLED

- (void)safe_addObject:(id)anObject {
    if (!anObject) {
        return;
    }
    [self safe_addObject:anObject];
}

- (void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > [self count]) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self safe_insertObject:anObject atIndex:index];
}

//add by jins 2020.4.16 fix 听云闪退 *** -[__NSArrayM objectAtIndexedSubscript:]: index 3 beyond bounds for empty array
- (id)safe_objectAtIndexedSubscript:(NSUInteger)index{
    if (index < self.count) {
        return [self safe_objectAtIndexedSubscript:index];
    }else{
        NSLog(@" 你的 NSMutableArray数组已经越界了 但是已经帮你处理好了  %ld   %ld", index, self.count);
        return nil;
    }
}

- (void)safe_removeObjectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return;
    }
    
    return [self safe_removeObjectAtIndex:index];
}
- (void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index >= [self count]) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self safe_replaceObjectAtIndex:index withObject:anObject];
}

- (void)safe_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)array
{
    if (range.location >= [self count] || range.location + range.length > [self count]) {
        return;
    }
    if (![array count]) {
        return;
    }
    [self safe_replaceObjectsInRange:range withObjectsFromArray:array];
}

- (void)safe_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)array range:(NSRange)otherRange
{
    if (range.location >= [self count] || range.location + range.length > [self count] || otherRange.location >= [array count] ||  otherRange.location + otherRange.length > [array count]) {
        return;
    }
    if (![array count]) {
        return;
    }
    [self safe_replaceObjectsInRange:range withObjectsFromArray:array range:otherRange];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self safe_swizzleMethod:@selector(safe_addObject:) tarClass:@"__NSArrayM" tarSel:@selector(addObject:)];
        [self safe_swizzleMethod:@selector(safe_insertObject:atIndex:) tarClass:@"__NSArrayM" tarSel:@selector(insertObject:atIndex:)];
        [self safe_swizzleMethod:@selector(safe_removeObjectAtIndex:) tarClass:@"__NSArrayM" tarSel:@selector(removeObjectAtIndex:)];
        [self safe_swizzleMethod:@selector(safe_replaceObjectAtIndex:withObject:) tarClass:@"__NSArrayM" tarSel:@selector(replaceObjectAtIndex:withObject:)];
        [self safe_swizzleMethod:@selector(safe_objectAtIndexedSubscript:) tarClass:@"__NSArrayM" tarSel:@selector(objectAtIndexedSubscript:)];
        [self safe_swizzleMethod:@selector(safe_replaceObjectsInRange:withObjectsFromArray:) tarClass:@"__NSArrayM" tarSel:@selector(replaceObjectsInRange:withObjectsFromArray:)];
        [self safe_swizzleMethod:@selector(safe_replaceObjectsInRange:withObjectsFromArray:range:) tarClass:@"__NSArrayM" tarSel:@selector(replaceObjectsInRange:withObjectsFromArray:range:)];
        
    });
}
#endif
@end
