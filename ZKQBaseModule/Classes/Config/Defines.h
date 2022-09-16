//
//  Defines.h
//  Pods
//
//  Created by 张凯强 on 2022/9/15.
//

#ifndef Defines_h
#define Defines_h


// App版本号
#define kAPP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// App Build版本号
#define kAPP_BUILD_VERSION   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
// App名称
#define kAPP_DISPLAY_NAME    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]



// 设备判断
#define kIS_IPHONE          [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define kIS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//需要横屏或者竖屏，获取屏幕宽度与高度
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
#define kSCREEN_WIDTH       ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT      ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define kSCREEN_SIZE        ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define kSCREEN_SIZE        ([UIScreen mainScreen].bounds.size)
#define kSCREEN_WIDTH       (kSCREEN_SIZE.width)
#define kSCREEN_HEIGHT      (kSCREEN_SIZE.height)
#endif

//屏幕适配
//等比宽度
#define SCALEWIDTH(w)  (w)*kSCREEN_WIDTH/375.0
//等比高度
#define SCALEHEIGHT(h)  SCALEWIDTH(h)
//等比字体大小
#define SCALE_FONTSIZE(F)  (F)*kSCREEN_WIDTH/375.0
//等比字体
#define SCALE_FONT(F)   [UIFont systemFontOfSize:SCALE_FONTSIZE(F)]
//等比字体粗体
#define SCALE_BOLD_FONT(F) [UIFont boldSystemFontOfSize:SCALE_FONTSIZE(F)]


// 屏幕的分辨率 当结果为1时，显示的是普通屏幕，结果为2时，显示的是Retian屏幕
#define kSCREEN_SCALE       [[UIScreen mainScreen] scale]

// 除去Status Bar之外的屏幕的frame
#define kCONTENT_FRAME      [[UIScreen mainScreen] applicationFrame]
// 应用程序的屏幕高度
#define kCONTENT_FRAME_HEIGHT   (kCONTENT_FRAME.size.height)
// 应用程序的屏幕宽度
#define kCONTENT_FRAME_WIDTH    (kCONTENT_FRAME.size.width)
//基于iPhone 6s图适配屏幕
#define kAdaptWidth(width) width *kSCREEN_WIDTH / 375
#define kAdaptHeight(height) height *kSCREEN_HEIGHT / 667
// iPhone的型号
/**
 iPad Air                           {{0, 0}, {768, 1024}}
 iphone4s                           {{0, 0}, {320,  480}}        640* 960
 iphone5 5s                         {{0, 0}, {320,  568}}        640*1136
 iphone6, 6s, 7, 8                  {{0, 0}, {375,  667}}        750*1334
 iphone6Plus, 6sPlus, 7Plus, 8Plus  {{0, 0}, {414,  736}}       1242*2208
 iPhoneX                            {{0, 0}, {375,  812}}       1125*2436
 */
#define kIPHONE4            ([[UIScreen mainScreen] bounds].size.height == 480)
#define kIPHONE5            ([[UIScreen mainScreen] bounds].size.height == 568)
#define kIPHONE_NORMAL      ([[UIScreen mainScreen] bounds].size.height == 667)
#define kIPHONE_PLUS        ([[UIScreen mainScreen] bounds].size.height == 736)

//#define kIPHONE_X           (([[UIScreen mainScreen] bounds].size.height == 812) && ([[UIScreen mainScreen] bounds].size.width == 375)) || (([[UIScreen mainScreen] bounds].size.height == 896) && ([[UIScreen mainScreen] bounds].size.width == 414))

#define kIPHONE_X ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES || IS_IPHONE12_Mini == YES || IS_IPHONE12 == YES || IS_IPHONE12_ProMax == YES) ? YES: NO)
//
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone12_Mini
#define IS_IPHONE12_Mini ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 2340), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone12 | 12Pro
#define IS_IPHONE12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone12 Pro Max
#define IS_IPHONE12_ProMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1284, 2778), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

// 判断设备是真机
#if TARGET_OS_IPHONE
#endif
// 判断设备是模拟器
#if TARGET_IPHONE_SIMULATOR
#endif



// 沙盒目录
// 沙盒temp目录路径
#define kPathTemp           NSTemporaryDirectory()
// 沙盒Document目录路径
#define kPathDocument       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
// 沙盒Cache目录路径
#define kPathCache          [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]






// 字体
// 字库名称及大小
#define kNAME_FONT(NAME,FONTSIZE)       [UIFont fontWithName:(NAME) size:(FONTSIZE)]
// 系统字体大小
#define kFONT(FONTSIZE)                 [UIFont systemFontOfSize:FONTSIZE]
// 系统加黑字体大小
#define kBOLD_FONT(FONTSIZE)            [UIFont boldSystemFontOfSize:FONTSIZE]




// 图片
// 加载图片
#define kPNG_IMAGE_FILE(fileName)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(fileName) ofType:@"png"]]
#define kJPG_IMAGE_FILE(fileName)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(fileName) ofType:@"jpg"]]
#define kIMAGE_FILE(fileName,ext)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(fileName) ofType:(ext)]]
// 效率相对前者较低
#define kIMAGE_NAMED(imageName)          [UIImage imageNamed:imageName]
// 获取图片
#define kGetImage(imageName)        [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

// 根据bundle png图片资源路径获取UIImage. 前提：需要提供@1x,@2x,@3x三种文件
#define kBUNDLE_PNG_IMAGE(currentClass, resourceBundleName, imageName) \
({ \
NSBundle *bundle = [NSBundle bundleForClass:currentClass]; \
NSURL *url = [bundle URLForResource:resourceBundleName withExtension:@"bundle"]; \
NSBundle *imageBundle = [NSBundle bundleWithURL:url]; \
NSString *imagePath = [imageBundle pathForResource:imageName ofType:@"png"]; \
UIImage *image = [UIImage imageWithContentsOfFile:imagePath]; \
(image); \
})





