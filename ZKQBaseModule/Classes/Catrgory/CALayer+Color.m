//
//  CALayer+Color.m
//  qsqd_sfsht
//
//  Created by 李昂 on 2017/8/9.
//  Copyright © 2017年 赵将. All rights reserved.
//

#import "CALayer+Color.h"
#import "UIColor+Add.h"

@implementation CALayer (Color)
- (void)setBorderColorFromeUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
- (void)setBorderColorFromeString:(NSString *)string
{
    self.borderColor = [UIColor colorWithHexString:string].CGColor;
}
- (void)setShadowColorFromeString:(NSString *)string
{
    self.shadowColor = [UIColor colorWithHexString:string].CGColor;
}
@end
