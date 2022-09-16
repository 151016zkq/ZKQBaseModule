//
//  Array+extentsion.swift
//  SmartPicc
//
//  Created by 张凯强 on 2020/10/16.
//  Copyright © 2020 cn.picclife. All rights reserved.
//
import Foundation
public extension Array {
    mutating func exchangeValue(index: Int, toIndex: Index) {
        let element = self[index]
        self.remove(at: index)
        self.insert(element, at: toIndex)
    }
    
    mutating func replaceElement(condition: (Element) -> Bool, withElement: Element){
        var indexNum: Int?
        for (i, element) in self.enumerated() {
            if (condition(element)) {
                indexNum = i
                break
            }
            
        }
        guard let i = indexNum else {
            return
        }
    
        self.replaceSubrange(i...i, with: [withElement])
    }
    
    
    mutating func getElement(condition: (Element) -> Bool) -> Element?{
        if self.count == 0 {
            return nil
        }
        var indexNum: Int = 0
        for (i, element) in self.enumerated() {
            if (condition(element)) {
                indexNum = i
                break
            }
            
        }
        return self[indexNum]
    }
    
    
    ///比较两个同种类型的数组是否相等。排序。和对象中的属性也相同
    static func compareIsEqual(lhs: [Element], rhs: [Element], judgCondition: (Element, Element) -> Bool) -> Bool {
        if lhs.count != rhs.count {
            return false
        }
        //两数组个数相等的情况下
        for index in 0..<rhs.count {
            let lhsElement = lhs[index]
            let rhsElement = rhs[index]
            if !judgCondition(lhsElement, rhsElement) {
                //其中有不相等的时候，说明两个数组不相等
                return false
            }
        }
        return true
        
    }

    
}

///元素遵守Codable协议的数组
extension Array where Element: Codable {
    ///将遵守Codable协议的数组存在在本地
    public func writeToLocal(withFileName: String) -> Bool {
        let url = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        guard var urlValue = url else {
            return false
        }
        urlValue.appendPathComponent(withFileName)
        ///将数据转换为json
        do {
            try JSONEncoder.init().encode(self).write(to: urlValue)
        } catch {
            return false
        }
        return true
    }
    
    
    ///读取本地存储的数据
    static func readLocalData(withFileName: String) -> Array {
        let url = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        guard var urlValue = url else {
            return []
        }
        urlValue.appendPathComponent(withFileName)
        if FileManager.default.fileExists(atPath: urlValue.path) {
            if let dataRead = try? Data.init(contentsOf: urlValue) {
                do {
                    let dataArr = try JSONDecoder.init().decode([Element].self, from: dataRead)
                    return dataArr
                } catch  {
                    return []
                }
            }else {
                return []
            }
        }else {
            return []
        }

    }
}



public extension Array where Element == String {
    /**
      - dataArr: 数据源
      - superWidth: 总宽度
      - flowlayout: 是否按照瀑布流布局
     */
    func getFrameWithStringArr(superWidth: CGFloat, left: CGFloat, right: CGFloat, top: CGFloat, margin: CGFloat, columNum: Int = 1, height: CGFloat = 27,padding: UIEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5), flowlayout: Bool = false, font: UIFont = UIFont.systemFont(ofSize: 14), inter: CGFloat = 10) -> [CGRect] {
        
        let arr = self.enumerated()
        var sumheight: CGFloat = top
        var leaveWidth: CGFloat = superWidth - left - right
        var leftX: CGFloat = left
        let frames = arr.map { value -> CGRect in
            let index: Int = value.offset
            let text = value.element
            if flowlayout {
                let textSize = text.sizeWith(font: font, maxWidth: superWidth)
                let textHeight = Swift.max(textSize.height + padding.top + padding.bottom, height)
                let textWidth = textSize.width +  padding.left + padding.right
                
                if textWidth > leaveWidth {
                    sumheight += textHeight + margin
                    leftX = left
                    leaveWidth = superWidth - left - right
                }
                let rect = CGRect.init(x: leftX, y: sumheight, width: textWidth, height: textHeight)
                leftX += inter + textWidth
                leaveWidth -= (textWidth + inter)
                return rect
                
                
                
            }else {
                if columNum <= 1 {
                    let x = left
                    let y = top + margin * CGFloat(index) + CGFloat(index) * height
                    let width = superWidth - left - right
                    return CGRect.init(x: x, y: y, width: width, height: height)

                }else {
                    //判断是是否多一行。
                    let columIndex = index % columNum
                    let row = index / columNum
                    let width: CGFloat = ((superWidth - left - right) - CGFloat(columNum - 1) * margin) / CGFloat(columNum)
                    let x: CGFloat = left + CGFloat(columIndex) * width + margin * CGFloat(columIndex)
                    let y: CGFloat = top + CGFloat(row) * (margin + height)
                
                    return CGRect.init(x: x, y: y, width: width, height: height)
                    
                }

                
            }
          }

        return frames
    }

}
