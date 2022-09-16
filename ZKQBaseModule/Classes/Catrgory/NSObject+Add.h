//
//  NSObject+Add.h
//  CloudLeagueM
//
//  Created by lsd on 2018/4/24.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Add)
#pragma mark --判断对象是否为空
- (BOOL)noEmpty;
//+ (MBProgressHUD *)showHUDWithStr:(NSString *)str ;

//+ (void)hideHUD;

#pragma mark 富文本_Nullable_Nullable
- (NSMutableAttributedString *)allStr:(NSString *)allStr andAllStrFont:(UIFont *)allStrFont andAllStrColor:(UIColor *)allStrColor andAttributeStr:(NSString *)attStr andAttStrFont:(UIFont *)attStrFont andAttStrColor:(UIColor *)attStrColor;

#pragma mark - UI通用生成
/**
 *  @title 生成label控件
 *  @param str  label文本内容
 *  @param font label字体
 *  @param color  label文本颜色
 *  @param bgColor label背景颜色
 *  @param alignment  label文本位置是否居中等
 *  @param superView label将要添加到的父视图
 */
- (UILabel *_Nonnull)creatLableWithText:(NSString *_Nullable)str
                               fontType:(UIFont *_Nullable)font
                              textColor:(UIColor *_Nullable)color
                                bgColor:(UIColor *_Nullable)bgColor
                              textAlign:(NSTextAlignment)alignment
                              superView:(UIView *_Nullable)superView;

/**
 *  @title 生成label控件
 *  @param str  label文本内容
 *  @param frame label的frame
 *  @param font label字体
 *  @param color  label文本颜色
 *  @param bgColor label背景颜色
 *  @param alignment  label文本位置是否居中等
 *  @param numberLine label的行数
 *  @param lineMode  label文本显示类型
 *  @param superView label将要添加到的父视图
 */
- (UILabel *_Nonnull)creatLableWithText:(NSString *_Nullable)str
                                  frame:(CGRect)frame
                               fontType:(UIFont *_Nullable)font
                              textColor:(UIColor *_Nullable)color
                                bgColor:(UIColor *_Nullable)bgColor
                              textAlign:(NSTextAlignment)alignment
                           numberOfLine:(NSInteger)numberLine
                         linebreakModel:(NSLineBreakMode)lineMode
                              superView:(UIView *_Nonnull)superView;

/**
 *  @title 生成button控件
 *  @param title  button标题
 *  @param font button标题字体
 *  @param color  button标题颜色
 *  @param bgColor button背景颜色
 *  @param frame  button的frame
 *  @param superView button将要添加到的父视图
 */
- (UIButton *_Nonnull)createButtomWithTitle:(NSString *_Nullable)title
                                   fontType:(UIFont *_Nullable)font
                                 titleColor:(UIColor *_Nullable)color
                                    bgColor:(UIColor *_Nullable)bgColor
                                      frame:(CGRect)frame
                                 buttonType:(UIButtonType)btnType
                                  superView:(UIView *_Nullable)superView;

/**
 @brief 生成视图渐变层

 @param frame 渐变视图的frame
 @param colors 渐变颜色数组
 @param locations 渐变颜色的位置节点
 @param startPoint 渐变开始位置
 @param endPoint 渐变结束位置
 @param cornerRadius 渐变的弧度
 @return 渐变层
 */
- (CAGradientLayer *_Nonnull)createGradientLayerFrame:(CGRect)frame
                                           colors:(NSArray *_Nonnull)colors
                                        locations:(NSArray *_Nonnull)locations
                                       startPoint:(CGPoint)startPoint
                                         endPoint:(CGPoint)endPoint
                                     cornerRadius:(CGFloat)cornerRadius;


/**
 <#Description#>

 @param shadowRadius 阴影弧度
 @param shadowColor 阴影颜色
 @param shadowOffset 阴影偏移度
 @param shadowOpacity 阴影透明度
 */
- (void)setShadowRadius:(CGFloat)shadowRadius
            shadowColor:(UIColor *_Nonnull)shadowColor
           shadowOffset:(CGSize)shadowOffset
          shadowOpacity:(float)shadowOpacity
                 ofView:(UIView *_Nonnull)view;

#pragma mark 网络判断
//- (BOOL)requestBeforeJudgeConnect;

// 获取文件的文档目录路径
+ (NSString *)getFileDocumentPath:(NSString *)fileName;

// 获取文件在cache目录的路径
+ (NSString *)getFileCachePath:(NSString *)fileName;

// 获取资源文件的路径
+ (NSString *)getFileResourcePath:(NSString *)fileName;

// 将资源文件拷贝到文档目录下
+ (BOOL)copyResourceFileToDocumentPath:(NSString *)resourceName;

// 判断一个文件是否存在于document目录下
+ (BOOL)isExistFileInDocument:(NSString *)fileName;
// 判断一个文件是否存在于cache目录下
+ (BOOL)isExistFileInCache:(NSString *)fileName;

+ (BOOL)removeFolderInDocumet:(NSString *)aFolderNameInDoc;

//删除cache目录下的一个文件夹
+ (BOOL)removeFolderInCahe:(NSString *)aFolderNameInCahe;

//+ (BOOL)removeComicBookFolder:(NSInteger)bookId;

// 判断一个文件是否存在于resource目录下
+ (BOOL)isExistFileInResource:(NSString *)fileName;

// 判断一个全路径文件是否存在
+ (BOOL)isExistFile:(NSString *)aFilePath;

