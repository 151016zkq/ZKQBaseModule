//
//  NSObject+Add.m
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "NSObject+Add.h"

//判断设备型号
//#import <sys/utsname.h>
//#import "sys/utsname.h"

#import "sys/sysctl.h"
#import "sys/utsname.h"

#import "NSString+Add.h"
#import <objc/runtime.h>
#import <objc/message.h>
#pragma mark - 私有实现KVO的真实target类，每一个target对应了一个keyPath和监听该keyPath的所有block，当其KVO方法调用时，需要回调所有的block


@interface _XWBlockTarget : NSObject

/**添加一个KVOBlock*/
- (void)xw_addBlock:(void (^)(__weak id obj, id oldValue, id newValue))block;
- (void)xw_addNotificationBlock:(void (^)(NSNotification *notification))block;

- (void)xw_doNotification:(NSNotification *)notification;

@end


@implementation _XWBlockTarget {
    //保存所有的block
    NSMutableSet *_kvoBlockSet;
    NSMutableSet *_notificationBlockSet;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _kvoBlockSet = [NSMutableSet new];
        _notificationBlockSet = [NSMutableSet new];
    }
    return self;
}

- (void)xw_addBlock:(void (^)(__weak id obj, id oldValue, id newValue))block {
    [_kvoBlockSet addObject:[block copy]];
}

- (void)xw_addNotificationBlock:(void (^)(NSNotification *notification))block {
    [_notificationBlockSet addObject:[block copy]];
}

- (void)xw_doNotification:(NSNotification *)notification {
    if (!_notificationBlockSet.count) return;
    [_notificationBlockSet enumerateObjectsUsingBlock:^(void (^block)(NSNotification *notification), BOOL * _Nonnull stop) {
        block(notification);
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *, id> *)change context:(void *)context {
    if (!_kvoBlockSet.count) return;
    BOOL prior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    //只接受值改变时的消息
    if (prior) return;
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) return;
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldVal == [NSNull null]) oldVal = nil;
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    if (newVal == [NSNull null]) newVal = nil;
    //执行该target下的所有block
    [_kvoBlockSet enumerateObjectsUsingBlock:^(void (^block)(__weak id obj, id oldVal, id newVal), BOOL * _Nonnull stop) {
        block(object, oldVal, newVal);
    }];
}

@end



@implementation NSObject (Add)
#pragma mark --判断对象是否为空
- (BOOL)noEmpty {
    if ([self isKindOfClass:[NSNull class]]) {
        return false;
    }
    if ([self isKindOfClass:[NSString class]] || [self isKindOfClass: [NSMutableString class]]) {
        if (self == nil || self == NULL) {
            return false;
        }
        NSString *str = (NSString *)self;
        if ([str isEqualToString:@"(null)"]) {
            return false;
        }
        if ([str isEqualToString:@"<null>"]) {
            return false;
        }
        if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
            return false;
        }
        if (str.length == 0) {
            return false;
        }

    }
    if (self == nil || self == NULL) {
        return false;
    }
    return true;
}
#pragma mark 富文本
- (NSMutableAttributedString *)allStr:(NSString *)allStr andAllStrFont:(UIFont *)allStrFont andAllStrColor:(UIColor *)allStrColor andAttributeStr:(NSString *)attStr andAttStrFont:(UIFont *)attStrFont andAttStrColor:(UIColor *)attStrColor {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:allStr attributes:@{NSFontAttributeName : allStrFont, NSForegroundColorAttributeName : allStrColor}];
    [attString addAttributes:@{ NSFontAttributeName : attStrFont,
                                NSForegroundColorAttributeName : attStrColor }
                       range:[allStr rangeOfString:attStr]];

    return attString;
}

#pragma mark - UI通用生成
- (UILabel *)creatLableWithText:(NSString *)str
                       fontType:(UIFont *)font
                      textColor:(UIColor *)color
                        bgColor:(UIColor *)bgColor
                      textAlign:(NSTextAlignment)alignment
                      superView:(UIView *)superView
{
    return [self creatLableWithText:str frame:CGRectZero fontType:font textColor:color bgColor:bgColor textAlign:alignment numberOfLine:1 linebreakModel:NSLineBreakByTruncatingTail superView:superView];
}

/**
 *  @title 生成label控件
 */
