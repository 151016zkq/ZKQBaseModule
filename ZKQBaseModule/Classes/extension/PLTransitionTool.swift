//
//  PLTransitionTool.swift
//  SmartPicc
//
//  Created by 张凯强 on 2020/9/21.
//  Copyright © 2020 cn.picclife. All rights reserved.
//

import UIKit
@objcMembers
///设置关键字的颜色
public class PLTransitionTool: NSObject {
    @objc static func transitionAttribute(str:String, keywords: [String], color: UIColor) -> NSAttributedString {
        return str.setColor(color: color, keyWords: keywords)
    }
}


///字体名称-medium
public let pingfangSC_M = "PingFangSC-Medium"
public let pingfangSC_R = "PingFangSC-Regular"
public let pingfangSC_S = "PingFangSC-Semibold"


public func kFONT(_ fontSize: CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: fontSize)
}

///屏幕宽度
public let ScreenWidth = UIScreen.main.bounds.size.width
///屏幕高度
public let ScreenHeight = UIScreen.main.bounds.size.height
///只是竖屏状态下。
public let NavigationBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height + 44
public let sliderBarHeight: CGFloat = (UIApplication.shared.statusBarFrame.size.height >= 40) ? 34:0
///竖屏状态下状态栏高度
public let statusBarHeight = UIApplication.shared.statusBarFrame.height
///只是竖屏状态下。
public let NavigationOnlyBarHeight: CGFloat = 44
///底部导航栏高度
public let TABBARHEIGHT: CGFloat = sliderBarHeight + 49

//账户与安全界面绑定微信
public let KNotifyKey_WechatAuth : String = "WechatAuthCodeNotifation"
public let KNotifyKey_CleanTokenOfMineVCAfterBindWechatInAccountAndSafeVC : String = "CleanTokenOfMineVC"
///沙盒地址
public let SandBoxPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last ?? ""

public let IS_IPHONE_X = statusBarHeight > 40

//public let deviceType = NSString.deviceType()
/// 系统控件的默认高度
public let kSTATUS_BAR_HEIGHT : CGFloat = UIApplication.shared.statusBarFrame.height
public let kNAV_BAR_HEIGHT : CGFloat = 44
public let kTOP_BAR_HEIGHT : CGFloat = IS_IPHONE_X ? 88 : 64
/// 底部安全间距 + TabBar高度
public let kBOTTOM_BAR_HEIGHT : CGFloat = IS_IPHONE_X ? 83 : 49

///屏幕适配符号
public func SCALE(_ value: CGFloat) -> CGFloat {
    return ScreenWidth / 375.0 * value
}
public func kSCALE(_ value: CGFloat) -> CGFloat {
    return ScreenWidth / 375.0 * value
}
///单色
public func kColorSwift(_ value: String) -> UIColor {
    return UIColor.init(hexString: value)
}
//////可设置暗黑颜色，入参为any类型
//public func kColorDarkSwift(_ light: Any,_ dark:Any) -> UIColor {
//    return PLBaseColorTool.DarkOrLightColor(lightStr: light, darkStr: dark)
//}

////获取字符串宽高
public func getStrBoundRect(str:String,font:UIFont,constrainedSize:CGSize,
                         option:NSStringDrawingOptions=NSStringDrawingOptions.usesLineFragmentOrigin)->CGRect{
    let attr = [NSAttributedString.Key.font:font]
    let rect = str.boundingRect(with: constrainedSize, options: option, attributes:attr , context: nil)
    return rect
}


///打印 内存地址
public func customLog(message:Any...,file:String = #file,funcName:String = #function,lineNum:Int = #line) {
    #if DEBUG
    let file = (file as NSString).lastPathComponent;
    /// 方案一： 测试中 发现作用在<引用类型>的对象上能确保正确性
    
    let point = Unmanaged<AnyObject>.passUnretained(message as AnyObject).toOpaque()
    let hashValue = point.hashValue // 这个就是唯一的，可以作比较


    /// 方案三：以唯一值来对应地址的唯一（比如创建对象时，以时间做标记等）
    print("\(file): \(funcName):(\(lineNum))--\(message)");
    #endif
}

