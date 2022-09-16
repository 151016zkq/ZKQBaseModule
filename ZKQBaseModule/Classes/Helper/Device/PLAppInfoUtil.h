//
//  PLAppInfoUtil.h
//  SmartPicc
//
//  Created by xu xiaodan on 2020/5/25.
//  Copyright © 2020 cn.picclife. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GetDeviceTokenBlock)(NSString *  _Nonnull __strong deviceToken);

@interface PLAppInfoUtil : NSObject

@property (nonatomic,copy) NSString * deviceToken;
@property (nonatomic, copy) NSString *deviceUID;

+ (instancetype)sharedInstance;

+ (NSString *) getBuildId;

+ (NSString *) getBuildNumber;

+ (NSString *)getBrand;

+ (NSString *) getDeviceId;

+ (NSString *) getDeviceTypeName;



+ (NSString *) getDeviceName;

+ (NSString *)getDeviceToken ;

+ (NSString *)getManufacturer;

+ (NSString *)getSerialNumber;
+ (NSString *) getSystemName;

+ (NSString *) getSystemVersion;

+ (NSString *) getUniqueId;

+ (NSString *)getVersion;

@end

NS_ASSUME_NONNULL_END