- (UILabel *)creatLableWithText:(NSString *)str
                          frame:(CGRect)frame
                       fontType:(UIFont *)font
                      textColor:(UIColor *)color
                        bgColor:(UIColor *)bgColor
                      textAlign:(NSTextAlignment)alignment
                   numberOfLine:(NSInteger)numberLine
                 linebreakModel:(NSLineBreakMode)lineMode
                      superView:(UIView *)superView
{
    UILabel *lable = [[UILabel alloc] init];
    lable.font = font;
    lable.frame = frame;
    lable.textColor = color;
    lable.text = str;
    lable.textAlignment = alignment;
    lable.backgroundColor = bgColor;
    lable.numberOfLines = numberLine;
    lable.lineBreakMode = lineMode;
    if (superView) {
        [superView addSubview:lable];
    }
    return lable;
}

- (UIButton *)createButtomWithTitle:(NSString *)title
                           fontType:(UIFont *)font
                         titleColor:(UIColor *)color
                            bgColor:(UIColor *)bgColor
                              frame:(CGRect)frame
                         buttonType:(UIButtonType)btnType
                          superView:(UIView *)superView
{
    UIButton *button = [UIButton buttonWithType:btnType];
    button.frame = frame;
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateHighlighted];
    [button setBackgroundColor:bgColor];
    if (superView) {
        [superView addSubview:button];
    }
    
    return button;
}

- (CAGradientLayer *_Nonnull)createGradientLayerFrame:(CGRect)frame
                                                   colors:(NSArray *_Nonnull)colors
                                                locations:(NSArray *_Nonnull)locations
                                               startPoint:(CGPoint)startPoint
                                                 endPoint:(CGPoint)endPoint
                                             cornerRadius:(CGFloat)cornerRadius
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    gradientLayer.colors = colors;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.cornerRadius = cornerRadius;
    
    return gradientLayer;
}

- (void)setShadowRadius:(CGFloat)shadowRadius
            shadowColor:(UIColor *)shadowColor
           shadowOffset:(CGSize)shadowOffset
          shadowOpacity:(float)shadowOpacity
                 ofView:(UIView *)view
{
    if (view == nil)
    {
        return;
    }
    view.layer.shadowRadius = shadowRadius;
    view.layer.shadowColor = shadowColor.CGColor;
    view.layer.shadowOffset = shadowOffset;
    view.layer.shadowOpacity = shadowOpacity;
}

#pragma mark 网络判断

//- (BOOL)requestBeforeJudgeConnect {
//    struct sockaddr zeroAddress;
//    bzero(&zeroAddress, sizeof(zeroAddress));
//    zeroAddress.sa_len = sizeof(zeroAddress);
//    zeroAddress.sa_family = AF_INET;
//    SCNetworkReachabilityRef defaultRouteReachability =
//        SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
//    SCNetworkReachabilityFlags flags;
//    BOOL didRetrieveFlags =
//        SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
//    CFRelease(defaultRouteReachability);
//    if (!didRetrieveFlags) {
//        printf("Error. Count not recover network reachability flags\n");
//        return NO;
//    }
//    BOOL isReachable = flags & kSCNetworkFlagsReachable;
//    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
//    BOOL isNetworkEnable = (isReachable && !needsConnection) ? YES : NO;
//    //    dispatch_async(dispatch_get_main_queue(), ^{
//    //        [UIApplication sharedApplication].networkActivityIndicatorVisible =isNetworkEnable;/*  网络指示器的状态： 有网络 ： 开  没有网络： 关  */
//    //    });
//    return isNetworkEnable;
//}

+ (NSString *)getFileDocumentPath:(NSString *)fileName {
    if (nil == fileName) {
        return nil;
    }
    NSString *documentDirectory = [self getDocumentPath];
    NSString *fileFullPath = [documentDirectory stringByAppendingPathComponent:fileName];
    return fileFullPath;
}

+ (NSString *)getFileCachePath:(NSString *)fileName {
    if (nil == fileName) {
        return nil;
    }
    NSString *cacheDirectory = [self getCachePath];
    NSString *fileFullPath = [cacheDirectory stringByAppendingPathComponent:fileName];
    return fileFullPath;
}

