//
//  CTMediator+Addition.m
//  PLServiceModule
//
//  Created by xu xiaodan on 2020/7/8.
//

#import "CTMediator+Addition.h"
#import <objc/message.h>
#import <BaseModule/BaseModule-Swift.h>

//nsstring
static __inline__ __attribute__((always_inline)) BOOL verifiedString(id strlike) {
    if (strlike && ![strlike isEqual:[NSNull null]] && [[strlike class] isSubclassOfClass:[NSString class]] && ((NSString*)strlike).length > 0) {
        return YES;
    }else{
        return NO;
    }
}
NSString *const kCTMediatorActionPrefix = @"Action_";
NSString *const kCTMediatorActionSuffix = @":";
NSString *const kCTMediatorTargetPrefix = @"Target_";
NSString * const kCTMediatorTargetCommons = @"commons";
NSMapTable *routeMap = nil;


@implementation CTMediator (Addition)

/**
* 通过vc类的名字创建vc,默认的vc创建函数为createVC:
*
* @param actionName vc类名称
*
* @param params 创建vc初始化要传递的参数
*
* @param shouldCacheTarget 是否需要缓存target，一般传NO
*
* @return vc的实例
*
*/
- (id)performAction:(NSString *)actionName params:(nullable NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget{
    
    NSString *selName = @"createVC:";
    NSString *sel = [routeMap objectForKey:actionName];
    if (verifiedString(sel)) selName = sel;
    
    return [self performAction:actionName dstSel:selName params:params shouldCacheTarget:shouldCacheTarget];
}
/**
* 通过vc类的名字创建vc
*
* @param actionName vc类名称
*
* @param dstSelName vc中实现的创建vc的函数，不要在这个方法中使用self关键字，获取当前类名则
* 通过使用getClassFromAtcion(_cmd)来获取
*
* @param params 创建vc初始化要传递的参数
*
* @param shouldCacheTarget 是否需要缓存target，一般传NO
*
* @return vc的实例
*
*/
- (id)performAction:(NSString *)actionName dstSel:(NSString *)dstSelName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget{
    
    Class class = NSClassFromString(actionName);
    SEL sel = NSSelectorFromString(dstSelName);
    IMP imp = [class instanceMethodForSelector:sel];
    if (!imp || imp == _objc_msgForward) {
        imp = [class methodForSelector:sel];
    }
    SEL selector = NSSelectorFromString(enActionFuncName(actionName));
    const char *clsName = [[NSString stringWithFormat:@"%@%@",kCTMediatorTargetPrefix,kCTMediatorTargetCommons] UTF8String];
    Class targetCls = objc_getClass(clsName);
    
    if (!targetCls){
        Class superClass = [NSObject class];
        targetCls = objc_allocateClassPair(superClass, clsName, 0);
        objc_registerClassPair(targetCls);
    }
    
    if (!class_respondsToSelector(targetCls, selector)) {
        BOOL flag = class_addMethod(targetCls, selector, imp, "@@:@");
        if (!flag) {
            return nil;
        }
    }
    
    id action = [self performTarget:kCTMediatorTargetCommons action:actionName params:params shouldCacheTarget:shouldCacheTarget];
    
    return [action isKindOfClass:class] ? action : nil;
}


@end

NSString *enActionFuncName(NSString *actionName){
    return [NSString stringWithFormat:@"%@%@:",kCTMediatorActionPrefix,actionName];
}

NSString *deActionFuncName(NSString *action){
//    NSString *prefix = @"Action_";
//    NSString *suffix = @":";
    if ([action hasPrefix:kCTMediatorActionPrefix] &&
         [action hasSuffix:kCTMediatorActionSuffix]) {
        return [action substringWithRange:NSMakeRange(kCTMediatorActionPrefix.length, action.length - kCTMediatorActionPrefix.length - kCTMediatorActionSuffix.length)];
    }
    return action;
}

Class getClassFromAtcion(SEL sel){
    return NSClassFromString(deActionFuncName(NSStringFromSelector(sel)));
}

void registerSelectorToMediator(NSString *clsName,NSString *selName){
    if (!routeMap) {
        routeMap = [NSMapTable new];
    }
    [routeMap setObject:selName forKey:clsName];
}

void removeSelectorToMediator(NSString *clsName){
    [routeMap removeObjectForKey:clsName];
}
