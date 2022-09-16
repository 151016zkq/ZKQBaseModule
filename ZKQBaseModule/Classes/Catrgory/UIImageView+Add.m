//
//  UIImageView+Add.m
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "UIImageView+Add.h"
#import "UIImage+Add.h"

@implementation UIImageView (Add)
+ (UIImageView *)setImageName:(NSString *)imageName topY:(CGFloat)y imageWidth:(CGFloat)width imageHeight:(CGFloat)height {
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageV.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width) / 2 - width / 2, y, width, height);
    return imageV;
}
- (void)setCirleImage:(NSString *)imageName addCornerRadius:(CGFloat)radius {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *img = [[UIImage imageNamed:imageName] drawCircleImageWithRadius:radius];

        dispatch_async(dispatch_get_main_queue(), ^{

            self.image = img;

        });
    });
}

@end
