//
//  UIButton+extension.swift
//  SmartPicc
//
//  Created by 张凯强 on 2021/1/30.
//  Copyright © 2021 picclife. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {
    //设置图片在右侧的btn
    @objc public func imageRightBtn() {
        self.titleLabel?.sizeToFit()
        //获得按钮文字部分所占的大小
        let imageSize = self.imageView?.bounds.size ?? CGSize.zero
        //间距
        let margin: CGFloat = 5
        let titleSize = self.currentTitle?.sizeSingleLine(font: self.titleLabel?.font ?? UIFont.systemFont(ofSize: 15))
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageSize.width - margin, bottom: 0, right: imageSize.width)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: (titleSize?.width ?? 0) + margin, bottom: 0, right: -(titleSize?.width ?? 0))
        let resetWidth = (titleSize?.width ?? 0) + margin + margin + imageSize.width + margin
        self.frame = CGRect.init(x: frame.origin.x, y: frame.origin.y, width: resetWidth, height: frame.size.height)
        
    }
    ///设置图片在上，文字在下
    @objc public func imageOnTop(margin: CGFloat, imageWidth: CGFloat = 44) {
        let imageWidth = min(self.imageView?.frame.size.width ?? 0, imageWidth)
        
        let imageSize = CGSize.init(width: imageWidth, height: imageWidth)
        
        let textSize = self.currentTitle?.sizeSingleLine(font: self.titleLabel?.font ?? UIFont.systemFont(ofSize: 14)) ?? CGSize.zero
        let frameSize = CGSize.init(width: textSize.width, height: CGFloat(ceilf(Float(textSize.height))))
        print(imageSize, textSize, frameSize)
        let totalHeight = imageSize.height + textSize.height + margin
        self.imageEdgeInsets = UIEdgeInsets.init(top: -(totalHeight - imageSize.height), left: 0, bottom: 0, right: -textSize.width)
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageSize.width, bottom: -(totalHeight - textSize.height), right: 0)
        
        
    }
    
    
    
    

}
