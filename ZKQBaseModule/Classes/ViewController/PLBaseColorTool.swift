//
//  PLBaseColorTool.swift
//  PLBaseModule
//
//  Created by qjy on 2021/9/15.
//

import UIKit
@objcMembers
public class PLBaseColorTool: NSObject {

    public class func DarkOrLightColor(lightStr:Any,darkStr:Any) ->UIColor {
        
        switch lightStr {
        case is String:
            return UIColor.init(lightColorStr: lightStr as? String, darkColor: darkStr as? String)
        case is UIColor:
            return UIColor.init(lightColor: lightStr as? UIColor, darkColor: darkStr as? UIColor)
        default:
            return UIColor.init(lightColor: UIColor.clear, darkColor: UIColor.clear)
        }
    }
    
    public class func DarkOrLightAlphaColor(lightStr:String,darkStr:String,alpha:CGFloat) ->UIColor {
        
        return UIColor.init(lightColorStr: lightStr, withLightColorAlpha: alpha, darkColor: darkStr, withDarkColorAlpha: alpha)
    }
    //主背景色【导航】
    public class func kMiankColor() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kWhiteTitle, darkStr: kColor_00)
    }
    //-------------TODO:适用于一般页面【暗黑模式下统一风格、切勿修改】
    
    //一般页面的背景色
    public class func kBackColor() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kColor_F5, darkStr: kColor_00)
    }
    
    //一般页面上的白色卡片、cell、白色字体颜色等
    public class func kWhiteColor() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kWhiteTitle, darkStr: KColorView)
    }
    
    //一般页面上分割线颜色
    public class func kLineColor() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kColor_ee, darkStr: KColorLine)
    }
    
    //一般页面黑色字体
    public class func kTextColor33() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kBlackTitle, darkStr: kTipMark)
    }
    
    //一般页面666字体
    public class func kTextColor66() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kSystemTitle, darkStr: kTipMark)
    }
    
    //一般页面默认提示语\弹窗中默认提示语
    public class func kPlaceHold99Color() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kColor_99, darkStr: KColorHold)
    }
    
    //ff4848 颜色的暗黑状态
    public class func kColorff4848() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kColor_4848, darkStr: KBlackff4848)
    }
    
    
    
    //-------------TODO:适用于弹窗【暗黑模式下统一风格、切勿修改】
    
    //弹窗底色
    public class func kAlertBackColor() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kWhiteTitle, darkStr: KColorAlert)
    }
    
    //弹窗文案颜色、取消、确定按钮颜色
    public class func kAlertTitleColor() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kBlackTitle, darkStr: KColorAlertTitle)
    }
    
    //输入框颜色
    public class func kAlertTextFeildColor() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kColor_F5, darkStr: KColorAlertLine)
    }
     
    //输入框分割线颜色
    public class func kAlertTextFeildLineColor() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kColorAlertFeildLine, darkStr: KColorHold)
    }
    
    //分割线颜色
    public class func kAlertLineColor() -> UIColor{
        
        return PLBaseColorTool.DarkOrLightColor(lightStr: kColor_ee, darkStr: KColorAlertLine)
    }
}
