//
//  CustomCacheManager.h
//  labor
//
//  Created by 张凯强 on 2022/9/1.
//  Copyright © 2022 ZKWQY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCacheManager : NSObject
+(void)saveCashDataForArchiver:(id)responseData jsonValidator:(nullable id)jsonValidator hostUrl:(NSString *)hostUrl paramet:(nullable NSDictionary *)paramet;
+ (nullable NSDictionary*)getNewDataForCash:(NSString *)path param:(nullable id)param;
@end

NS_ASSUME_NONNULL_END