// 删除文件
+ (BOOL)deleteFileAtPath:(NSString *)filePath;

// 获取文件的属性集合
+ (NSDictionary *)getFileAttributsAtPath:(NSString *)filePath;

// 在document目录下创建一个目录
+ (BOOL)createDirectoryAtDocument:(NSString *)dirName;
// 在cache目录下创建一个目录
+ (BOOL)createDirectoryAtCache:(NSString *)dirName;

+ (BOOL)createDirectoryAtTemporary:(NSString *)dirName;

// 获取文档目录路径
+ (NSString *)getDocumentPath;

// 获取cache目录路径
+ (NSString *)getCachePath;

+ (NSString *)getTemporaryPath;

// 获取磁盘剩余空间的大小
+ (long long)getFreeSpaceOfDisk;

// 获取文件大小
+ (long long)getFileSize:(NSString *)filePath;

+ (BOOL)copySourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath;

+ (BOOL)moveSourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath;

+ (NSString *)reCorrentPathWithPath:(NSString *)path;

// 计算文件夹大小
+ (unsigned long long int)folderSize:(NSString *)folderPath;

//在iOS5 .1及以上防止文件被被备份到iCloud和iTunes上
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

//NSTemporaryDirectory 路径
+ (NSString *)imageCachePath;

#pragma mark -  json转换
+ (id)getObjectFromJsonString:(NSString *)jsonString;
+ (NSString *)getJsonStringFromObject:(id)object;

#pragma mark -  NSDate互转NSString
+ (NSDate *)NSStringToDate:(NSString *)dateString;
+ (NSDate *)NSStringToDate:(NSString *)dateString withFormat:(NSString *)formatestr;
+ (NSString *)NSDateToString:(NSDate *)dateFromString withFormat:(NSString *)formatestr;

#pragma mark -  判断字符串是否为空,为空的话返回 “” （一般用于保存字典时）
+ (NSString *)IsNotNull:(NSString *)string;
+ (BOOL)isBlankString:(id)string;


#pragma mark - 如何通过一个整型的变量来控制数值保留的小数点位数。以往我们通类似@"%.2f"来指定保留2位小数位，现在我想通过一个变量来控制保留的位数
+ (NSString *)newFloat:(float)value withNumber:(int)numberOfPlace;


#pragma mark - 使用subString去除float后面无效的0
+ (NSString *)changeFloatWithString:(NSString *)stringFloat;

#pragma mark - 去除float后面无效的0
+ (NSString *)changeFloatWithFloat:(CGFloat)floatValue;



#pragma mark -  阿里云压缩图片
+ (NSURL *)UrlWithStringForImage:(NSString *)string;
+ (NSString *)removeYaSuoAttribute:(NSString *)string;

#pragma mark - 字符串类型判断
+ (BOOL)isPureInt:(NSString *)string;
+ (BOOL)isPureFloat:(NSString *)string;

#pragma mark -  计算内容文本的高度方法
+ (CGFloat)HeightForText:(NSString *)text withSizeOfLabelFont:(CGFloat)font withWidthOfContent:(CGFloat)contentWidth;

#pragma mark -  计算字符串长度
+ (CGFloat)WidthForString:(NSString *)text withSizeOfFont:(CGFloat)font;


#pragma mark -  计算两个时间相差多少秒

+ (NSInteger)getSecondsWithBeginDate:(NSString *)currentDateString AndEndDate:(NSString *)tomDateString;

#pragma mark - 根据出生日期获取年龄
+ (NSInteger)ageWithDateOfBirth:(NSDate *)date;

#pragma mark - 根据经纬度计算两个位置之间的距离
+ (double)distanceBetweenOrderBylat1:(double)lat1 lat2:(double)lat2 lng1:(double)lng1 lng2:(double)lng2;


#pragma mark - KVO

/**
 *  通过Block方式注册一个KVO，通过该方式注册的KVO无需手动移除，其会在被监听对象销毁的时候自动移除,所以下面的两个移除方法一般无需使用
 *
 *  @param keyPath 监听路径
 *  @param block   KVO回调block，obj为监听对象，oldVal为旧值，newVal为新值
 */
- (void)xw_addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(id obj, id oldVal, id newVal))block;

/**
 *  提前移除指定KeyPath下的BlockKVO(一般无需使用，如果需要提前注销KVO才需要)
 *
 *  @param keyPath 移除路径
 */
- (void)xw_removeObserverBlockForKeyPath:(NSString *)keyPath;

/**
 *  提前移除所有的KVOBlock(一般无需使用)
 */
- (void)xw_removeAllObserverBlocks;

#pragma mark - Notification

/**
 *  通过block方式注册通知，通过该方式注册的通知无需手动移除，同样会自动移除
 *
 *  @param name  通知名
 *  @param block 通知的回调Block，notification为回调的通知对象
 */
- (void)xw_addNotificationForName:(NSString *)name block:(void (^)(NSNotification *notification))block;

/**
 *  提前移除某一个name的通知
 *
 *  @param name 需要移除的通知名
 */
- (void)xw_removeNotificationForName:(NSString *)name;

/**
 *  提前移除所有通知
 */
- (void)xw_removeAllNotification;

/**
 *  发送一个通知
 *
 *  @param name     通知名
 *  @param userInfo 数据字典
 */
- (void)xw_postNotificationWithName:(NSString *)name userInfo:(nullable NSDictionary *)userInfo;

@end
NS_ASSUME_NONNULL_END
