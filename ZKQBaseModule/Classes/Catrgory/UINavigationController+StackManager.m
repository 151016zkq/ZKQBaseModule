//
//  UINavigationController+StackManager.m
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "UINavigationController+StackManager.h"


@implementation UINavigationController (StackManager)

- (id)findViewController:(NSString *)className {
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    return nil;
}

- (BOOL)isOnlyContainRootViewController {
    if (self.viewControllers && self.viewControllers.count == 1) {
        return YES;
    }
    return NO;
}

- (UIViewController *)rootViewController {
    if (self.viewControllers && self.viewControllers.count > 0) {
        return [self.viewControllers firstObject];
    }
    return nil;
}
+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if (rootViewController.presentedViewController) {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else {
        return rootViewController;
    }
}
- (NSArray *)popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated {
    if (className) {
        UIViewController *vc = [self findViewController:className];
        if (vc){
            return [self popToViewController:[self findViewController:className] animated:YES];
        }else {
            UIViewController *vc = [self popViewControllerAnimated:true];
            if (vc){
                return @[vc];
            }else {
                return @[];
            }
        }
    }else {
        UIViewController *vc = [self popViewControllerAnimated:true];
        if (vc){
            return @[vc];
        }else {
            return @[];
        }
        
    }
    
}

- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated {
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}
- (void)removeViewControllerWithName:(NSString *)vcName{

    int index = 0;
    for (int i = 0; i<self.viewControllers.count; i++) {
        UIViewController *viewController = self.viewControllers[i];
        if ([viewController isKindOfClass:NSClassFromString(vcName)]) {
            index = i;
        }

    }
    if (index) {
        NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:self.viewControllers];
        [mutableArr removeObjectAtIndex:index];
        self.viewControllers = mutableArr;
    }
    

}

@end
