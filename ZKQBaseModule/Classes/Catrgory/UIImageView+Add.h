//
//  UIImageView+Add.h
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (Add)
/**
 居中本地图片加载

 @param imageName 图片名称
 @param y y值
 @param width 图片宽度
 @param height 图片高度
 @return 返回imageview
 */
+ (UIImageView *)setImageName:(NSString *)imageName topY:(CGFloat)y imageWidth:(CGFloat)width imageHeight:(CGFloat)height;
- (void)setCirleImage:(NSString *)imageName addCornerRadius:(CGFloat)radius;

@end
