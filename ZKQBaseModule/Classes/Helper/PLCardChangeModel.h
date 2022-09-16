//
//  PLCardChangeModel.h
//  SmartPicc
//
//  Created by 李昂 on 2019/12/23.
//  Copyright © 2019 cn.picclife. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///和身份证校验有关的类
@interface PLCardChangeModel : NSObject

/**
 *   error为空代表校验通过
 *   error.useInfo NSLocalizedDescriptionKey错误提示
 *   0姓名长度无法修改   1、姓名修改超过 2、生日位 3、身份证最后四位 4、身份证整体5位  5、身份证格式错误 6、有效期错误   7.有效期过期
 *    
 *  *add by jins 2020.2.21 添加nullable 解决Memory error
 */
+ (nullable NSError *)checkChangeErrorWithRecognizedName:(NSString *)recognizedName
                       recognizedCarNumber:(NSString *)recognizedCarNumber
                        recognizedValidity:(NSString *)recognizedValidity
                                filledName:(NSString *)filledName
                            filledCarNumber:(NSString *)filledCarNumber
                            filledValidity:(NSString *)filledValidity;
//实时提示姓名字段
+ (nullable NSError *)showError:(NSString *)recognizedName textFieldString:(NSString *)filledName;
///实时提示证件号字段
+ (nullable NSError *)showNumberError:(NSString *)recognizedCarNumber textFieldString:(NSString *)filledCarNumber;

+ (BOOL)checkValidity:(NSString *)Validity isAviableWithBirthday:(NSString *)birthday;

+ (NSInteger)changeCountBetween:(NSString *)string1 and:(NSString *)string2;
+ (BOOL)isIDCardNumber:(NSString *)number;

+ (BOOL)DataValidityTime:(NSString *)startTimer end:(NSString *)endTimer;

@end

NS_ASSUME_NONNULL_END
