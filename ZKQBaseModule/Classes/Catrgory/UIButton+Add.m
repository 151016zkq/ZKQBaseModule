//
//  UIButton+Add.m
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "UIButton+Add.h"
#import <objc/runtime.h>
#import "UIColor+Add.h"
#import "ColorMacros.h"

static char *overViewKey;


@implementation UIButton (Add)

- (void)countDownWithTimeout:(int)count endTitle:(NSString *)endTitle{
        self.userInteractionEnabled = NO;
        __block int timeout = count; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC); //每秒执行

        dispatch_source_set_event_handler(timer, ^{
            timeout--;
            if (timeout <= 0) { //倒计时结束，关闭
                dispatch_source_cancel(timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.userInteractionEnabled = YES;
                    [self setTitle:endTitle forState:UIControlStateNormal];
                });
            } else {
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self setTitle:[NSString stringWithFormat:@"%ds", timeout] forState:UIControlStateNormal];
                });
            }
        });
        dispatch_resume(timer);
}
- (void)countDownWithTimeout:(int)count endTitle:(NSString *)endTitle title:(NSString *)title{
        self.userInteractionEnabled = NO;
        __block int timeout = count; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC); //每秒执行

        dispatch_source_set_event_handler(timer, ^{
            timeout--;
            if (timeout <= 0) { //倒计时结束，关闭
                dispatch_source_cancel(timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.userInteractionEnabled = YES;
                    [self setTitle:endTitle forState:UIControlStateNormal];
                    [self setTitleColor:[UIColor colorWithHexString:@"#FF4848"] forState:UIControlStateNormal];
                });
            } else {
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self setTitle:[NSString stringWithFormat:@"%d%@", timeout,title] forState:UIControlStateNormal];
                    [self setTitleColor:Color_999999 forState:UIControlStateNormal];
                });
            }
        });
        dispatch_resume(timer);
}
- (void)countDownWithTimeout:(int)count {
    self.userInteractionEnabled = NO;

    __block int timeout = count; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC); //每秒执行
    //1.0 * NSEC_PER_SEC  代表设置定时器触发的时间间隔为1s
    //0 * NSEC_PER_SEC    代表时间允许的误差是 0s
    dispatch_source_set_event_handler(timer, ^{
        timeout--;
        if (timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(timer);
            //            dispatch_release(_timer);//MRC下需要释放，这里不需要
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.userInteractionEnabled = YES;
                [self setTitle:@"重新获取" forState:UIControlStateNormal];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:[NSString stringWithFormat:@"(%d)", timeout] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(timer);
}

- (instancetype)init {
    if (self = [super init]) {
        [self setAdjustsImageWhenHighlighted:NO]; //去掉高亮效果
    }
    return self;
}

- (void)handleClickEvent:(UIControlEvents)aEvent withClickBlock:(ActionBlock)buttonClickBlock {
    objc_setAssociatedObject(self, &overViewKey, buttonClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(buttonClick) forControlEvents:aEvent];
}

- (void)buttonClick {
    ActionBlock blockClick = objc_getAssociatedObject(self, &overViewKey);

    if (blockClick != nil) {
        blockClick();
    }
}
+ (UIButton *)creatWithTitle:(NSString *)title titleFont:(CGFloat)font titleColor:(NSString *)colorStr backgroundColor:(NSString *)bgColorStr {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:colorStr] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithHexString:bgColorStr];
    return button;
}
//带有暗黑模式的背景色值及字体颜色色值
+ (UIButton *)creatWithTitle:(NSString *)title titleFont:(CGFloat)font titleColor:(NSString *)colorStr titleDarkColor:(NSString *)titleDarkColor backgroundColor:(NSString *)bgColorStr darkBackColor:(NSString *)backDarkColor {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:DarkColorHex(colorStr, titleDarkColor) forState:UIControlStateNormal];
    button.backgroundColor = DarkColorHex(bgColorStr, backDarkColor);
    return button;
}