+ (NSString *)getFileResourcePath:(NSString *)fileName {
    if ([fileName isEmpty]) {
        return nil;
    }
    // 获取资源目录路径
    NSString *resourceDir = [[NSBundle mainBundle] resourcePath];
    return [resourceDir stringByAppendingPathComponent:fileName];
}

+ (BOOL)isExistFileInDocument:(NSString *)fileName {
    if ([fileName isEmpty]) {
        return NO;
    }

    NSString *filePath = [self getFileDocumentPath:fileName];
    if (nil == filePath) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (BOOL)isExistFileInCache:(NSString *)fileName {
    if (nil == fileName || [fileName length] == 0) {
        return NO;
    }
    NSString *filePath = [self getFileCachePath:fileName];
    if (nil == filePath) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (BOOL)removeFolderInDocumet:(NSString *)aFolderNameInDoc {
    if ([aFolderNameInDoc isEmpty]) {
        return YES;
    }
    NSString *filePath = [self getFileDocumentPath:aFolderNameInDoc];
    if (nil == filePath) {
        return YES;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:filePath error:nil];
}

+ (BOOL)removeFolderInCahe:(NSString *)aFolderNameInCahe {
    if ([aFolderNameInCahe isEmpty]) {
        return YES;
    }

    if (![self isExistFileInCache:aFolderNameInCahe]) {
        return YES;
    }

    NSString *filePath = [self getFileCachePath:aFolderNameInCahe];
    if (nil == filePath) {
        return YES;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:filePath error:nil];
}

//+ (BOOL)removeComicBookFolder:(NSInteger)bookId
//{
//    NSString *filePath = [self getComicBookDir:bookId];
//    if (nil == filePath)
//    {
//        return YES;
//    }
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    return [fileManager removeItemAtPath:filePath error:nil];
//}

// 判断一个文件是否存在于resource目录下
+ (BOOL)isExistFileInResource:(NSString *)fileName {
    if ([fileName isEmpty]) {
        return NO;
    }
    NSString *filePath = [self getFileResourcePath:fileName];
    if (nil == filePath) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (BOOL)isExistFile:(NSString *)aFilePath {
    if ([aFilePath isEmpty]) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:aFilePath];
}

+ (BOOL)copyResourceFileToDocumentPath:(NSString *)resourceName {
    if ([resourceName isEmpty]) {
        return NO;
    }
    //获取资源文件的存放目录进行
    NSString *resourcePath = [self getFileResourcePath:resourceName];
    NSString *documentPath = [self getFileDocumentPath:resourceName];
    if (nil == resourcePath || nil == documentPath) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if ([self isExistFile:documentPath]) {
        // 如果文件已存在， 那么先删除原来的
        [self deleteFileAtPath:documentPath];
    }

    BOOL succ = [fileManager copyItemAtPath:resourcePath toPath:documentPath error:nil];
    return succ;
}

+ (BOOL)deleteFileAtPath:(NSString *)filePath {
    if ([filePath isEmpty]) {
        return NO;
    }
    // 判断文件是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        return [fileManager removeItemAtPath:filePath error:nil];
    }
    NSLog(@"删除的文件不存在");
    return NO;
}

+ (NSDictionary *)getFileAttributsAtPath:(NSString *)filePath {
    if ([filePath isEmpty]) {
        return nil;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath] == NO) {
        return nil;
    }
    return [fileManager attributesOfItemAtPath:filePath error:nil];
}

+ (BOOL)createDirectoryAtDocument:(NSString *)dirName {
    if (nil == dirName) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [self getFileDocumentPath:dirName];
    if ([fileManager fileExistsAtPath:dirPath]) {
        return YES;
    }

    BOOL succ = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    return succ;
}

+ (BOOL)createDirectoryAtCache:(NSString *)dirName {
    if (nil == dirName) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [self getFileCachePath:dirName];
    if ([fileManager fileExistsAtPath:dirPath]) {
        return YES;
    }

    BOOL succ = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    return succ;
}

+ (BOOL)createDirectoryAtTemporary:(NSString *)dirName {
    if (nil == dirName) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tempPath = [self getTemporaryPath];
    NSString *dirPath = [NSString stringWithFormat:@"%@/%@", tempPath, dirName];
    if ([fileManager fileExistsAtPath:dirPath]) {
        return YES;
    }

    BOOL succ = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    return succ;
}


