//
//  Base64Helper.m
//  Vote
//
//  Created by Pro Mac on 13-1-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "Base64Helper.h"

@implementation Base64Helper


+ (NSString *) image2String:(UIImage *)image 
{
    CGFloat compression = 1;
    NSInteger maxLength = 300*1000;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length > maxLength) {
        CGFloat max = 1;
        CGFloat min = 0;
        for (int i = 0; i < 6; ++i) {
            compression = (max + min) / 2;
            data = UIImageJPEGRepresentation(image, compression);
            if (data.length < maxLength * 0.9) {
                min = compression;
            } else if (data.length > maxLength) {
                max = compression;
            } else {
                break;
            }
        }
    }
    NSString *pictureDataString = [data base64Encoding];
    return pictureDataString;
}

+ (UIImage *) string2Image:(NSString *)string 
{
    NSString *imageStr = string;
    if ([string containsString:@"data:image/jpeg;base64,"]) {
        imageStr = [imageStr stringByReplacingOccurrencesOfString:@"data:image/jpeg;base64," withString:@""];
    }
    UIImage *image = [UIImage imageWithData:[NSData dataWithBase64EncodedString:imageStr]];
    return image;
}

+ (NSString *)OCRImageToString:(UIImage *)image
{
    CGFloat compression = 1;
    NSInteger maxLength = 300*1000;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length > maxLength) {
        CGFloat max = 1;
        CGFloat min = 0;
        for (int i = 0; i < 6; ++i) {
            compression = (max + min) / 2;
            data = UIImageJPEGRepresentation(image, compression);
            if (data.length < maxLength * 0.9) {
                min = compression;
            } else if (data.length > maxLength) {
                max = compression;
            } else {
                break;
            }
        }
    }
    NSString *pictureDataString = [data base64Encoding];
    return pictureDataString;
}
+ (NSString *)stringWithImage:(UIImage *)image maxSize:(NSInteger)maxSize {
    CGFloat compression = 1;
    NSInteger maxLength = maxSize;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length > maxLength) {
        CGFloat max = 1;
        CGFloat min = 0;
        for (int i = 0; i < 6; ++i) {
            compression = (max + min) / 2;
            data = UIImageJPEGRepresentation(image, compression);
            if (data.length < maxLength * 0.9) {
                min = compression;
            } else if (data.length > maxLength) {
                max = compression;
            } else {
                break;
            }
        }
    }
    NSString *pictureDataString = [data base64Encoding];
    return pictureDataString;
}


@end
