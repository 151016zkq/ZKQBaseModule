//
//  AESCipher.m
//  AESCipher
//
//  Created by Welkin Xie on 8/13/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  https://github.com/WelkinXie/AESCipher-iOS
//

#import "AESCipher.h"
#import <CommonCrypto/CommonCryptor.h>

NSString const *kAESInitVector = @"A-16-Byte-String";
size_t const kAESKeySize = kCCKeySizeAES128;

@implementation AESCipher

#pragma mark - encrypt string

+ (NSString *)aesEncryptString:(NSString *)content key:(NSString *)key {
    NSCParameterAssert(content);
    NSCParameterAssert(key);
    
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encrptedData = [AESCipher aesEncryptData:contentData keyData:keyData];
    return [encrptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

+ (NSString *)aesEncryptString:(NSString *)content key:(NSString *)key iv:(NSString *)iv {

    NSCParameterAssert(content);
    NSCParameterAssert(key);
    NSCParameterAssert(iv);
    
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivData = [iv dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encrptedData = [AESCipher aesEncryptData:contentData keyData:keyData ivData:ivData];
    return [encrptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}


#pragma mark - encrypt Data
+ (NSData *)aesEncryptData:(NSData *)contentData keyData:(NSData *)keyData {
    NSData * ivData = [kAESInitVector dataUsingEncoding:NSUTF8StringEncoding];
    return [AESCipher aesEncryptData:contentData keyData:keyData ivData:ivData];
}

+ (NSData *)aesEncryptData:(NSData *)contentData keyData:(NSData *)keyData ivData:(NSData *)ivData {
    NSCParameterAssert(contentData);
    NSCParameterAssert(keyData);
    NSCParameterAssert(ivData);
    
    NSString *hint = [NSString stringWithFormat:@"The key size of AES-%lu should be %lu bytes!", kAESKeySize * 8, kAESKeySize];
    NSCAssert(keyData.length == kAESKeySize, hint);
    return [AESCipher cipherOperation:contentData key:keyData iv:ivData operation:kCCEncrypt];
}

#pragma mark - decrypt string
+ (NSString *)aesDecryptString:(NSString *)content key:(NSString *)key {
    NSCParameterAssert(content);
    NSCParameterAssert(key);

    
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];

    NSData *decryptedData = [AESCipher aesDecryptData:contentData keyData:keyData];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

+ (NSString *)aesDecryptString:(NSString *)content key:(NSString *)key iv:(NSString *)iv {
    NSCParameterAssert(content);
    NSCParameterAssert(key);
    NSCParameterAssert(iv);
    
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivData = [iv dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *decryptedData = [AESCipher aesDecryptData:contentData keyData:keyData ivData:ivData];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

#pragma mark - decrypt data
+ (NSData *)aesDecryptData:(NSData *)contentData keyData:(NSData *)keyData {
    NSData *ivData = [kAESInitVector dataUsingEncoding:NSUTF8StringEncoding];
    return [AESCipher aesDecryptData:contentData keyData:keyData ivData:ivData];
}

+ (NSData *)aesDecryptData:(NSData *)contentData keyData:(NSData *)keyData ivData:(NSData *)ivData {
    NSCParameterAssert(contentData);
    NSCParameterAssert(keyData);
    NSCParameterAssert(ivData);
    
    NSString *hint = [NSString stringWithFormat:@"The key size of AES-%lu should be %lu bytes!", kAESKeySize * 8, kAESKeySize];
    NSCAssert(keyData.length == kAESKeySize, hint);
    
    return [AESCipher cipherOperation:contentData key:keyData iv:ivData operation:kCCDecrypt];
}

#pragma mark - main
+ (NSData *)cipherOperation:(NSData *)contentData key:(NSData *)keyData iv:(NSData *)ivData operation:(CCOperation)operation {
    NSUInteger dataLength = contentData.length;
    
    void const *initVectorBytes = ivData.bytes;
    void const *contentBytes = contentData.bytes;
    void const *keyBytes = keyData.bytes;
    
    size_t operationSize = dataLength + kCCBlockSizeAES128;
    void *operationBytes = malloc(operationSize);
    if (operationBytes == NULL) {
        return nil;
    }
    size_t actualOutSize = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyBytes,
                                          kAESKeySize,
                                          initVectorBytes,
                                          contentBytes,
                                          dataLength,
                                          operationBytes,
                                          operationSize,
                                          &actualOutSize);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:operationBytes length:actualOutSize];
    }
    free(operationBytes);
    operationBytes = NULL;
    return nil;
}

@end
