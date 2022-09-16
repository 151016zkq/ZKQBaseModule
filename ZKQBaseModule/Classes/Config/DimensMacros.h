//
//  DimensMacros.h
//  LifeInsurance
//
//  Created by zrq on 2018/9/3.
//  Copyright © 2018年 cn.picclife.  All rights reserved.
//

#ifndef DimensMacros_h
#define DimensMacros_h


//---------HUD设置---------
#define KErrorStr @"请检查网络链接！" //错误提示文字
#define KHUDDefaultTime 2          //HUD提示时间
#define KHUDLongTime 5           //HUD提示时间

#define TotalAmount @"invoice_amount"

//----------------------ABOUT IMAGE 图片----------------------
//LOAD LOCAL IMAGE FILE     读取本地图片
#define KLOADIMAGE(file, type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:type]]
//DEFINE IMAGE      定义UIImage对象//    imgView.image = IMAGE(@"Default.png");
#define KIMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
//DEFINE IMAGE      定义UIImage对象
#define KImageNamed(_pointer) [UIImage imageNamed:_pointer] //上面两个方法找不到放在Assets.xcassets里面的图片
//BETTER USER THE FIRST TWO WAY, IT PERFORM WELL. 优先使用前两种宏定义,性能高于后面.

//add by jins 2020.3.21 根据当前屏幕的scale获取Resource路径下图片的2倍3倍图
#define KImgNameAppendScale(ImgName) \
({\
NSString *imageName = ImgName; \
if([UIScreen mainScreen].scale == 3.0f && ![imageName hasSuffix:@"3x"]) \
{ imageName = [ImgName stringByAppendingString:@"@3x"]; } \
else if([UIScreen mainScreen].scale == 2.0f && ![imageName hasSuffix:@"2x"]) \
{ imageName = [ImgName stringByAppendingString:@"@2x"]; } \
(imageName); \
})

//window对象
#define KWindow [UIApplication sharedApplication].keyWindow

// 弱引用 block
#define KWS(weakSelf) __weak __typeof(&*self) weakSelf = self;

#define KIntToStr(S) [NSString stringWithFormat:@"%d", S]
//快速弹出alertView

//by jins 2019-11-22  系统弹窗替换
#define DefQuickAlert(__str, __tar)                                                                                                                           \
{                                                                                                                                                         \
    PLAlertController *alert = [PLAlertController alertControllerWithTitle:__str message:nil preferredStyle:PLAlertControllerStyleAlert]; \
    [alert addAction:[PLAlertAction actionWithTitle:@"好的" style:PLAlertActionStyleCancel handler:nil]]; \
    [__tar.navigationController presentViewController:alert animated:YES completion:nil];\
}


//GCD
#define KGCDWithGlobal(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define KGCDWithMain(block) dispatch_async(dispatch_get_main_queue(), block)

#define kNavHeight(view) view.mj_h + view.mj_y


#endif /* DimensMacros_h */

//屏幕适配
//字体大小生成
#define FONT_SYSTEMBOLD(fontSize) [UIFont boldSystemFontOfSize:fontSize]
#define FONT_SYSTEM(fontSize) [UIFont systemFontOfSize:fontSize]

//等比宽度
#define SCALEWIDTH(w)  (w)*kSCREEN_WIDTH/375.0
//等比高度
#define SCALEHEIGHT(h)  SCALEWIDTH(h)

#define PL_MaxLength_PhoneNum     11   //设置手机长度最长11位
#define PL_MaxLength_PhoneCodeNum 6    //设置手机验证码最长为6位
#define PL_MaxLength_Pwd          18   //密码登录最长长度18位

//项目中常用偏移度
#define OFFSET_LEFT  15 //X轴上与左侧的距离
#define OFFSET_BOTTOM_BUTTON 34 //底部button距离屏幕底部的距离


#pragma mark -字符串生成
#define StringWithInt(num) [NSString stringWithFormat:@"%d",num]

