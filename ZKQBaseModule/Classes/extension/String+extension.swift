//
//  String+extension.swift
//  zuidilao
//
//  Created by 张凯强 on 2017/10/11.
//  Copyright © 2017年 张凯强. All rights reserved.
//
import KakaJSON
import UIKit
public extension String {
     func showNumStr() -> String {
        if self.count > 4 {
            var str = self
            let startIndex = self.startIndex
            let endIndex = self.index(self.endIndex, offsetBy: -4)
            str = String(str[startIndex..<endIndex])
            return str + "万+"
        }else {
            return self
        }
    }
    
    func consultZanNum() -> String {
        switch self.count {
        case 0...4:
            return self
        case 5:
            let suffixStr = String.init(self.suffix(4))
            if suffixStr >= "0000" && suffixStr <= "0999" {
                return "\(self.prefix(1))万+"
            }else {
                var str = String.init(self.prefix(2))
                str.insert(Character.init("."), at: str.index(after: str.startIndex))
                return str + "万+"
            }
        default:
            let str = self.prefix(self.count - 4)
            return  "\(str)万+"
        }
    }
    
    
    ///解码
//    func aesDecrypt(key: String) throws -> [String: String]? {
//        let key = "4974949650676986"
//        let iv = key
//        let str = "uLjChSYtNCkPYkKV9kmkP5GCA/rAbHHCWRWaVxQC36VrX/voRhvV1RhVNGq1lHBR4Wb7uzU97DMT3qe4rSIVNQ=="
//        let data1 = self.data(using: String.Encoding.utf8)!
//        let data = Data(base64Encoded: data1)!
//
//        AES.init(key: key, iv: iv, padding: .pkcs7).decrypt(<#T##bytes: ArraySlice<UInt8>##ArraySlice<UInt8>#>)
//
//        let decrypted = try! AES(key: key, iv: iv, blockMode: .CBC, padding: .pkcs7).decrypt([UInt8](data))
//        let decryptedData = Data(decrypted)
//        let result = String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
//        let josnData = result.data(using: String.Encoding.utf8)
//        do {
//            let dict = try JSONSerialization.jsonObject(with: josnData!, options: JSONSerialization.ReadingOptions.mutableContainers)
//            if let josnDic = dict as? [String: String] {
//                return josnDic
//            }else {
//                return nil
//            }
//        } catch {
//            return nil
//        }
//
//    }
    ///MARK: Unicode转中文
    var unicodeStr:String {
        let tempStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = ("\"" + tempStr2) + "\""
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        var returnStr:String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: PropertyListSerialization.MutabilityOptions(), format: nil) as! String
        } catch {
            print(error)
        }
        return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
    
    ///MARK:计算多行字符串的size
    func sizeWith(font : UIFont , maxSize : CGSize) -> CGSize {
        var tempMaxSize = CGSize.zero
        if maxSize == CGSize.zero {
            tempMaxSize = CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
        }else{
            tempMaxSize = CGSize.init(width: maxSize.width, height: CGFloat(MAXFLOAT))
        }
        let attribute = Dictionary(dictionaryLiteral: (NSAttributedString.Key.font,font) )
        let size = self.boundingRect(with: tempMaxSize, options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], attributes: attribute, context: nil).size
        return  size
    }
    ///MARK:计算多行字符串的size
    func sizeWith(font : UIFont , maxWidth : CGFloat) -> CGSize {
        var tempMaxSize = CGSize.zero
        if maxWidth == 0 {
            tempMaxSize = CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
        }else{
            tempMaxSize = CGSize(width: maxWidth, height: CGFloat(MAXFLOAT))
        }
        let attribute = Dictionary(dictionaryLiteral: (NSAttributedString.Key.font,font) )
        let size = self.boundingRect(with: tempMaxSize, options: [NSStringDrawingOptions.usesLineFragmentOrigin , NSStringDrawingOptions.usesFontLeading], attributes: attribute, context: nil).size
        return  size
    }
    
    func firstCharactorWithString() -> String {
        if #available(iOS 9.0, *) {
            if let str1 = self.applyingTransform(StringTransform.toLatin, reverse: false) {
                if let str2 = str1.applyingTransform(.stripCombiningMarks, reverse: false) {
                    let index = str2.index(str2.startIndex, offsetBy: 1)
                    let str3 = str2.prefix(upTo: index)
                    return String.init(str3)
                    
                }
                
            }
            return ""
        }else {
            
            let str = NSMutableString.init(string: self) as CFMutableString
            CFStringTransform(str, nil, kCFStringTransformToLatin, false)
            CFStringTransform(str, nil, kCFStringTransformStripCombiningMarks, false)
            let str2 = CFStringCreateWithSubstring(nil, str, CFRangeMake(0, 1))
            return String(str2!)
        }
    }
    ///insert string in currentString
    /// 
    /// "1234567".insertSplit(string: "oo", perDistance: 3) -> "123oo456oo7"
    func insertSplit(string:String , perDistance:Int) -> String {
        if perDistance <= 0{return self}
        let groupcount = self.count / perDistance
        let left = self.count % perDistance
        let totalCount = groupcount + (left > 0 ? 1 : 0)
        var bankCardNumberString = self
        for index   in 0..<(totalCount - 1) {
            bankCardNumberString.insert(contentsOf:string, at: bankCardNumberString.index(bankCardNumberString.startIndex, offsetBy: (index + 1) * perDistance + index * string.count))
        }
        return bankCardNumberString
    }
    //MARK:计算单行字符串的size
    func sizeSingleLine(font : UIFont ) -> CGSize  {
        return self.size(withAttributes: Dictionary(dictionaryLiteral: (NSAttributedString.Key.font,font) ))
    }
    
    ///上色
    func setColor(color:UIColor ) -> NSAttributedString {
        let attributeString = NSMutableAttributedString.init(string: self)
        attributeString.addAttributes([NSAttributedString.Key.foregroundColor : color ], range: NSRange.init(location: 0, length: self.count))
        return attributeString
    }
    
    
    
    
    /// 关键词高亮
    func setColor(color:UIColor , keyWord:String) -> NSAttributedString{
        let att = NSMutableAttributedString.init(string:self)
        let nsstr = NSString.init(string: self )
        if nsstr.contains(keyWord){
            if let nsRanges =    self.ranges(keyWord: keyWord, nsrange: NSRange.init(location: 0, length: self.count)){
                for range in nsRanges {
                    att.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
                }
            }
            return att
        }
        return att
    }
    
    /// 关键词替换
    func replace(keyWord:String , to : String ) -> String{
        let _ = NSMutableAttributedString.init(string:self)
        let nsstr = NSString.init(string: self )
        return nsstr.replacingOccurrences(of: keyWord, with: to)
    }
    
    
    func setColor(color:UIColor , keyWords:[String]) -> NSAttributedString{
        let att = NSMutableAttributedString.init(string:self)
        let nsstr = NSString.init(string: self )
        keyWords.forEach { (keyWord) in
            if nsstr.contains(keyWord){
                if let nsRanges =    self.ranges(keyWord: keyWord, nsrange: NSRange.init(location: 0, length: self.count)){
                    for range in nsRanges {
                        att.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
                    }
                }
               
            }
        }
        
        return att
    }
    func ranges(keyWord : String  , nsrange : NSRange) -> [NSRange]? {
        var tempArr = [NSRange]()
        var diedaiRange = nsrange
        while self.getNSRange(keyWord: keyWord, nsrange: diedaiRange) != nil  {
            let  result = self.getNSRange(keyWord: keyWord, nsrange: diedaiRange)
            tempArr.append(result!)
            let  location = result!.location + result!.length
            let  length = self.count - (result!.location + result!.length)
            if length <= 0 {break}
            let nextNSRange = NSRange.init(location: location, length: length)
            diedaiRange = nextNSRange
        }
        return tempArr
    }
    
    func getNSRange(keyWord : String  , nsrange : NSRange)  -> NSRange?{
        let nsstring = NSString.init(string: self )
        let subStr = nsstring.substring(with: nsrange)
        if subStr.contains(keyWord){
            let range = nsstring.range(of: keyWord , options: NSString.CompareOptions.literal, range: nsrange)
            return range
        }
        return nil
    }
    ///11位手机号中间替换星号
    func prefixphone() -> String {
        let phoneStr = NSString.init(string: self)
        let prefix = phoneStr.substring(to: 3)
        let sub = phoneStr.substring(from: 7)
        let id = prefix + "****" + sub
        return id
    }
    
 
    func imageUrl() -> String {
        var newStr = self
        for (_, str) in newStr.enumerated() {
            if ("\u{4E00}" <= str  && str <= "\u{9FA5}") {
                let str1 = String.init(str)
                let str2 = str1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                newStr = newStr.replace(keyWord: str1, to: str2)

            }
            if (String(str) == " ") {
                newStr = newStr.replace(keyWord: " ", to: "%20")
            }
            
        }
        return newStr
        
    }
    
    
    // MARK: 字符串转字典
    func asDict() -> [String : Any]?{
        let data = self.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!,
                        options: .mutableContainers) as? [String : Any] {
            return dict
        }
        

        return nil
    }
    
    
    ///根据连接获取链接?后面拼接的键值
    func getLinkParams(separatedBy: String) -> [String: String] {
        let mapStr = NSString.init(string: self)
        let rangIndex = mapStr.range(of: "?")
        if rangIndex.length > 0 && mapStr.length > rangIndex.location {
            let lastStr = mapStr.substring(from: rangIndex.location + rangIndex.length)
            let arr = lastStr.components(separatedBy: separatedBy)
            let dictArr: [[String: String]] = arr.compactMap { value -> [String: String] in
                let subArr = value.components(separatedBy: "=")
                let first = subArr.first ?? ""
                let last = subArr.last ?? ""
                return ["key": first, "value": last]
            }
            var dict: [String: String] = [:]
            dictArr.forEach { subDict in
                let key = subDict["key"] ?? ""
                let value = subDict["value"] ?? ""
                dict[key] = value
            }
            return dict
            
            
        }
        
        return [:]
    }
    ///删选字符串中的数字部分
    func onlyGetNum() -> String {
        let set = NSCharacterSet.decimalDigits.inverted
        let second = self.components(separatedBy: set).joined(separator: "")
        return second
    }
    //筛选相对应的字符串
    func screenStr(_ set: CharacterSet) -> String {
        let second = self.components(separatedBy: set)
        let result =  second.joined(separator: "")
        return result

    }
    
}

///获取类名(只获取swift类的name)
public func getClassName(file: AnyClass) -> String {
    let className = String.init(describing: file)
    return className
}
///获取类名(只获取swift类名，包含模块名)
public func getClassNameWithModule(file: AnyClass) -> String {
    let className = NSStringFromClass(file)
    return className
}

