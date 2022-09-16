//
//  UIView+Add.h
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Add)


@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat w;
@property (assign, nonatomic) CGFloat h;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

//截屏
- (UIImage *)captureImage;

- (UIImage *)captureImageAtRect:(CGRect)rect;


@property (nonatomic, readonly) UIView *glowView;

//Glow 发光
- (void)glowOnce;

- (void)glowOnceAtLocation:(CGPoint)point inView:(UIView *)view;

- (void)startGlowing;
//颜色  强度
- (void)startGlowingWithColor:(UIColor *)color intensity:(CGFloat)intensity;

- (void)startGlowingWithColor:(UIColor *)color fromIntensity:(CGFloat)fromIntensity toIntensity:(CGFloat)toIntensity repeat:(BOOL)repeat;

- (void)startGlowingWithColor:(UIColor *)color fromIntensity:(CGFloat)fromIntensity toIntensity:(CGFloat)toIntensity repeat:(BOOL)repeat duration:(CGFloat)dur;

- (void)stopGlowing;

- (void)addBottomLine:(CGRect)rect;

- (void)addBottomLine:(UIColor *)color inRect:(CGRect)rect;

// 左右shake
- (void)shake;


- (BOOL)isSubContentOf:(UIView *)aSuperView;

//相对位置
- (CGRect)relativePositionTo:(UIView *)aSuperView;

/**
 给view添加边框

 @param cornerRadius 圆角半径
 @param width 边框宽度
 @param borderColor 边框颜色
 */
- (void)radiusTool:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor;



#pragma mark --xib
/** backgroundColorWithString 设置xib控件背景颜色 */
- (void)setBackgroundColorWithString:(NSString *)string;
/** textColorWithString 设置xib控件字体颜色 */
- (void)setTextColorWithString:(NSString *)string;
/** pICFontWithString 设置xib控件字体大小 */
- (void)setFontWithString:(NSString *)string;
- (void)setBoldFontWithString:(NSString *)string;
/** buttonTextColorWithString 设置xib按钮字体颜色 */
- (void)setButtonTextColorWithString:(NSString *)string;
@end
