//
//  UILabel+Add.h
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YBAttributeTapActionDelegate <NSObject>
@optional
/**
 *  YBAttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)yb_attributeTapReturnString:(NSString *)string
                              range:(NSRange)range
                              index:(NSInteger)index;
@end

@interface YBAttributeModel : NSObject

@property (nonatomic, copy) NSString *str;

@property (nonatomic, assign) NSRange range;

@end

#pragma mark ---UILabel 的扩展方法
@interface UILabel (Add)

// 已知区域重新调整
- (CGSize)contentSize;

// 不知区域，通过其设置区域
- (CGSize)textSizeIn:(CGSize)size;

+ (UILabel *)creatWithFont:(CGFloat)font TextColor:(NSString *)color;

//带有暗黑模式字体颜色
+ (UILabel *)creatWithFont:(CGFloat)font TextLightColor:(NSString *)color darkColor:(NSString *)darkColor;
//带有暗黑模式字体颜色
+ (UILabel *)creatWithFont:(CGFloat)font TextColor:(NSString *)color darkColor:(NSString *)darkColor Text:(NSString *)text;

+ (UILabel *)creatWithFont:(CGFloat)font TextColor:(NSString *)color Text:(NSString *)text;
/**
 分割视图

 @return label实例
 */
+ (UILabel *)speratorLineOffSet:(CGFloat)offSetY;




#pragma mark ---富文本点击

/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)yb_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

/**
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)yb_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                   delegate:(id <YBAttributeTapActionDelegate> )delegate;

@end
