//
//  AppConfig.m
//  BaseModule
//
//  Created by 张凯强 on 2022/9/14.
//

#import "AppConfig.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation AppConfig

+(void)configIQKeyboardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    manager.enable = YES;                                           // 控制整个功能是否启用
    manager.shouldResignOnTouchOutside = YES;                       // 控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor = YES;              // 控制键盘上的工具条文字颜色是否用户自定义
    //配合使用
    //    manager.overrideKeyboardAppearance = YES;
    //    manager.keyboardAppearance = UIKeyboardAppearanceDark;
    manager.shouldToolbarUsesTextFieldTintColor = YES;        // 控制键盘上的工具条文字颜色是否用户自定义
    manager.toolbarManageBehaviour = IQAutoToolbarByPosition; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    manager.previousNextDisplayMode = IQPreviousNextDisplayModeAlwaysHide;
    manager.toolbarDoneBarButtonItemText = @"完成";
    manager.shouldShowToolbarPlaceholder = NO;                  // 是否显示占位文字
    manager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    manager.keyboardDistanceFromTextField = 10.0f;              // 输入框距离键盘的距离
    manager.enableAutoToolbar = YES;
    //    如果当某一个输入框特定不需要键盘上的工具条时 (有多个输入框)
    //    textField.inputAccessoryView = [[UIView alloc] init];
}
@end
