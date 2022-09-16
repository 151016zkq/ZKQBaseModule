//
//  UINavigationController+StackManager.h
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UINavigationController (StackManager)

/**
 *  寻找Navigation中的某个viewcontroler对象
 *
 *  @param className viewcontroler名称
 *
 *  @return viewcontroler对象
 */
- (id)findViewController:(NSString *)className;

/**
 *  判断是否只有一个RootViewController
 *
 *  @return YES/NO
 */
- (BOOL)isOnlyContainRootViewController;

//只能返回push模式栈顶的控制器
/**
 *  返回跟控制器RootViewController
 *
 *  @return RootViewController
 */
- (UIViewController *)rootViewController;

//如果有model模式也能找到
/**
 *  返回跟控制器topViewController
 *
 *  @return topViewController
 */
+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController;

/**
 *  返回指定的viewcontroler
 *
 *  @param className 指定viewcontroler类名
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated;

/**
 *  Pop第level层viewcontroler
 *
 *  @param level    viewcontrolers数组中第level个viewcontroler
 *  @param animated 是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;


- (void)removeViewControllerWithName: (NSString *)vcName;
@end
