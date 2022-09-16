//
//  BaseNavBarController.m
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "BaseNavBarController.h"


@interface BaseNavBarController ()

@end


@implementation BaseNavBarController

// 此方法，在当前的类第一次被加载到系统中的时候调用一次，以后都不会再调用
//+ (void)initialize {
//
//    NSLog(@"导航控制器类被加载了");
//
//    // 1.外观代理对象  决定了导航条的外观【显示效果】
//    // 将来应用内所有的导航条外观都是一样的，其他的控件也是类似，【某些如果有系统的渲染效果的话，可能不太好使】
//    UINavigationBar *navgationBar = [UINavigationBar appearance];
//
//    // 2.设置背景图片
//    [navgationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
//
//    // 3.设置标题颜色
//    [navgationBar setTitleTextAttributes:@{
//                                           NSForegroundColorAttributeName :[UIColor whiteColor]
//                                           }];
//
//    // 4.设置返回按钮的颜色 将来两侧按钮的颜色也就是白色
//    [navgationBar setTintColor:[UIColor whiteColor]];
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    // 1.统一设置导航栏的背景
    //    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
}

//-(void)back{
//    [self popViewControllerAnimated:YES];
//}
#pragma mark - 重写系统的方法拦截push操作
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 设置返回按钮的 没有文字
    //    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    //    viewController.navigationItem.backBarButtonItem = backItem;


    // 栈顶控制器。
    //    self.topViewController.navigationItem.backBarButtonItem = backItem;

    // 设置隐藏底部工具条
    // 判断一下，如果当前的子控制器个数大于0再隐藏
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;

        
        //        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:KImageNamed(@"back_blue") style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        //
        //        viewController.navigationItem.leftBarButtonItem = backItem;
    }

    [super pushViewController:viewController animated:animated];
    
}

// 返回操作会调用的方法
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}

//由于导航控制器的存在，直接在控制器中写这个方法是不会执行的，因此需要在导航控制器中重写这个方法，让导航控制器的栈顶控制器来执行这个方法。在需要设置的控制器中添加preferredStatusBarStyle方法
- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

@end