// 获取文档目录路径
+ (NSString *)getDocumentPath {
    // 获取文档目录路径
    NSArray *userPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [userPaths objectAtIndex:0];
}

// 获取cache目录路径
+ (NSString *)getCachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)getTemporaryPath {
    return NSTemporaryDirectory();
}

+ (long long)getFreeSpaceOfDisk {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *freeSpace = [fattributes objectForKey:NSFileSystemFreeSize];
    long long space = [freeSpace longLongValue];
    return space;
}

+ (long long)getFileSize:(NSString *)filePath {
    NSDictionary *fileAttributes = [self getFileAttributsAtPath:filePath];
    if (fileAttributes) {
        NSNumber *fileSize = (NSNumber *)[fileAttributes objectForKey:NSFileSize];
        if (fileSize != nil) {
            return [fileSize longLongValue];
        }
    }
    return 0;
}

+ (BOOL)copySourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath {
    NSLog(@"despath:%@", desPath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 读取文件的信息
    NSData *sourceData = [NSData dataWithContentsOfFile:sourceFile];
    BOOL e = NO;
    if (sourceData) {
        e = [fileManager createFileAtPath:desPath contents:sourceData attributes:nil];
    }
    //    NSError *error = nil;
    //    BOOL e =  [fileManager copyItemAtPath:sourceFile toPath:desPath error:&error];
    if (e) {
        NSLog(@"copySourceFile成功");
    } else {
        NSLog(@"copySourceFile失败");
    }
    return YES;
}

+ (BOOL)moveSourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager moveItemAtPath:sourceFile toPath:desPath error:&error];
    if (error) {
        return NO;
    }
    return YES;
}

// 如果应用程序覆盖安装后，其document目录会发生变化，该函数用于替换就的document路径
+ (NSString *)reCorrentPathWithPath:(NSString *)path {
    if (nil == path) {
        return nil;
    }
    NSString *docPath = [self getDocumentPath];
    NSRange range = [path rangeOfString:docPath];
    // 没找到正确的document路径
    if (range.length <= 0) {
        NSRange docRange = [path rangeOfString:@"Documents/"];
        if (docRange.length > 0) {
            NSString *relPath = [path substringFromIndex:docRange.location + docRange.length];
            NSString *newPath = [self getFileDocumentPath:relPath];
            return newPath;
        }
    }
    return path;
}

+ (unsigned long long int)folderSize:(NSString *)folderPath {
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSArray *filesArray = [mgr subpathsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *filesEnumerator = [filesArray objectEnumerator];
    NSString *fileName;
    unsigned long long int fileSize = 0;

    while (fileName = [filesEnumerator nextObject]) {
        NSDictionary *fileDictionary = [mgr attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:fileName] error:nil];
        fileSize += [fileDictionary fileSize];
    }

    return fileSize;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL {
    if (![[NSFileManager defaultManager] fileExistsAtPath:[URL path]]) {
        return NO;
    }

    NSError *error = nil;
    BOOL success = [URL setResourceValue:[NSNumber numberWithBool:YES]
                                  forKey:NSURLIsExcludedFromBackupKey
                                   error:&error];

    if (!success) {
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }

    return success;
}

+ (NSString *)imageCachePath {
    return [self getTemporaryPath];
}

#pragma mark -  json转换
+ (id)getObjectFromJsonString:(NSString *)jsonString {
    NSError *error = nil;
    if (jsonString) {
        id rev = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        if (error == nil) {
            return rev;
        } else {
            NSLog(@"error===>%@",error);
            return nil;
        }
    }
    return nil;
}

+ (NSString *)getJsonStringFromObject:(id)object {
    if ([NSJSONSerialization isValidJSONObject:object])

    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];


        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    return nil;
}

#pragma mark -  NSDate互转NSString
+ (NSDate *)NSStringToDate:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //注释by jins 2019-11-18 analyze分析 内存提示Dead store无效数据优化
//    NSDate *dateFromString = [[NSDate alloc] init];
//    dateFromString = [dateFormatter dateFromString:dateString];
    NSDate *dateFromString = [dateFormatter dateFromString:dateString];
    
    return dateFromString;
}

+ (NSDate *)NSStringToDate:(NSString *)dateString withFormat:(NSString *)formatestr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatestr];
    
    //注释by jins 2019-11-18 analyze分析 内存提示Dead store无效数据优化