// DEBUG模式下打印日志及当前行数
#ifdef DEBUG
#define DLog(fmt, ...) \
{ \
NSString *content = [NSString stringWithFormat:fmt, ##__VA_ARGS__]; \
NSLog((@"\n%s [Line:%03d] [Content:%@]"), __PRETTY_FUNCTION__, __LINE__, content); \
}
#else
#define DLog(...)
#endif


// 重写NSLog, 在Debug模式下打印日志及当前行数
#if DEBUG
#define CLog(fmt, ...) \
{ \
NSString *content = [NSString stringWithFormat:fmt, ##__VA_ARGS__]; \
fprintf(stderr, "%s [line:%03d] [Content:%s]", __PRETTY_FUNCTION__, __LINE__, [content UTF8String]);\
}
#else
#define CLog(fmt, ...)
#endif

// DEBUG模式下打印日志及当前行数, 并弹出一个警告
#ifdef DEBUG
#define ALog(fmt, ...) \
{ \
NSString *title = [NSString stringWithFormat:@"%s\n [Line:%03d]", __PRETTY_FUNCTION__, __LINE__]; \
NSString *message = [NSString stringWithFormat:fmt, ##__VA_ARGS__]; \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message \
        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; \
[alert show]; \
}
#else
#define ALog(...)
#endif




#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

// 由角度获取弧度
#define kDegreeToRadian(x) (M_PI * (x) / 180.0)
// 由弧度获取角度
#define kRadianToDegree(radian) (radian*180.0)/(M_PI)



// 资源路径
// png图片资源路径
#define kPNG_PATH(NAME) [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
// jpg图片资源路径
#define kJPG_PATH(NAME) [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
// 图片资源路径
#define kPATH(NAME,EXT) [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// 根据bundle png图片资源路径获取文件路径. 前提：需要提供@1x,@2x,@3x三种文件
#define kBUNDLE_PNG_IMAGE_PATH(currentClass, resourceBundleName, imageName) \
({ \
NSBundle *bundle = [NSBundle bundleForClass:currentClass]; \
NSURL *url = [bundle URLForResource:resourceBundleName withExtension:@"bundle"]; \
NSBundle *imageBundle = [NSBundle bundleWithURL:url]; \
NSString *imagePath = [imageBundle pathForResource:imageName ofType:@"png"]; \
(imagePath); \
})



// iOS系统版本
#define kSYSTEM_VERSION     [[[UIDevice currentDevice] systemVersion] floatValue]

#define kIS_IOS6            (kSYSTEM_VERSION >=  6.0 && kSYSTEM_VERSION <  7.0)
#define kIS_IOS7            (kSYSTEM_VERSION >=  7.0 && kSYSTEM_VERSION <  8.0)
#define kIS_IOS8            (kSYSTEM_VERSION >=  8.0 && kSYSTEM_VERSION <  9.0)
#define kIS_IOS9            (kSYSTEM_VERSION >=  9.0 && kSYSTEM_VERSION < 10.0)
#define kIS_IOS10           (kSYSTEM_VERSION >= 10.0 && kSYSTEM_VERSION < 11.0)
#define kIS_IOS11           (kSYSTEM_VERSION >= 11.0 && kSYSTEM_VERSION < 12.0)

#define kIOS7_OR_LATER      (kSYSTEM_VERSION >=  7.0f)
#define kIOS8_OR_LATER      (kSYSTEM_VERSION >=  8.0f)
#define kIOS8_4_OR_LATER    (kSYSTEM_VERSION >=  8.4f)
#define kIOS9_OR_LATER      (kSYSTEM_VERSION >=  9.0f)
#define kIOS10_OR_LATER     (kSYSTEM_VERSION >= 10.0f)
#define kIOS11_OR_LATER     (kSYSTEM_VERSION >= 11.0f)
#define kIOS12_OR_LATER     (kSYSTEM_VERSION >= 12.0f)

// 当前语言
#define kLOCAL_LANGUAGE     [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode]
// 当前国家
#define kLOCAL_COUNTRY      [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]




// 系统控件的默认高度
#define kSTATUS_BAR_HEIGHT      (kIPHONE_X ? 44.f : 20.f)
#define kNAV_BAR_HEIGHT         (44.f)
#define kTOP_BAR_HEIGHT         (kIPHONE_X ? 88.f : 64.f) // kSTATUS_BAR_HEIGHT + kNAV_BAR_HEIGHT

/// 底部安全间距
#define  kBOTTOM_SAfE_HEIGHT          (kIPHONE_X ? 34.f : 0.f)
/// TabBar高度
#define kTABBAR_HEIGHT                (49.f)
/// 底部安全间距 + TabBar高度
#define kBOTTOM_BAR_HEIGHT      (kIPHONE_X ? 83.f : 49.f)
#define kCELL_HEIGHT            (44.f)

// 中英状态下键盘的高度
#define kENG_KEY_BOARD_HEIGHT   (216.f)
#define kCHN_KEY_BOARD_HEIGHT   (252.f)





// 设置view圆角和边框
#define kViewBorderRadius(view, radius, width, color) \
                        { \
                        [view.layer setCornerRadius:(radius)];\
                        [view.layer setMasksToBounds:YES];\
                        [view.layer setBorderWidth:(width)];\
                        [view.layer setBorderColor:[color CGColor]];\
                        }

// view的tag
#define kViewWithTag(view, tag)    [view viewWithTag: tag]

#endif /* Defines_h */