+ (UIButton *)creatWithTitle:(NSString *)title titleFont:(CGFloat)font titleColor:(NSString *)colorStr titleDarkColor:(NSString *)titleDarkColor backgroundColor:(NSString *)bgColorStr darkBackColor:(NSString *)backDarkColor target:(id)target clickAction:(SEL)clickAction {
    UIButton *button = [self creatWithTitle:title titleFont:font titleColor:colorStr titleDarkColor:titleDarkColor backgroundColor:bgColorStr darkBackColor:backDarkColor];
    if (clickAction) {
        [button addTarget:target
                      action:clickAction
            forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

+ (UIButton *)creatWithTitle:(NSString *)title titleFont:(CGFloat)font titleColor:(NSString *)colorStr backgroundColor:(NSString *)bgColorStr target:(id)target clickAction:(SEL)clickAction {
    UIButton *button = [self creatWithTitle:title titleFont:font titleColor:colorStr backgroundColor:bgColorStr];
    if (clickAction) {
        [button addTarget:target
                      action:clickAction
            forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

- (void)setImageUpTitleDownWithSpacing:(CGFloat)spacing {
    // lower the text and push it left so it appears centered
    //  below the image
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0);

    // raise the image and push it right so it appears centered
    //  above the text
    NSString *titleStr = [self titleForState:UIControlStateNormal] ? [self titleForState:UIControlStateNormal] : [self attributedTitleForState:UIControlStateNormal].string;
    //这里 富文本不能处理    因为font 可能不一致
    CGSize titleSize = SS_SINGLELINE_TEXTSIZE(titleStr, self.titleLabel.font);
    self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width);
}

- (void)setImageRightTitleLeftWithSpacing:(CGFloat)spacing {
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + spacing), 0, imageSize.width);

    CGSize titleSize = SS_SINGLELINE_TEXTSIZE([self titleForState:UIControlStateNormal], self.titleLabel.font);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width, 0, -(titleSize.width + spacing));
}

- (void)setDefaultImageTitleStyleWithSpacing:(CGFloat)spacing {
    CGFloat delta = spacing / 2.f;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, -delta, 0, delta);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, delta, 0, -delta);
}

- (void)setEdgeInsetsWithType:(SSEdgeInsetsType)edgeInsetsType marginType:(SSMarginType)marginType margin:(CGFloat)margin {
    CGSize itemSize = CGSizeZero;
    if (edgeInsetsType == SSEdgeInsetsTypeTitle) {
        itemSize = SS_SINGLELINE_TEXTSIZE([self titleForState:UIControlStateNormal], self.titleLabel.font);
    } else {
        itemSize = [self imageForState:UIControlStateNormal].size;
    }

    CGFloat horizontalDelta = (CGRectGetWidth(self.frame) - itemSize.width) / 2.f - margin;
    CGFloat vertivalDelta = (CGRectGetHeight(self.frame) - itemSize.height) / 2.f - margin;

    NSInteger horizontalSignFlag = 1;
    NSInteger verticalSignFlag = 1;

    switch (marginType) {
        case SSMarginTypeTop: {
            horizontalSignFlag = 0;
            verticalSignFlag = -1;
        } break;
        case SSMarginTypeLeft: {
            horizontalSignFlag = -1;
            verticalSignFlag = 0;
        } break;
        case SSMarginTypeBottom: {
            horizontalSignFlag = 0;
            verticalSignFlag = 1;
        } break;
        case SSMarginTypeRight: {
            horizontalSignFlag = 1;
            verticalSignFlag = 0;
        } break;
        case SSMarginTypeLeftTop: {
            horizontalSignFlag = -1;
            verticalSignFlag = -1;
        } break;
        case SSMarginTypeLeftBottom: {
            horizontalSignFlag = -1;
            verticalSignFlag = 1;
        } break;
        case SSMarginTypeRightTop: {
            horizontalSignFlag = 1;
            verticalSignFlag = -1;
        } break;
        case SSMarginTypeRightBottom: {
            horizontalSignFlag = 1;
            verticalSignFlag = 1;
        } break;

        default:
            break;
    }
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(vertivalDelta * verticalSignFlag, horizontalDelta * horizontalSignFlag, -vertivalDelta * verticalSignFlag, -horizontalDelta * horizontalSignFlag);
    if (edgeInsetsType == SSEdgeInsetsTypeTitle) {
        self.titleEdgeInsets = edgeInsets;
    } else {
        self.imageEdgeInsets = edgeInsets;
    }
}


@end