#define StringWithInteger(num) [NSString stringWithFormat:@"%zd",num]

#define StringWihtObject(object) [NSString stringWithFormat:@"%@",object]

#define StringWithFormat(fmt,...) [NSString stringWithFormat:fmt,##__VA_ARGS__]

#define NumberWithInteger(num)  [NSNumber numberWithInteger:num]

#define NumberWithFloat(num)     [NSNumber numberWithFloat:num]

#pragma mark - URL生成
#define URLWithString(string) [NSURL URLWithString:string]

//安全字符串
#define kSafeString(string) string?string:@""
#pragma mark -仅在调试模式下打印日志

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define CRASH_SAFE_ENABLED 0
#else
#define NSLog(...)
#define CRASH_SAFE_ENABLED 1
#endif

//add by jins 2019.11.28 取消反选
#define DeselectRowAtIndexPath  [tableView deselectRowAtIndexPath:indexPath animated:YES]

#pragma mark - /*** 通知消息key值 ***/
//微信授权码通知Key
#define KNotifyKey_WechatAuth @"WechatAuthCodeNotifation"

//登录成功通知KEY
#define KNotifyKey_LoginSuccess @"LoginSuccess"

//退出登录成功通知KEY
#define KNotifyKey_LogoutSuccess @"LogoutSuccess"

//团险理赔补充资料成功通知KEY
#define KNotifyKey_ClaimGroupSuccess @"GroupClaimSuccess"


//展示弹窗通知key
#define KNotifyKey_ShowPopView @"ShowPopView"

//证件有效期更新完成
#define KNotifyKey_UpdateIDCardSuccess @"updateIDCardSuccess"

//实名认证完成要及时去调用星级接口
#define KNotifyKey_UserAuthSuccess @"UserAuthSuccess"

//账号与密码安全页面绑定微信后，需要通知我的页面清掉之前存储的token这样好去调返回头像的接口（解决返回我的页面调无头像信息接口导致头像不更新问题） add by jins 2020/06/10
#define KNotifyKey_CleanTokenOfMineVCAfterBindWechatInAccountAndSafeVC @"CleanTokenOfMineVC"

#pragma mark - /*** UserDefaults的key值 ***/
//星级弹窗只弹一次的存储key值
#define KUserDefaults_StarPopView @"KUD_StarPopView"


//本地路径图标存放bundle名字
#define DEFAULT_IMAGE_BUNDLE_NAME @"PLImages"

//网络请求超时间隔
#define HttpTimeoutInterval 300

///启动页广告图存储路径
#define LAUNCH_IMANR_PATH   [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"launch.png"]
///沙盒地址
#define SandBoxAddress   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]


#define LAUNCH_DOWNLOAD_KEY @"LAUNCH_DOWNLOAD_KEY"

#pragma mark-Block

//block调用宏
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

//通用Block
typedef void (^PLCompletionBlock)(BOOL finish, NSError *error);
typedef void (^PLClickBlock)(void);
typedef void (^PLIndexBlock)(NSInteger index);
typedef void (^PLObjectBlock)(id object);
typedef void (^PLArrayBlock)(NSArray *array);
typedef void (^PLDictionaryBlock)(NSDictionary *param);

typedef void (^FinishBlock)(NSDictionary *receiveJSON);
typedef void (^FinishZipBlock)(id receiveJSON);


typedef void (^ProgressBlock)(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite);
///查看保单
typedef void(^BrowsePolicy)(UIViewController *);

typedef void(^ActiveTaskFinished)(UIViewController *, BOOL isFinished);

///搜索回调block
typedef void(^PLSearchModelBlock)(id model);

///U+处理产品跳转回调最后数据block
typedef void (^PLUPushWebDictBlock)(NSDictionary *dict);
///方法调用
typedef void(^FunctionBlock) (void);

typedef void (^textFieldEndEditing)(UITextField *textField);

typedef void (^networkError)(NSString *errorCode,NSString *errorMsg);
