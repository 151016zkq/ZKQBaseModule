//
//  PLBaseDarkManager.swift
//  PLBaseModule
//
//  Created by qjy on 2021/5/17.
//

import UIKit

@objc public enum PLBaseDarkManager_DarkMode:NSInteger {
    
    case defultMode  = 1//默认模式
    case darkMode //暗黑模式
    case serviceMode //跟随系统
}
@objcMembers
public class PLBaseDarkManager:NSObject {
    
    //存储mode信息
    public class func saveDarkStatue(statue:PLBaseDarkManager_DarkMode){
        
        UserDefaults.standard.setValue(statue.rawValue, forKey: "darkMode")
        UserDefaults.standard.synchronize()
    }
    
    //获取mode信息
    public class func getDarkStatue() -> PLBaseDarkManager_DarkMode{
        
        //默认跟随系统
        let value = UserDefaults.standard.integer(forKey: "darkMode")
    
        guard value != 0 else {
            //第一次不存在
            return .defultMode
        }
        
        return PLBaseDarkManager_DarkMode(rawValue: value) ?? .defultMode
    }
    
    ////暗黑模式下tabbar页面+网页适配
    public class func viewcontrollerModeStatue(statue:PLBaseDarkManager_DarkMode){
        
        if #available(iOS 13.0, *) {
            
            let window = UIApplication.shared.keyWindow
            self.saveDarkStatue(statue: statue) //保存当前模式
            if  statue == .serviceMode{
                //跟随系统
                window?.overrideUserInterfaceStyle = .unspecified
            }else if  statue == .darkMode{
                //暗黑模式
                window?.overrideUserInterfaceStyle = .dark
            }else{
                //普通模式
                window!.overrideUserInterfaceStyle = .light
            }
            
        } else {
            // Fallback on earlier versions
        }
    }
        
    //返回对应模式的rawValue值
    public class func darkModeCellStr() ->NSInteger{
            
        let modeStatue = PLBaseDarkManager.getDarkStatue() //获取当前模式
        return modeStatue.rawValue
    }
    
    //更改关闭跟随系统之后的状态
    public class func updateModeService() ->NSInteger{
        
        if #available(iOS 13.0, *) {
            let mode = UITraitCollection.current.userInterfaceStyle
            if mode == .dark{
                //暗黑模式
                return 2
            }else{
                //普通模式
                return 1
            }
            
        } else {
            // Fallback on earlier versions
        }
        return 0
    }
}
