//
//  UIViewController+category.h
//  BaseModule
//
//  Created by 张凯强 on 2022/9/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (category)

/**
 返回当前界面最顶部的ViewController

 @return 当前界面最顶部的ViewController
 */
+ (UIViewController *)currentTopViewController;


/// 获取当前控制器
+ (UIViewController *)currentViewController;


@end

NS_ASSUME_NONNULL_END
