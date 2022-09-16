//
//  PLAppInfoUtil.m
//  SmartPicc
//
//  Created by xu xiaodan on 2020/5/25.
//  Copyright © 2020 cn.picclife. All rights reserved.
//

#import "PLAppInfoUtil.h"
#import <sys/sysctl.h>
#import <sys/utsname.h>
#import "DeviceUID.h"
#import <DeviceCheck/DeviceCheck.h>
#import "NSString+Add.h"

typedef NS_ENUM(NSInteger, IOSDeviceType) {
    DeviceTypeHandset,
    DeviceTypeTablet,
    DeviceTypeTv,
    DeviceTypeUnknown
};

#define DeviceTypeValues [NSArray arrayWithObjects: @"Handset", @"Tablet", @"Tv", @"unknown", nil]

@implementation PLAppInfoUtil

+ (instancetype)sharedInstance{
    static PLAppInfoUtil *appInfoUtil = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         appInfoUtil = [[PLAppInfoUtil alloc]init];
    });
    return appInfoUtil;
}

+ (NSString *) getBuildId {
#if TARGET_OS_TV
    return @"unknown";
#else
    size_t bufferSize = 64;
    NSMutableData *buffer = [[NSMutableData alloc] initWithLength:bufferSize];
    int status = sysctlbyname("kern.osversion", buffer.mutableBytes, &bufferSize, NULL, 0);
    if (status != 0) {
        return @"unknown";
    }
    NSString* buildId = [[NSString alloc] initWithCString:buffer.mutableBytes encoding:NSUTF8StringEncoding];
    return buildId;
#endif
}

+ (NSString *) getBuildNumber {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (NSString *)getBrand{
    return @"Apple";    
}

+ (NSString *) getDeviceId {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* deviceId = [NSString stringWithCString:systemInfo.machine
                                            encoding:NSUTF8StringEncoding];
    if ([deviceId isEqualToString:@"i386"] || [deviceId isEqualToString:@"x86_64"] ) {
        deviceId = [NSString stringWithFormat:@"%s", getenv("SIMULATOR_MODEL_IDENTIFIER")];
    }
    return deviceId;
}

+ (NSString *) getDeviceTypeName {
    return [DeviceTypeValues objectAtIndex: [PLAppInfoUtil getDeviceType]];
    
}


+ (IOSDeviceType) getDeviceType
{
    switch ([[UIDevice currentDevice] userInterfaceIdiom]) {
        case UIUserInterfaceIdiomPhone: return DeviceTypeHandset;
        case UIUserInterfaceIdiomPad: return DeviceTypeTablet;
        case UIUserInterfaceIdiomTV: return DeviceTypeTv;
        default: return DeviceTypeUnknown;
    }
}

+ (NSString *) getDeviceName {
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *deviceName = @"unknown";
    if (currentDevice.name  && currentDevice.name.length > 0) {
        deviceName =  currentDevice.name;
    }
   if (deviceName.length >100) {
      deviceName =  [deviceName substringToIndex:100];
    }
  NSString *str =  [NSString  toUnicode:deviceName];
    return str;
}

- (NSString *)deviceToken{
    if (!_deviceToken ||[_deviceToken isEqualToString:@"unknown"]) {
       return [PLAppInfoUtil getDeviceToken];
    }
    else{
        return _deviceToken;
    }
}

+ (NSString *)getDeviceToken {
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block NSString *deviceToken = @"unknown";


    if (@available(iOS 11.0, *)) {

           if ([DCDevice.currentDevice isSupported]) {
               dispatch_async(queue, ^{
                  [DCDevice.currentDevice generateTokenWithCompletionHandler:^(NSData * _Nullable token, NSError * _Nullable error) {
                       dispatch_semaphore_signal(semaphore);
                      if (!error) {
                         deviceToken = [token base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                          [PLAppInfoUtil sharedInstance].deviceToken = deviceToken;
                      }
                  }];
               });
               dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
           }
       }
     
    return deviceToken;
}

+ (NSString *)getManufacturer{
    return @"Apple";
}

+ (NSString *)getSerialNumber{
    return @"unknown";;
}
+ (NSString *) getSystemName {
    UIDevice *currentDevice = [UIDevice currentDevice];
    return currentDevice.systemName;
}

+ (NSString *) getSystemVersion {
    UIDevice *currentDevice = [UIDevice currentDevice];
    return currentDevice.systemVersion;
}

+ (NSString *) getUniqueId {
    if ([PLAppInfoUtil sharedInstance].deviceUID == nil) {
        [PLAppInfoUtil sharedInstance].deviceUID = [DeviceUID uid];
    }
    return [PLAppInfoUtil sharedInstance].deviceUID;
}

+ (NSString *)getVersion{
    return  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
      
}
@end