//    NSDate *dateFromString = [[NSDate alloc] init];
//    dateFromString = [dateFormatter dateFromString:dateString];
    NSDate *dateFromString = [dateFormatter dateFromString:dateString];

    return dateFromString;
}

+ (NSString *)NSDateToString:(NSDate *)dateFromString withFormat:(NSString *)formatestr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatestr];
    NSString *strDate = [dateFormatter stringFromDate:dateFromString];
    return strDate;
}

#pragma mark -  判断字符串是否为空,为空的话返回 “” （一般用于保存字典时）
+ (NSString *)IsNotNull:(id)string {
    NSString *str = (NSString *)string;
    if ([self isBlankString:str]) {
        string = @"";
    }
    return string;
}

//..判断字符串是否为空字符的方法
+ (BOOL)isBlankString:(id)string {
    NSString *str = (NSString *)string;
    if (![str isKindOfClass:[NSString class]]) {
        return YES;
    }
    if ([str isEqualToString:@"(null)"]) {
        return YES;
    }
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}


#pragma mark - 使用subString去除float后面无效的0
+ (NSString *)changeFloatWithString:(NSString *)stringFloat

{
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    NSInteger i = length - 1;
    for (; i >= 0; i--) {
        if (floatChars[i] == '0') {
            zeroLength++;
        } else {
            if (floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if (i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i + 1];
    }
    return returnString;
}

#pragma mark - 去除float后面无效的0
+ (NSString *)changeFloatWithFloat:(CGFloat)floatValue

{
    return [self changeFloatWithString:[NSString stringWithFormat:@"%f", floatValue]];
}

#pragma mark - 如何通过一个整型的变量来控制数值保留的小数点位数。以往我们通类似@"%.2f"来指定保留2位小数位，现在我想通过一个变量来控制保留的位数
+ (NSString *)newFloat:(float)value withNumber:(int)numberOfPlace {
    NSString *formatStr = @"%0.";
    formatStr = [formatStr stringByAppendingFormat:@"%df", numberOfPlace];
    NSLog(@"____%@", formatStr);

    formatStr = [NSString stringWithFormat:formatStr, value];
    NSLog(@"____%@", formatStr);

    printf("formatStr %s\n", [formatStr UTF8String]);
    return formatStr;
}



#pragma mark -  阿里云压缩图片
+ (NSURL *)UrlWithStringForImage:(NSString *)string {
    NSString *str = [NSString stringWithFormat:@"%@@800w_600h_10Q.jpg", string];
    NSLog(@"加载图片地址=%@", str);
    return [NSURL URLWithString:str];
}

//..去掉压缩属性“@800w_600h_10Q.jpg”
+ (NSString *)removeYaSuoAttribute:(NSString *)string {
    NSString *str = @"";
    if ([string rangeOfString:@"@"].location != NSNotFound) {
        NSArray *arry = [string componentsSeparatedByString:@"@"];
        str = arry[0];
    }
    return str;
}

#pragma mark - 字符串类型判断
//..判断是否为整形：
+ (BOOL)isPureInt:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}


#pragma mark -  计算内容文本的高度方法
+ (CGFloat)HeightForText:(NSString *)text withSizeOfLabelFont:(CGFloat)font withWidthOfContent:(CGFloat)contentWidth {
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};
    CGSize size = CGSizeMake(contentWidth, 2000);
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height;
}

#pragma mark -  计算字符串长度
+ (CGFloat)WidthForString:(NSString *)text withSizeOfFont:(CGFloat)font {
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:font]};
    CGSize size = [text sizeWithAttributes:dict];
    return size.width;
}


#pragma mark -  计算两个时间相差多少秒

