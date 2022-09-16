//
//  AESCipher.h
//  AESCipher
//
//  Created by Welkin Xie on 8/13/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  https://github.com/WelkinXie/AESCipher-iOS
//

#import <Foundation/Foundation.h>


@interface AESCipher : NSObject

+ (NSString *)aesEncryptString:(NSString *)content key:(NSString *)key;
+ (NSString *)aesEncryptString:(NSString *)content key:(NSString *)key iv:(NSString *)iv;

+ (NSData *)aesEncryptData:(NSData *)contentData keyData:(NSData *)keyData;
+ (NSData *)aesEncryptData:(NSData *)contentData keyData:(NSData *)keyData ivData:(NSData *)ivData;


+ (NSString *)aesDecryptString:(NSString *)content key:(NSString *)key;
+ (NSString *)aesDecryptString:(NSString *)content key:(NSString *)key iv:(NSString *)iv;

+ (NSData *)aesDecryptData:(NSData *)contentData keyData:(NSData *)keyData;
+ (NSData *)aesDecryptData:(NSData *)contentData keyData:(NSData *)keyData ivData:(NSData *)ivData;

@end
