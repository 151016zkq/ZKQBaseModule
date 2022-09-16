//
//  UIImage+Add.h
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Add)

- (BOOL)hasAlpha;

- (UIImage *)imageWithAlpha;

+ (UIImage *)createImageWithBounds:(CGRect)bounds startColor:(NSString *)startColor endColor:(NSString *)endColor;

- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

/**
 在需要圆角时调用如下
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 UIImage *img = [[UIImage imageNamed:@"image.png"] drawCircleImage];
 dispatch_async(dispatch_get_main_queue(), ^{
 imageView.image = img;
 });
 });
 */

//使用UIImageView的 setCirleImage:(NSString *)imageName addCornerRadius:(CGFloat)radius

- (UIImage *)drawCircleImageWithRadius:(CGFloat)Radius;

+ (UIImage *)createImageWithColor:(UIColor *)color;


- (UIImage *)fixOrientation;

- (UIImage *)thumbnailWithSize:(CGSize)asize;

- (UIImage *)rescaleImageToSize:(CGSize)size;

- (UIImage *)cropImageToRect:(CGRect)cropRect;

- (CGSize)calculateNewSizeForCroppingBox:(CGSize)croppingBox;

- (UIImage *)cropCenterAndScaleImageToSize:(CGSize)cropSize;

- (UIImage *)cropToSquareImage;

// path为图片的键值
- (void)saveToCacheWithKey:(NSString *)key;

+ (UIImage *)loadFromCacheWithKey:(NSString *)key;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColorsArr:(NSArray *)colors size:(CGSize) size;

+ (UIImage *)randomColorImageWith:(CGSize)size;

- (UIImage *)croppedImage:(CGRect)bounds;

/// 压缩图片大小
/// @param image 原图
/// @param maxLength 目标大小
+ (UIImage *)compressImageQuality:(UIImage *)image maxLength:(NSInteger)maxLength;
- (NSData *)compressImageMaxLength:(NSInteger)maxLength;
- (UIImage *)compressImagemaxLength:(NSInteger)maxLength size: (CGSize)size;


/// 将多张image拼接成一张
/// @param imagesArray 图片数组
+ (UIImage *)mergedImages:(NSArray *)imagesArray;

/// 将pdf文件转成一张图片
/// @param fileUrl pdf文件地址
+ (UIImage *)PDFToImage:(NSString *)fileUrl;

- (UIImage *)transformImageWithAngle:(float)angle;

///截取当前image对象rect区域内的图像
- (UIImage *)dw_SubImageWithRect:(CGRect)rect;

///压缩图片至指定尺寸
- (UIImage *__nullable)dw_RescaleImageToSize:(CGSize)size;

///按给定path剪裁图片
/**
 path:路径，剪裁区域。
 mode:填充模式
 */
- (nullable UIImage *)dw_ClipImageWithPath:(UIBezierPath *_Nullable)path;

//裁剪图片
- (UIImage *_Nullable)imageScaleToSize:(CGSize)size;

@end


@interface UIImage (Cut)

- (UIImage *)clipImageWithScaleWithsize:(CGSize)asize;
- (UIImage *)clipImageWithScaleWithsize:(CGSize)asize roundedCornerImage:(NSInteger)roundedCornerImage borderSize:(NSInteger)borderSize;
///截取屏幕上的图片
+ (UIImage*)screenSnapshot:(UIView *)view rect:(CGRect)rect;
@end

//========================================


@interface UIImage (Resize)


- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize transparentBorder:(NSUInteger)borderSize cornerRadius:(NSUInteger)cornerRadius interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode bounds:(CGSize)bounds interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize transform:(CGAffineTransform)transform drawTransposed:(BOOL)transpose interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImageInRect:(CGRect)rect transform:(CGAffineTransform)transform drawTransposed:(BOOL)transpose interpolationQuality:(CGInterpolationQuality)quality;

- (CGAffineTransform)transformForOrientation:(CGSize)newSize;

@end

//========================================


@interface UIImage (RoundedCorner)

- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight;

@end

//========================================
@interface UIImage (SplitImageIntoTwoParts)
//分割成两部分
+ (NSArray *)splitImageIntoTwoParts:(UIImage *)image;
@end


@interface UIImage (ImageEffect)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)blurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor deltaFactor:(CGFloat)deltaFactor maskImage:(UIImage *)maskImage;

@end
