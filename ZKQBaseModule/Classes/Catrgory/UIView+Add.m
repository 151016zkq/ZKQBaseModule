//
//  UIView+Add.m
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "UIView+Add.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import "UIColor+Add.h"
#import "CALayer+Color.h"




@implementation UIView (Add)

static char *GLOWVIEW_KEY = "GLOWVIEW";

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setW:(CGFloat)w
{
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}

- (CGFloat)w
{
    return self.frame.size.width;
}

- (void)setH:(CGFloat)h
{
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
}

- (CGFloat)h
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}


- (UIImage *)captureImage {
    return [self captureImageAtRect:self.bounds];
}

- (UIImage *)captureImageAtRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, rect.origin.x, rect.origin.y);
    [[self layer] renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (UIView *)glowView {
    return objc_getAssociatedObject(self, GLOWVIEW_KEY);
}


- (void)setGlowView:(UIView *)glowView {
    objc_setAssociatedObject(self, GLOWVIEW_KEY, glowView, OBJC_ASSOCIATION_RETAIN);
}

- (void)startGlowingWithColor:(UIColor *)color intensity:(CGFloat)intensity {
    [self startGlowingWithColor:color fromIntensity:0.1 toIntensity:intensity repeat:YES];
}

- (void)startGlowingWithColor:(UIColor *)color fromIntensity:(CGFloat)fromIntensity toIntensity:(CGFloat)toIntensity repeat:(BOOL)repeat {
    [self startGlowingWithColor:color fromIntensity:0.1 toIntensity:toIntensity repeat:YES duration:1];
}

- (void)startGlowingWithColor:(UIColor *)color fromIntensity:(CGFloat)fromIntensity toIntensity:(CGFloat)toIntensity repeat:(BOOL)repeat duration:(CGFloat)dur {
    if ([self glowView]) {
        return;
    }

    UIImage *image;

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);


    [self.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];

    [color setFill];

    [path fillWithBlendMode:kCGBlendModeSourceAtop alpha:1.0];


    image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();


    UIView *glowView = [[UIImageView alloc] initWithImage:image];

    [self.superview insertSubview:glowView aboveSubview:self];

    glowView.center = self.center;


    glowView.alpha = 0;
    glowView.layer.shadowColor = color.CGColor;
    glowView.layer.shadowOffset = CGSizeZero;
    glowView.layer.shadowRadius = 10;
    glowView.layer.shadowOpacity = 1.0;


    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(fromIntensity);
    animation.toValue = @(toIntensity);
    animation.repeatCount = repeat ? HUGE_VAL : 0;
    animation.duration = dur;
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [glowView.layer addAnimation:animation forKey:@"pulse"];
    [self setGlowView:glowView];
}

- (void)glowOnceAtLocation:(CGPoint)point inView:(UIView *)view {
    [self startGlowingWithColor:[UIColor whiteColor] fromIntensity:0 toIntensity:0.6 repeat:NO];

    [self glowView].center = point;
    [view addSubview:[self glowView]];

    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [self stopGlowing];
    });
}

- (void)glowOnce {
    [self startGlowing];

    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [self stopGlowing];
    });
}


- (void)startGlowing {
    [self startGlowingWithColor:[UIColor whiteColor] intensity:0.6];
}

- (void)stopGlowing {
    [[self glowView] removeFromSuperview];
    [self setGlowView:nil];
}

- (void)addBottomLine:(CGRect)rect {
    [self addBottomLine:[UIColor lightGrayColor] inRect:rect];
}

- (void)addBottomLine:(UIColor *)color inRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);

    //Set the stroke (pen) color
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 1.0);

    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));

    CGContextStrokePath(context);

    UIGraphicsPopContext();
}

- (void)shake {
    CGFloat t = 4.0;
    CGAffineTransform translateRight = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    self.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        self.transform = translateRight;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}


- (BOOL)isSubContentOf:(UIView *)aSuperView {
    if (self == aSuperView) {
        return YES;
    } else {
        return [self.superview isSubContentOf:aSuperView];
    }
}


- (CGRect)relativePositionTo:(UIView *)aSuperView {
    BOOL isSubContentOf = [self isSubContentOf:aSuperView];

    while (isSubContentOf) {
        return [self relativeTo:aSuperView];
    }

    return CGRectZero;
}

- (CGRect)relativeTo:(UIView *)aSuperView {
    CGPoint originPoint = CGPointZero;
    UIView *view = self;
    while (!(view == aSuperView)) {
        originPoint.x += view.frame.origin.x;
        originPoint.y += view.frame.origin.y;

        if ([view isKindOfClass:[UIScrollView class]]) {
            originPoint.x -= ((UIScrollView *)view).contentOffset.x;
            originPoint.y -= ((UIScrollView *)view).contentOffset.y;
        }

        view = view.superview;
    }

    // TODO:如果SuperView是UIWindow,需要结合Transform计算
    return CGRectMake(originPoint.x, originPoint.y, self.frame.size.width, self.frame.size.height);
}
- (void)radiusTool:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius; //设置那个圆角的有多圆
    self.layer.borderWidth = width;         //设置边框的宽度，当然可以不要 CCCCCC
    self.layer.borderColor = [borderColor CGColor];
}


#pragma mark -- xib
- (void)setBackgroundColorWithString:(NSString *)string
{
    [self setValue:[UIColor colorWithHexString:string] forKey:@"backgroundColor"];
}
- (void)setTextColorWithString:(NSString *)string
{
    [self setValue:[UIColor colorWithHexString:string] forKey:@"textColor"];
}
- (void)setFontWithString:(NSString *)string
{
    double fontNumber = string.doubleValue;
    UIFont *font = [UIFont systemFontOfSize:fontNumber];
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        label.font = font;
    }
}
- (void)setBoldFontWithString:(NSString *)string
{
    double fontNumber = string.doubleValue;
    UIFont *font = [UIFont boldSystemFontOfSize:fontNumber];
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        label.font = font;
    }
}

- (void)setButtonTextColorWithString:(NSString *)string
{
    UIButton *button = (UIButton *)self;
    [button setTitleColor:[UIColor colorWithHexString:string] forState:UIControlStateNormal];
}
@end
