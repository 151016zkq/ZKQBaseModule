//
//  Base64Helper.h
//  Vote
//
//  Created by Pro Mac on 13-1-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSData+base64.h"
@interface Base64Helper : NSObject
+ (NSString *) image2String:(UIImage *)image;  //图片转BASE64编码
+ (UIImage *) string2Image:(NSString *)string;  //BASE64编码转图片
+ (NSString *)OCRImageToString:(UIImage *)image; //OCR识别图片压缩转码500K
+ (NSString *)stringWithImage:(UIImage *) image maxSize:(NSInteger)maxSize;      // 将图片压缩到某一范围内，并执行base64编码
@end