+ (NSInteger)getSecondsWithBeginDate:(NSString *)currentDateString AndEndDate:(NSString *)tomDateString {
    NSDate *currentDate = [self NSStringToDate:currentDateString withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSInteger currSec = [currentDate timeIntervalSince1970];

    NSDate *tomDate = [self NSStringToDate:tomDateString withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSInteger tomSec = [tomDate timeIntervalSince1970];

    NSInteger newSec = tomSec - currSec;
    NSLog(@"相差秒：%ld", (long)newSec);
    return newSec;
}


#pragma mark - 根据出生日期获取年龄
+ (NSInteger)ageWithDateOfBirth:(NSDate *)date;
{
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger brithDateYear = [components1 year];
    NSInteger brithDateDay = [components1 day];
    NSInteger brithDateMonth = [components1 month];

    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentDateYear = [components2 year];
    NSInteger currentDateDay = [components2 day];
    NSInteger currentDateMonth = [components2 month];

    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }

    return iAge;
}


#pragma mark - 根据经纬度计算两个位置之间的距离
+ (double)distanceBetweenOrderBylat1:(double)lat1 lat2:(double)lat2 lng1:(double)lng1 lng2:(double)lng2 {
    double dd = M_PI / 180;
    double x1 = lat1 * dd, x2 = lat2 * dd;
    double y1 = lng1 * dd, y2 = lng2 * dd;
    double R = 6371004;
    double distance = (2 * R * asin(sqrt(2 - 2 * cos(x1) * cos(x2) * cos(y1 - y2) - 2 * sin(x1) * sin(x2)) / 2));
    //返回km
    return distance / 1000;

    //返回m
    //return   distance;
}



static void *const XWKVOBlockKey = "XWKVOBlockKey";
static void *const XWKVOSemaphoreKey = "XWKVOSemaphoreKey";

- (void)xw_addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(id obj, id oldVal, id newVal))block {
    if (!keyPath || !block) return;
    dispatch_semaphore_t kvoSemaphore = [self _xw_getSemaphoreWithKey:XWKVOSemaphoreKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    //取出存有所有KVOTarget的字典
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, XWKVOBlockKey);
    if (!allTargets) {
        //没有则创建
        allTargets = [NSMutableDictionary new];
        //绑定在该对象中
        objc_setAssociatedObject(self, XWKVOBlockKey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    //获取对应keyPath中的所有target
    _XWBlockTarget *targetForKeyPath = allTargets[keyPath];
    if (!targetForKeyPath) {
        //没有则创建
        targetForKeyPath = [_XWBlockTarget new];
        //保存
        allTargets[keyPath] = targetForKeyPath;
        //如果第一次，则注册对keyPath的KVO监听
        [self addObserver:targetForKeyPath forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    }
    [targetForKeyPath xw_addBlock:block];
    //对第一次注册KVO的类进行dealloc方法调剂
    [self _xw_swizzleDealloc];
    dispatch_semaphore_signal(kvoSemaphore);
}
- (void)xw_removeObserverBlockForKeyPath:(NSString *)keyPath {
    if (!keyPath.length) return;
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, XWKVOBlockKey);
    if (!allTargets) return;
    _XWBlockTarget *target = allTargets[keyPath];
    if (!target) return;
    dispatch_semaphore_t kvoSemaphore = [self _xw_getSemaphoreWithKey:XWKVOSemaphoreKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    [self removeObserver:target forKeyPath:keyPath];
    [allTargets removeObjectForKey:keyPath];
    dispatch_semaphore_signal(kvoSemaphore);
}

- (void)xw_removeAllObserverBlocks {
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, XWKVOBlockKey);
    if (!allTargets) return;
    dispatch_semaphore_t kvoSemaphore = [self _xw_getSemaphoreWithKey:XWKVOSemaphoreKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id key, _XWBlockTarget *target, BOOL *stop) {
        [self removeObserver:target forKeyPath:key];
    }];
    [allTargets removeAllObjects];
    dispatch_semaphore_signal(kvoSemaphore);
}

static void *const XWNotificationBlockKey = "XWNotificationBlockKey";
static void *const XWNotificationSemaphoreKey = "XWNotificationSemaphoreKey";

- (void)xw_addNotificationForName:(NSString *)name block:(void (^)(NSNotification *notification))block {
    if (!name || !block) return;
    dispatch_semaphore_t notificationSemaphore = [self _xw_getSemaphoreWithKey:XWNotificationSemaphoreKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, XWNotificationBlockKey);
    if (!allTargets) {
        allTargets = @{}.mutableCopy;
        objc_setAssociatedObject(self, XWNotificationBlockKey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    _XWBlockTarget *target = allTargets[name];
    if (!target) {
        target = [_XWBlockTarget new];
        allTargets[name] = target;
        [[NSNotificationCenter defaultCenter] addObserver:target selector:@selector(xw_doNotification:) name:name object:nil];
    }
    [target xw_addNotificationBlock:block];
    [self _xw_swizzleDealloc];
    dispatch_semaphore_signal(notificationSemaphore);
}

- (void)xw_removeNotificationForName:(NSString *)name {
    if (!name) return;
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, XWNotificationBlockKey);
    if (!allTargets.count) return;
    _XWBlockTarget *target = allTargets[name];
    if (!target) return;
    dispatch_semaphore_t notificationSemaphore = [self _xw_getSemaphoreWithKey:XWNotificationSemaphoreKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    [[NSNotificationCenter defaultCenter] removeObserver:target];
    [allTargets removeObjectForKey:name];
    dispatch_semaphore_signal(notificationSemaphore);
}

- (void)xw_removeAllNotification {
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, XWNotificationBlockKey);
    if (!allTargets.count) return;
    dispatch_semaphore_t notificationSemaphore = [self _xw_getSemaphoreWithKey:XWNotificationSemaphoreKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, _XWBlockTarget *target, BOOL *_Nonnull stop) {
        [[NSNotificationCenter defaultCenter] removeObserver:target];
    }];
    [allTargets removeAllObjects];
    dispatch_semaphore_signal(notificationSemaphore);
}

- (void)xw_postNotificationWithName:(NSString *)name userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
}


