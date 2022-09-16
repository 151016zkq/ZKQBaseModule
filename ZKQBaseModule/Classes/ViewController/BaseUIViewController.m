//
//  BaseUIViewController.m
//  LifeInsurance
//
//  Created by zrq on 2018/9/12.
//  Copyright © 2018年 cn.picclife.  All rights reserved.
//

#import "BaseUIViewController.h"
#import "CTMediator+Addition.h"
#import "UIViewController+category.h"
#import "APIStringMacros.h"
#import <BaseModule/BaseModule-Swift.h>
#import "NSObject+Add.h"
#import "UIView+Add.h"
#import <MJExtension/MJExtension.h>
#import "PLNetCondition.h"

@interface BaseUIViewController ()

@property (nonatomic, strong) UILabel *waterMarkView; //水印视图
@property (nonatomic, copy) NSString *naviBarTitle; //导航栏title
/**  */
@property (weak, nonatomic) BaseNavView *navgationBar;

@end


@implementation BaseUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = KBackColorWhiteSwift;
    __weak typeof(self) weakSelf = self;
    [self.navigationItem xw_addObserverBlockForKeyPath:@"title" block:^(id _Nonnull obj, id _Nonnull oldVal, id _Nonnull newVal)
    {
        //注释by jins 2019-11-19 安全扫描 ID动态转换
        NSString *oldValue = (NSString *)oldVal;
        NSString *newValue = (NSString *)newVal;

        if (![newValue isEqualToString:oldValue]) {
            weakSelf.title = newVal;
        }
    }];

    NSLog(@"...%@",NSStringFromClass([self class]));
}
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 如果不是竖屏, 强制转为竖屏
    if ([UIDevice currentDevice].orientation != UIDeviceOrientationPortrait) {
        [self orientationToPortrait:UIInterfaceOrientationPortrait];
    }
    

    NSString *bundleName = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleName"];
    
    if ([bundleName isEqualToString:DevelopmentBundleName] || [bundleName isEqualToString:TestflightBundleName]) {
        
        if (self.waterMarkView != nil)
        {
            [self.waterMarkView removeFromSuperview];
            for (UIView *view in [[UIApplication sharedApplication].keyWindow subviews]) {
                if ([view isKindOfClass:[UILabel class]]) {
                    [view removeFromSuperview];
                }
            }
            if (!self.isRemoveWatermark) {
                CGFloat top = 0;
                if (@available(iOS 11.0, *)) {
                    top = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top+44;
                } else {
                    top = 20+44;
                }
                self.waterMarkView.frame = CGRectMake(0,top,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                [[UIApplication sharedApplication].keyWindow addSubview:self.waterMarkView];
            }
        }
    }
}



- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.navgationBar.w = self.view.w;
    [self.view bringSubviewToFront:self.navgationBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.waterMarkView != nil)
    {
        [self.waterMarkView removeFromSuperview];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.waterMarkView != nil)
    {
        [self.waterMarkView removeFromSuperview];
    }
    if (self.viewDidDisappearBlcok) {
        self.viewDidDisappearBlcok(animated);
    }
}

- (void)dealloc {
    [self.navigationItem xw_removeObserverBlockForKeyPath:@"title"];
    NSLog(@"%@释放了", NSStringFromClass([self class]));
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}









- (BaseNavView *)navgationBar {
    // 父类控制器必须是导航控制器
    if (!_navgationBar && [self.parentViewController isKindOfClass:[UINavigationController class]]) {
        BaseNavView *navigationBar = [[BaseNavView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        [self.view addSubview:navigationBar];
        _navgationBar = navigationBar;
    }
    return _navgationBar;
}

-(UILabel *)waterMarkView
{
    if (!_waterMarkView) {
        _waterMarkView = [UILabel new];
        _waterMarkView.backgroundColor = [UIColor clearColor];
        _waterMarkView.clipsToBounds = YES;

        UILabel *backLabelView = [UILabel new];
        backLabelView.backgroundColor = [UIColor clearColor];
        backLabelView.frame = CGRectMake((kSCREEN_WIDTH-kSCREEN_HEIGHT)/2, -kSCREEN_HEIGHT/5, kSCREEN_HEIGHT, kSCREEN_HEIGHT*7/5);
        backLabelView.transform = CGAffineTransformMakeRotation(-M_PI*30/180);
        [_waterMarkView addSubview:backLabelView];

        NSString *showWaterMark = @" 测试 ";
        NSString *bundleName = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleName"];
        
        if ([bundleName isEqualToString:TestflightBundleName]) {
            
            if([PLNetCondition sharedInstance].currentHostType == PLHostType_PRODUCTNEW){
                
                showWaterMark = @" TESTFLIGHT 生产 ";
            }else{
                
                showWaterMark = @" TESTFLIGHT 测试 ";
            }
        }
        NSString *finalString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",showWaterMark,showWaterMark,showWaterMark,showWaterMark,showWaterMark,showWaterMark,showWaterMark,showWaterMark,showWaterMark,showWaterMark];

        NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",finalString]];
        NSMutableAttributedString *AttributedStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",finalString]];

        for (int i = 0 ; i < 5; i++) {
            [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                                   value:DarkColorHex(@"#dbdbdb", kBlackTitle)
                                   range:NSMakeRange((showWaterMark.length)*(i*2+1),showWaterMark.length)];
            [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor clearColor]
                                   range:NSMakeRange((showWaterMark.length)*i*2,showWaterMark.length)];
            [AttributedStr2 addAttribute:NSForegroundColorAttributeName
                                   value:DarkColorHex(@"#dbdbdb", kBlackTitle)
                                   range:NSMakeRange((showWaterMark.length)*i*2,showWaterMark.length)];
            [AttributedStr2 addAttribute:NSForegroundColorAttributeName
                                   value:[UIColor clearColor]
                                   range:NSMakeRange((showWaterMark.length)*(i*2+1),showWaterMark.length)];
        }
        for (int i = 0; i < 7; i++) {
            UILabel *label = [UILabel new];
            if (i%2 == 0) {
                label.attributedText = AttributedStr1;
            }else{
                label.attributedText = AttributedStr2;
            }
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.frame = CGRectMake((kSCREEN_WIDTH-kSCREEN_HEIGHT)/2, -(kSCREEN_HEIGHT/5) + (kSCREEN_HEIGHT/5)*i, kSCREEN_HEIGHT*1.5, 15);
            [backLabelView addSubview:label];
        }
    }

    return _waterMarkView;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.navgationBar.title = title;
}

+ (id)createVC:(NSDictionary *)dict{
    Class class = getClassFromAtcion(_cmd);
    if (class) {
       BaseUIViewController *vc =  [[class alloc]init];
        if (dict) {
            [vc mj_setKeyValues:dict];
        }
        return vc;
    }
    return nil;
}


//强制旋转屏幕
- (void)orientationToPortrait:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = (int)orientation;
    [invocation setArgument:&val atIndex:2];//前两个参数已被target和selector占用
    [invocation invoke];
    
}


@end
