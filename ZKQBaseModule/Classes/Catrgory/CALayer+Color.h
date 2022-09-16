//
//  CALayer+Color.h
//  qsqd_sfsht
//
//  Created by 李昂 on 2017/8/9.
//  Copyright © 2017年 赵将. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (Color)
- (void)setBorderColorFromeUIColor:(UIColor *)color;
- (void)setBorderColorFromeString:(NSString *)string;
- (void)setShadowColorFromeString:(NSString *)string;

@end