static void *deallocHasSwizzledKey = "deallocHasSwizzledKey";

/**
 *  调剂dealloc方法，由于无法直接使用运行时的swizzle方法对dealloc方法进行调剂，所以稍微麻烦一些
 */
- (void)_xw_swizzleDealloc {
    //我们给每个类绑定上一个值来判断dealloc方法是否被调剂过，如果调剂过了就无需再次调剂了
    BOOL swizzled = [objc_getAssociatedObject(self.class, deallocHasSwizzledKey) boolValue];
    //如果调剂过则直接返回
    if (swizzled) return;
    //开始调剂
    Class swizzleClass = self.class;
    @synchronized(swizzleClass) {
        //获取原有的dealloc方法
        SEL deallocSelector = sel_registerName("dealloc");
        //初始化一个函数指针用于保存原有的dealloc方法
        __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
        //实现我们自己的dealloc方法，通过block的方式
        id newDealloc = ^(__unsafe_unretained id objSelf) {
            //在这里我们移除所有的KVO
            [objSelf xw_removeAllObserverBlocks];
            //移除所有通知
            [objSelf xw_removeAllNotification];
            //根据原有的dealloc方法是否存在进行判断
            if (originalDealloc == NULL) { //如果不存在，说明本类没有实现dealloc方法，则需要向父类发送dealloc消息(objc_msgSendSuper)
                //构造objc_msgSendSuper所需要的参数，.receiver为方法的实际调用者，即为类本身，.super_class指向其父类
                struct objc_super superInfo = {
                    .receiver = objSelf,
                    .super_class = class_getSuperclass(swizzleClass)};
                //构建objc_msgSendSuper函数
                void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                //向super发送dealloc消息
                msgSend(&superInfo, deallocSelector);
            } else { //如果存在，表明该类实现了dealloc方法，则直接调用即可
                //调用原有的dealloc方法
                originalDealloc(objSelf, deallocSelector);
            }
        };
        //根据block构建新的dealloc实现IMP
        IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
        //尝试添加新的dealloc方法，如果该类已经复写的dealloc方法则不能添加成功，反之则能够添加成功
        if (!class_addMethod(swizzleClass, deallocSelector, newDeallocIMP, "v@:")) {
            //如果没有添加成功则保存原有的dealloc方法，用于新的dealloc方法中
            Method deallocMethod = class_getInstanceMethod(swizzleClass, deallocSelector);
            originalDealloc = (void (*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);
            originalDealloc = (void (*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
        }
        //标记该类已经调剂过了
        objc_setAssociatedObject(self.class, deallocHasSwizzledKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (dispatch_semaphore_t)_xw_getSemaphoreWithKey:(void *)key {
    dispatch_semaphore_t semaphore = objc_getAssociatedObject(self, key);
    if (!semaphore) {
        semaphore = dispatch_semaphore_create(1);
        objc_setAssociatedObject(self, key, semaphore, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return semaphore;
}

@end



